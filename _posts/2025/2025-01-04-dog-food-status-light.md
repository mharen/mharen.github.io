---
layout: post
date: "2025-01-04"
categories:
    - technology
    - code
    - homelab
    - family
title: Automatic dog food status light
---

### The goal: feed the dogs 2x/day

<p>{% imagesize /assets/2025/puppies-bed.jpeg:img alt="two dogs on a green dog bed. One is a beagle puppy looking at the other one, who is a black puggle mix" %}</p>

Ideally my two pups would be fed roughly the right amount of food at roughly the right time, twice a day.

And we'd all be sure that it happened.

### The problem: did someone feed the dogs?

We faced uncertainty nearly every day. With humans coming and going to various things, it was often difficult to
know and this surely led to under- and over-feeding.

This is a classic systems/process problem (with perhaps a dash of volunteer's dilemma): the way we managed dog feeding
was designed to ellicit bad outcomes, and eliminating those bad outcomes (i.e. under/over feeding) requires a change to
the system. "Trying harder" won't cut it. (More on this [at the end](#an-aside-on-systemic-problems).)
{: .pq}

### Some ideas

As a family we talked about possible solutions to this problem:

-   Designate one caretaker as the person responsible for making sure the dogs get fed each day
-   Make a note when they're fed
-   Pre-measure their food for the week, and pour it out of the day's marked container each day
-   Change nothing (the dogs will tell us when we forget!)

We tried all of these things and they all helped a little. But they all had significant shortcomings:

-   Each person is busy and has a relatively chaotic schedule
-   People forget, and it's hard to fill in the gaps without knowing if the gap exists or not
-   Keeping notes and/or pre-measuring is extra work and isn't necessarily reliable
-   My pups are unreliable witnesses

### A real solution

I knew about [medicine bottles][6] that show time-since-last-open and thought something like that would be wonderful.
What we have finally arrived at is a solution that completely solves our problem with the following results:

-   We have a status light that anyone can read at a glance: it turns red when the dogs need fed, and turns green when
    they've recently beed fed
-   The status light updates automatically with no extra work (very important!)

<video autoplay loop muted playsinline width="1280" height="720" aria-label="A looping animation that shows a web page loading a grid of 24 contact cards. The contact cards quickly fade into view at slightly different times, over a period of about 1 second.">
  <source src="/assets/2025/dog-food-light.mp4" type="video/mp4">
  <source src="/assets/2025/dog-food-light.webm" type="video/webm">
  <source src="/assets/2025/dog-food-light.ogg" type="video/ogg">
  <img src="/assets/2025/dog-food-light.gif" loading="lazy" />
</video>

It's basically an [andon light][1]/[stack light][5], powered by Home Assistant and two components: an open/close sensor
on the dog food container and a smart RGB night light.

### Build details

I used an [Aqara door/window sensor][3] ($15) attached to the lid of my dog food container, and an [RGB smart night
light][4] ($30). Then I set up an automation in Home Assistant to do the following:

1. Turn the light on, set to RED <span class="nodark">🔴</span>, at breakfast and dinner time
2. Set the light GREEN <span class="nodark">🟢</span> when a feeding occurs
3. Turn the light OFF <span class="nodark">⚪️</span> two hours after a feeding

Here's the heavily annotated `yaml`:

```yaml
alias: Set dog food status
description: ""
trigger:
    # trigger in the morning and evening so we can turn
    # the light ON and RED for breakfast and dinner
    - alias: Morning
      platform: time
      at: "07:00:00"
      id: morning
    - alias: Evening
      platform: time
      at: "18:00:00"
      id: evening
      # trigger when the dog food container changes to
      # "closed" so we set the light to GREEN
    - platform: state
      entity_id:
          - binary_sensor.open_close_xs_sensor_window_door_is_open_3
      to: "off"
      alias: Fed
      id: fed
action:
    # I found that changing the light was more reliable if
    # I always turned it off first
    - service: light.turn_off
      metadata: {}
      data: {}
      target:
          entity_id: light.dog_food_status_light_light
      alias: Light off
    - if:
          # if trigger=fed, i.e. food container was just closed,
          # set the light to GREEN...
          - condition: trigger
            id:
                - fed
      then:
          - alias: Turn light green
            service: light.turn_on
            metadata: {}
            data:
                rgb_color:
                    - 0
                    - 249
                    - 0
                brightness_pct: 25
            target:
                entity_id: light.dog_food_status_light_light
          # ...and wait 2 hours...
          - delay:
                hours: 2
                minutes: 0
                seconds: 0
                milliseconds: 0
          # ...then turn it off. This way humans can tell long
          # after feeding time that everything is cool
          - service: light.turn_off
            metadata: {}
            data: {}
            target:
                entity_id: light.dog_food_status_light_light
      else:
          # else, the trigger is the breakfast or dinner timer
          # so just turn it red
          - alias: Turn light red
            service: light.turn_on
            metadata: {}
            data:
                rgb_color:
                    - 255
                    - 38
                    - 0
                brightness_step_pct: 100
            target:
                entity_id: light.dog_food_status_light_light
mode: single
```

I cannot express just how helpful this has been <span class="nodark">😊</span>. And since it's all in Home Assistant, it
shows up on my dashboard. Here you can see that they were last fed an hour ago, and keeps history, though that's not
really necessary:

<div class="--tile-300">
    <picture>
        <source srcset="/assets/2025/dog-food-dashboard.png" media="(prefers-color-scheme: dark)">
        <img class="border" width="888" height="764" src="/assets/2025/dog-food-dashboard-light.png" alt='A dashboard titled "Kitchen" that shows light switches, humidity, temperature, and "Dog Food Container", last closed 1 hour ago' />
    </picture>
    <picture>
        <source srcset="/assets/2025/dog-food-log.png" media="(prefers-color-scheme: dark)">
        <img class="border" width="1124" height="1038" src="/assets/2025/dog-food-log-light.png" alt='A log titled "Dog Food Container" that shows it was last closed 1 hour ago, with earlier entries showing opens and closes' />
    </picture>
</div>

Happy humans and happy pups.

<p>{% imagesize /assets/2025/puppies-jammies.jpeg:img alt="The same two dogs from the earlier photo, but older. They are wearing pajamas with cartoon zoo animals on them. They are standing alert on a tile floor and the beagle has one ear turned back" %}</p>

### An aside on systemic problems

My most important professional skill is identifying and solving systemic problems. As W. Edwards Deming explains in _Out
of the Crisis_, issues that occur _within_ a system need to be addressed by _changing the system_:

> Eighty-five percent of the reasons for failure are **deficiencies in the systems and process** rather than the
> employee. The role of management is to change the process rather than badgering individuals to do better

And L. David Marquet writes in _Leadership Is Language_:

> We need to always remember that the organization is perfectly tuned to deliver the behavior we see, and **people's
> behaviors are the perfect result of the organization's design**. As individuals, we should embrace our responsibility
> for being the best we can be within the design of the organization. But as leaders, **our responsibility is to design
> the organization so that individuals can be the best versions of themselves.**

See also: [**Upstream**][2] by Dan Heath.

Sometimes (much to my family's chagrin), I apply these lessons at home too.

[1]: https://en.wikipedia.org/wiki/Andon_(manufacturing) "Andon (manufacturing)"
[2]: https://heathbrothers.com/books/upstream/ "Upstream book"
[3]: https://www.aqara.com/us/product/door-and-window-sensor/ "Aqara window/door sensor"
[4]: https://3reality.com/product/matter-smart-color-night-light/ "Smart Color Night Light"
[5]: https://en.wikipedia.org/wiki/Stack_light "Stack light"
[6]: https://www.timercap.com "Timer Cap medicine bottles"
