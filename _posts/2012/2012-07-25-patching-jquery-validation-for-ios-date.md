---
layout: post
date: '2012-07-25T20:57:00.001-04:00'
categories:
- code
- technology
title: Patching jQuery Validation for the iOS Date Picker
---

If you’re trying to use [native datepickers](../../2012/07/let-browser-handle-datepicker-if-it-can.html) with `<input type="date"/>` in your app *and the jQuery Validate plugin for validation*, here's something you probably need to know.

I discovered, when testing my app on an iPhone, that the jQuery Validate plugin wasn’t working on my date inputs. It would always mark them invalid. Huh.

I dug into it and found that [this is how](https://github.com/jzaefferer/jquery-validation/blob/907467e874e8812ee9547cc7073d793dfd253f2f/jquery.validate.js#L1107) it determines if a date is valid:  

```js
// http://docs.jquery.com/Plugins/Validation/Methods/date
date: function(value, element) {
    return this.optional(element) || !/Invalid|NaN/.test(new Date(value));
}
```

That is, it just passes the string to be tested to the Javascript “Date()” constructor and checks to see if something back comes back.


OK...what’s going on then? I [logged the value](http://jsfiddle.net/mharen/EXsKA/) of the input and confirmed that it’s in the sensible ISO format I thought it’d be in:

```
2012-07-17 
```

After an embarassingly large amount of hunting in the wrong places, I eventually uncovered that validation code above and simple ran it:

```
2012-07-18 fiddle.jshell.net:23
Tue Jul 17 2012 20:00:00 GMT-0400 (Eastern Daylight Time) 
```

OK, so that makes sense in Chrome—*the validation works in Chrome*. **So I ran that in iOS and...it failed!** Here’s my commit message after I figured this out:

```
// patch the validate "date" method to accomodate iOS-style ISO dates
// because some browsers (including Chrome 19+ and iOS) support HTML5 date
// inputs, but some of those same browsers' Date() implementation
// doesn't parse them... WUT?! I'm looking at you iOS
```

This is madness. iOS 5’s `Date()` can’t parse what has got to be the easiest to parse date string ever.

Enough grumbling...what do we do? My first solution involved using the other date parse rule in the Validate plugin: 

```js
// http://docs.jquery.com/Plugins/Validation/Methods/dateISO
dateISO: function(value, element) {
    return this.optional(element) || /^\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2}$/.test(value);
},
```

That worked, since it just matches a simple `yyyy-MM-dd` pattern. I (of course) do server side validation, too, so I’m not worried about a user entering a syntactically correct, but practically incorrect date like `2012-02-30`.

Rather than change all my inputs to use this alternative rule, or mess with my validation routine (I’m using the unobtrusive flavor)—I’d really like to just leave all that be, I decided to patch the first validator like so:


```js
if ($.validator) {
    var originalDateValidator1 = $.validator.methods.date;
    var originalDateValidator2 = $.validator.methods.dateISO;

    $.validator.methods.date = function (value, element) {
        var isValidDate =
            originalDateValidator1.apply(this, arguments) ||
            originalDateValidator2.apply(this, arguments);

        return isValidDate;
    };
}
```

Quite simply, this just runs both of the date checkers and returns true if either of them pass.

In addition to not having to actually change any of my HTML, this code sits outside the library itself (it’s in my [global.js](https://github.com/mharen/service-tracker/blob/1bac669089a4b2c6c4c472a6c972073353726954/service-tracker-mvc/Scripts/script.js#L20) file) so I can still update my plugins or load them from CDNs without fear. Oh, and if a user enters a date in the usual MM/dd/yyyy format in a browser that doesn’t support the native datepicker, the validation will still pass.

Hopefully Apple fixes this issue...

---

### 5 comments

**Kikoanis said on 2013-01-24**

Thank you, you saved my day

**Mike Causer said on 2013-07-10**

Brilliant, thanks

**Unknown said on 2013-08-09**

I've been having issue where the validation plugin won't validate a date input type that is set to required, on iPad only. Even after the date is selected from the native iOS datepicker, the plugin still marks the input with an error and says it is required.

**bkwdesign said on 2013-11-12**

This saved my bacon. (Along with a tip from stackoverflow to disable my jquery UI timepicker on iOS by using a line of modernizr code)

Thanks, Man!

**Unknown said on 2015-07-22**

Saved my day, thanks!!

Comments closed
{: .comments-closed }