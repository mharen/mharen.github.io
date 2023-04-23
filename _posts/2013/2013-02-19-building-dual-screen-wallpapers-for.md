---
layout: post
date: '2013-02-19T21:59:00.002-05:00'
categories:
- powershell
- technology
title: Building Dual-Screen Wallpapers for Windows 7 with PowerShell
---

If you have two monitors you have probably noticed that you can’t easily put a different wallpaper on each screen in Windows 7 (this works out of the box in Windows 8). This is annoying. Sure you can fix this with third party tools, but I want to go a different route.

The key to getting this to work is to recognize that if you choose a background image that is exactly the same size of your combined monitor real estate, it will automatically be stretched between the two screens. For instance, I have two screens, each running at 1280x1024. If I pick a wallpaper that is twice that width, 2560x1024, Windows will do what I want.

Of course the problem then is finding wallpapers that fit that size. Google can help with discovering sites that tailor specifically to this problem.

<strong>

</strong>**But what if you already have single-monitor wallpapers that you want to use? All you really need to do is combine them into a single image.**

<strong>

</strong>![blogger-image--1475083773.jpg](blogger-image--1475083773.jpg)</a>

I did this recently to an [entire collection](http://www.reddit.com/r/pics/comments/qiir8/45_calvin_hobbes_wallpapers_optimized_for/) of Calvin and Hobbes wallpapers. I wanted to show a different comic on each screen, but not always the same two at a time—I wanted to mimic the Windows 8 strategy of seemingly random wallpapers on random screens. 

I combined two images manually, side by side at 2560x1024 once to confirm it would work, and then wrote a few lines of PowerShell to generate every possible combination with the help of the amazing [ImageMagick](http://www.imagemagick.org/) library (specifically the [montage](http://www.imagemagick.org/script/montage.php) command). The idea being that if I just pre-generate all the options, they will appear to be randomly assembled as they cycle through.

Run this script in the dirctory containing all your single wallpapers and it will combine them into the dual-screen variety.

Obviously this is crude--add your own flow control, resume support for large batches, etc....


```cs
$imgs = Get-ChildItem * -include *.jpg,*.png -exclude dual*

for ($i=0; $i -lt $imgs.Length; $i++){ 
    for ($j=0; $j -lt $imgs.Length; $j++){ 
        if($i -eq $j){ continue; }
        $left = $imgs[$i].Name
        $right = $imgs[$j].Name
        $extension = "jpg"

        $destination = [string]::Format("dual/dual-{0}-{1}.{2}", $i, $j, $extension)

        if(Test-Path $destination){
            echo "Skipping $destination"
        }
        else{
            echo "Running: montage -geometry 1280x1024 $left $right $destination"
            montage -geometry 1280x1024 $left $right $destination
        }
    }
}
```


Change that <code>-geometry</code> part to fit your system, obviously, and yeah... just loop over everything :). 