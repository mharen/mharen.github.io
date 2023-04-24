---
layout: post
date: '2013-06-18T10:25:00.001-04:00'
categories:
- nopcommerce
- code
title: How to use services in a NopCommerce Plugin that it doesn't use by default
---

Suppose you want to override some behavior in a NopCommerce service via a plugin. You would start by subclassing the service that has the behavior you want to override. But what if your new code requires access to something that the existing service doesn’t know about? 

The answer turns out to be pretty simple: **just add it to your constructor, and the dependency resolver will figure it out for you.** (You don’t need to worry about it.)

Here’s an example. I want to override the PictureService. So I started with this:
```cs
public class MyPictureService : PictureService
{
    // constructor
    public MyPictureService(
        IRepository<Picture> pictureRepository, 
        IRepository<ProductPicture> productPictureRepository,
        ISettingService settingService, 
        IWebHelper webHelper, 
        ILogger logger, 
        IEventPublisher eventPublisher, 
        MediaSettings mediaSettings,
        : base(pictureRepository, productPictureRepository, settingService, 
            webHelper, logger, eventPublisher, mediaSettings)
    {
    }

    // my overrides
}
```


So you can see that we get a lot of stuff by default. If we want to use any of those services, we need to create class variables for them (the base class marks them private), like so:

```cs
public class MyPictureService : PictureService
{
    protected readonly ILoggerService Logger;

    // constructor
    public MyPictureService(
        IRepository<Picture> pictureRepository, 
        IRepository<ProductPicture> productPictureRepository,
        ISettingService settingService, 
        IWebHelper webHelper, 
        ILogger logger, 
        IEventPublisher eventPublisher, 
        MediaSettings mediaSettings,
        : base(pictureRepository, productPictureRepository, settingService, 
            webHelper, logger, eventPublisher, mediaSettings)
    {
        Logger = logger;
    }

    // my overrides
}
```

And if I want to add a service or repo that’s not there already? Just add it:
```cs
public class MyPictureService : PictureService
{
    protected readonly ILoggerService Logger;
    protected readonly ISpecificationAttributeService SpecificationAttributeService;

    // constructor
    public MyPictureService(
        IRepository<Picture> pictureRepository, 
        IRepository<ProductPicture> productPictureRepository,
        ISettingService settingService, 
        IWebHelper webHelper, 
        ILogger logger, 
        IEventPublisher eventPublisher, 
        MediaSettings mediaSettings,
        // just add it to the constructor!
        ISpecificationAttributeService specificationAttributeService)
        : base(pictureRepository, productPictureRepository, settingService, 
            webHelper, logger, eventPublisher, mediaSettings)
    {
        Logger = logger;

        // and use it
        SpecificationAttributeService = specificationAttributeService;
    }

    // my overrides
}
```


Have fun!