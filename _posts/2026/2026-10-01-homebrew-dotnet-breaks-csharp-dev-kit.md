---
layout: post
date: "2026-10-01"
categories:
    - technology
    - code
title: "Fixed: Homebrew's dotnet silently breaks C# Dev Kit in VSCode"
---

Go-to-definition, find references, and IntelliSense all quit working in VS Code on a .NET 10 project. Syntax highlighting was fine, `dotnet build` was fine, and the project loaded without complaint. The only sign of trouble was buried in _Output > C# Dev Kit_:

```
Using existing .NET runtime at "/opt/homebrew/Cellar/dotnet/10.0.401/libexec/dotnet"
.NET server STDERR: Failed to load .../libhostfxr.dylib, error: dlopen(...):
  code signature ... not valid for use in process:
  mapping process and mapped file (non-platform) have different Team IDs
.NET server exited with 130
```

Here's what's going on. The Dev Kit language server is signed by Microsoft. Homebrew's `dotnet` **formula** is a Homebrew-built bottle, ad-hoc signed with no Team ID:

```
$ codesign -dv /opt/homebrew/Cellar/dotnet/10.0.401/libexec/host/fxr/10.0.12/libhostfxr.dylib
Signature=adhoc
TeamIdentifier=not set
```

macOS won't load a library into a signed process when the Team IDs don't match, so the server died on startup every time. No server, no project system—and without that, none of the features that make the extension worth installing.

## Where it came from

I never installed it on purpose. I already had .NET from the `dotnet-sdk` **cask**, which is a different thing entirely—a cask just runs Microsoft's official `.pkg`, so it lands in `/usr/local/share/dotnet`, properly signed:

```
Authority=Developer ID Application: Microsoft Corporation (UBF8T346G9)
TeamIdentifier=UBF8T346G9
```

The formula came in as a dependency:

```
$ brew uses --installed dotnet
powershell
```

Installing PowerShell from Homebrew drags in Homebrew's .NET along with it. And since `/opt/homebrew/bin` comes first on my `PATH`, that copy shadowed the good one. Dev Kit found it first.

## The fix

Drop the formula. PowerShell was its only dependent, so uninstalling that takes care of both at once:

```bash
brew uninstall powershell
# ==> Autoremoving 1 unneeded formula:
# dotnet
```

Then put PowerShell back as a .NET global tool. It runs on the SDK you already have instead of dragging in a second one:

```bash
dotnet tool install --global PowerShell
```

Verify you're left with the signed copy:

```bash
$ which dotnet
/usr/local/share/dotnet/dotnet
```

If you actually need Homebrew's `dotnet` for something else, leave it alone and point the extensions at the good install in `settings.json`:

```json
"dotnetAcquisitionExtension.sharedExistingDotnetPath": "/usr/local/share/dotnet/dotnet"
```

Either way, fully quit and relaunch VS Code afterward. A window reload isn't enough—the .NET Install Tool caches whichever runtime it resolved.
