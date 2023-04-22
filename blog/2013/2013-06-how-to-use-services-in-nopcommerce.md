---
date: '2013-06-18T10:25:00.001-04:00'
description: ''
published: true
slug: 2013-06-how-to-use-services-in-nopcommerce
tags:
- NopCommerce
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Code
- legacy-blogger
time_to_read: 5
title: "How to use services in a NopCommerce Plugin that it doesn\u2019t use by default"
---

<p>Suppose you want to override some behavior in a NopCommerce service via a plugin. You would start by subclassing the service that has the behavior you want to override. But what if your new code requires access to something that the existing service doesn’t know about? </p> <p>The answer turns out to be pretty simple: <strong>just add it to your constructor, and the dependency resolver will figure it out for you.</strong> (You don’t need to worry about it.)</p> <p>Here’s an example. I want to override the PictureService. So I started with this:</p><pre class="csharpcode">    <span class="kwrd">public</span> <span class="kwrd">class</span> MyPictureService : PictureService
    {
        <span class="rem">// constructor</span>
        <span class="kwrd">public</span> MyPictureService(
            IRepository&lt;Picture&gt; pictureRepository, 
            IRepository&lt;ProductPicture&gt; productPictureRepository,
            ISettingService settingService, 
            IWebHelper webHelper, 
            ILogger logger, 
            IEventPublisher eventPublisher, 
            MediaSettings mediaSettings,
            : <span class="kwrd">base</span>(pictureRepository, productPictureRepository, settingService, 
                webHelper, logger, eventPublisher, mediaSettings)
        {
        }

        <span class="rem">// my overrides</span>
    }</pre>
<p>So you can see that we get a lot of stuff by default. If we want to use any of those services, we need to create class variables for them (the base class marks them private), like so:</p><pre class="csharpcode">    <span class="kwrd">public</span> <span class="kwrd">class</span> MyPictureService : PictureService
    {
        <span class="kwrd">protected</span> <span class="kwrd">readonly</span> ILoggerService Logger;

        <span class="rem">// constructor</span>
        <span class="kwrd">public</span> MyPictureService(
            IRepository&lt;Picture&gt; pictureRepository, 
            IRepository&lt;ProductPicture&gt; productPictureRepository,
            ISettingService settingService, 
            IWebHelper webHelper, 
            ILogger logger, 
            IEventPublisher eventPublisher, 
            MediaSettings mediaSettings,
            : <span class="kwrd">base</span>(pictureRepository, productPictureRepository, settingService, 
                webHelper, logger, eventPublisher, mediaSettings)
        {
            Logger = logger;
        }

        <span class="rem">// my overrides</span>
    }</pre>
<p>And if I want to add a service or repo that’s not there already? Just add it:</p><pre class="csharpcode">    <span class="kwrd">public</span> <span class="kwrd">class</span> MyPictureService : PictureService
    {
        <span class="kwrd">protected</span> <span class="kwrd">readonly</span> ILoggerService Logger;
        <span class="kwrd">protected</span> <span class="kwrd">readonly</span> ISpecificationAttributeService SpecificationAttributeService;

        <span class="rem">// constructor</span>
        <span class="kwrd">public</span> MyPictureService(
            IRepository&lt;Picture&gt; pictureRepository, 
            IRepository&lt;ProductPicture&gt; productPictureRepository,
            ISettingService settingService, 
            IWebHelper webHelper, 
            ILogger logger, 
            IEventPublisher eventPublisher, 
            MediaSettings mediaSettings,
            <span class="rem">// just add it to the constructor!</span>
            ISpecificationAttributeService specificationAttributeService)
            : <span class="kwrd">base</span>(pictureRepository, productPictureRepository, settingService, 
                webHelper, logger, eventPublisher, mediaSettings)
        {
            Logger = logger;

            <span class="rem">// and use it</span>
            SpecificationAttributeService = specificationAttributeService;
        }

        <span class="rem">// my overrides</span>
    }</pre>
<p>Have fun!</p>