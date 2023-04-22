---
date: '2005-09-22T03:04:00.000-04:00'
description: ''
published: true
slug: 2005-09-intelligent-cat-door
categories:
- Technology
time_to_read: 5
title: Intelligent Cat Door
---

Here's another cool use of imaging that I read about last year: [the intelligent cat door](http://www.quantumpicture.com/Flo_Control/Flo_Control_1/flo_control_1.htm" title="title). A guy made this in his spare time to solve an annoying problem. Apparently, his cat had been bringing dead rodents into the house with him. Obviously this was unpleasant. What he did was surprisingly simple.

He realized that he could tell if his cat was dragging in an unwanted rodent with him by looking at the cat's silhouette. He setup a computer to capture images of the cat's silhouette as he waited by the cat-door. Then a relatively simple comparison algorithm is used to determine if the new image represents the cat with or without a rodent. If the cat is rodent-free, the computer triggers the solenoid-controlled door so the cat can enter. If the computer detects that the cat is carrying an unwanted critter, the door remains locked and the cat is forced to wander away.

The beauty of this design is that it is built using mostly off the shelf components. First, consider the solenoid door. These already exist in the form of proximity triggersâ€”typically you would attach a beacon to your pet's collar which electronically unlocks the door only when *your* pet approaches, keeping other animals out. As your pet walks away from the door, it automatically locks. Brilliant!

The "imaging device" is just a webcamâ€”simple enough. [Warning: geek-stuff coming] The comparison algorithm could be something like a bitwise compare or (even easier) a GZip compare to a reference image. If my memory serves, nothing more complex like feature vectors + distance functions was required.