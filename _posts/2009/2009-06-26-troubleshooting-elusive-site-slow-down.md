---
layout: post
date: '2009-06-26T17:00:00.009-04:00'
categories:
- work
- technology
title: Troubleshooting an Elusive Site Slow Down
---


What follows is a long chronological account of a recent problem I ran into at work and how I diagnosed it (but have yet to solve!). I’m posting it here for many reasons:  <ul>   <li>to offer some insight into the mind of an engineer as a problem is dissected and diagnosed </li>    <li>to reiterate the importance of the fundamentals of problem solving </li>    <li>to show that [everybody lies](http://everybody-lies.info/) (even us, to ourselves) and it really does get in the way of problem solving </li>    <li>to show that supporting legacy browsers is a major pain </li>    <li>as a reminder to my future self how to do some of the things documented herein </li> </ul>

Now onto the story.  <hr />

One of the projects I maintain is a corporate website used internally to track all sorts of things. It’s pretty much a web-based data entry system implemented in ASP.NET 3.5 (upgraded from 1.1, 2.0…it’s an oldie).

Recently a user started reporting some odd behavior. She reports that after five minutes of work, one page (out of 10-20) starts slowing down to the point where she can’t use it any longer.

Assuming this was a simple problem, I asked some follow up questions:
<blockquote> 

**Does restarting the browser fix the problem?** Yes (for five minutes).  

**Does it happen all day long?** Yes (not just during busy times).  

**Does it happen just to you?** Yes (but on many machines!).  

**How does the rest of the site work when it happens?** Just fine (it’s only the one page? Crap).  

**How long has this been happening?** At least a month (ouch)  

**What OS/browser are you using?** Windows 2000 with IE6 (ouch)
</blockquote>

So at this point I had no idea—no clue whatsoever—what the problem was. I asked around to see if any of my coworkers had any thoughts and we came up with a plan to narrow down the possibilities.

First, I needed to determine if the slow downs were visible from the server. If not, we could eliminate the server from consideration. The ultimate fix might be in the server, but determining where the slow down occurs should help me pinpoint the problem and ultimately craft a solution.

Bryan suggested I use IIS logs for this. If you didn’t know, IIS (like all web servers) can keep a record of every single hit to your site. This record typically includes all sorts of details about the hit like date, time, IP address, port number, URL, browser, etc.

It turns out there are lots of things you can enable that are not on by default. The key metric I wanted was “Time-Taken”. I enabled it on the server and asked the user to let me know the next time the slow down occurred. Now I waited.

Later that day, it happened again. She sent me an email with the exact time the problem occurred with her IP address. I VPNed into the web server and pulled down copies of the recent log files to peek at (NB: never work with the actual log files—always make copies!).

I honed in on the time she provided (making an adjustment for UTC, which reminds me—I’ve been meaning to do a post about time-zones which will be riveting, I’m sure), and found a bunch of activity from her IP address. Here’s what I found:
<blockquote>   
```cs
<em>Query (normally all on one line):
</em>C:\...>LogParser.exe "
SELECT EXTRACT_FILENAME(TO_LOWERCASE(cs-uri-stem)) AS Page
 ,AVG(time-taken) AS [Average Time Taken]
FROM C:\001_Logs\Slowdown\ex090625.log
WHERE c-ip='10.0.0.2'
GROUP BY TO_LOWERCASE(cs-uri-stem)
ORDER BY AVG(time-taken) DESC"

*Results:*
Page                          Average Time Taken
----------------------------- ------------------
dailyproductionreporting.aspx 876
productionschedule.aspx       375
classifyevents.aspx           282
sourceoflossevents.aspx       240
calendaricon.gif              23
wait.gif                      11

Statistics:
-----------
Elements processed: 7874
Elements output:    6
Execution time:     1.06 seconds
```
</blockquote>
This handy query looks at all 7874 hits in the given log file, groups them by page, and averages the time taken. The user’s complaint focused on classifyevents.aspx and these results clearly show that it’s in the middle of the pack in terms of time—certainly not an outlier as her report would suggest. 
These times are in milliseconds and while I’m not too happy about the top result taking nearly 1 second on average to reach the user, an average result of 282ms for the page in question is perfectly normal.
But wait! What if most of the time the numbers are low, but sometimes they are really bad. OK, let’s just look at the top 20 worst hits to that page:<blockquote>
```cs
*Query (normally all on one line): *
C:\...>LogParser.exe "
SELECT TOP 20
EXTRACT_FILENAME(TO_LOWERCASE(cs-uri-stem)) AS Page,
time-taken AS [Time Taken]
FROM C:\001_Logs\Slowdown\ex090625.log
WHERE c-ip='10.80.85.110'
AND EXTRACT_FILENAME(TO_LOWERCASE(cs-uri-stem))
   = 'classifyevents.aspx'
ORDER BY time-taken DESC"

*Results*
Page                Time Taken
------------------- ----------
classifyevents.aspx 2359
classifyevents.aspx 1875
classifyevents.aspx 765
classifyevents.aspx 703
classifyevents.aspx 593
classifyevents.aspx 546
classifyevents.aspx 515
classifyevents.aspx 500
classifyevents.aspx 468
classifyevents.aspx 468
classifyevents.aspx 453
classifyevents.aspx 453
classifyevents.aspx 437
classifyevents.aspx 421
classifyevents.aspx 406
classifyevents.aspx 390
classifyevents.aspx 375
classifyevents.aspx 375
classifyevents.aspx 375
classifyevents.aspx 375

Statistics:
-----------
Elements processed: 7874
Elements output:    20
Execution time:     1.89 seconds
```
</blockquote>
So it looks like there are a couple slow hits to the page (2.4s, 1.9s) but that’s nothing like the 10-20s the user was seeing. This might be good news as I can now, for the most part, focus on the client—she’s getting the pages quickly, but for some reason things feel slow to her.
All this time, I’ve been running under the assumption that it’s got to be something about this user or her computers that cause the problem. This is based on the fact that we have a couple thousand people use this system every day and surely they aren’t all so patient as to never complain.
The fact that she was running IE6 bothered me a little bit. Everything is tested in IE6, 7, 8 but we don’t spend lots of time doing things over and over again as a single session so I thought that might have something to do with it. The biggest change we made in May that might make trouble with IE6 was the enabling of http compression.
So I turned to my pal Google. and eventually [this page](http://sebduggan.com/posts/ie6-gzip-bug-solved-using-isapi-rewrite) jumped out at me. It’s a set of instructions for disabling http compression for IE6 clients. Interesting…but most of my users use IE6. Here’s the part that peaked my interest (in blue):<blockquote>
```cs
RewriteEngine on
RewriteCond %{HTTP:User-Agent} MSIE\ [56]
<strong><span style="color: rgb(0, 0, 255);">RewriteCond %{HTTP:User-Agent} !SV1</span>
</strong>RewriteCond %{REQUEST_URI} \.(css|js)$
RewriteHeader Accept-Encoding: .* $1
```
</blockquote><blockquote>
What this does is look at the <kbd>User-Agent</kbd> header of any incoming request. If it’s IE5 (just to be safe) or IE6, and the **<span style="color: rgb(0, 0, 255);">User-Agent doesn’t contain <kbd>SV1</kbd> (which indicates IE6 SP2)</span>**, and if the requested page is a .css or .js file, then we rewrite the <kbd>Accept-Encoding</kbd> header to a blank string (normally it would be <kbd>gzip/deflate</kbd>, which indicates that the browser can handle those compression methods).</blockquote>
Aha! Maybe most of the clients are running IE6SP2, but she’s running IE6-sans-sp2! I checked the logs again and looked at her user agent string, hoping it’d be IE6-sans-SP2:<blockquote>
Mozilla/4.0 (compatible; **MSIE 6.0**; Windows NT 5.0; .NET CLR 1.1.4322)</blockquote>
Awesome—no “SV1” so now, let’s just make sure that there aren’t many people in the same boat (if there were and this was the problem, I’d have more reports of the slow down). I turned to LogParser again, this time extracting user-agent strings and a count of how many times they came up from 14 days of logs:<blockquote>
```cs
<em>Query (normally all on one line):
</em>C:\...>LogParser.exe "
SELECT [cs(User-Agent)],Count(*)
FROM C:\001_Logs\ex090613\*.log
INTO UserAgents.csv
GROUP BY [cs(User-Agent)]
ORDER BY COUNT(*) DESC" -i:IISW3C -o:csv

*Results:*
<strong>Count   User Agent (cleaned up with Excel)
</strong>279859  MSIE 6.0 Windows NT 5.1 SV1
249747  MSIE 6.0 Windows NT 5.0
162945  MSIE 6.0 Windows NT 5.1 SV1
152893  MSIE 6.0 Windows NT 5.1 SV1
84220   MSIE 6.0 Windows NT 5.1 SV1
44532   MSIE 6.0 Windows NT 5.0
41528   MSIE 6.0 Windows NT 5.2 SV1
38485   MSIE 7.0 Windows NT 5.1
24308   MSIE 6.0 Windows NT 5.1 SV1
21001   MSIE 6.0 Windows NT 5.1 SV1
19200   Windows XP 5.1 Java/1.4.2_08
17536   MSIE 6.0 Windows NT 5.2
14766   MSIE 6.0 Windows NT 5.1 SV1
14440   MSIE 6.0 Windows NT 5.1 SV1
11835   MSIE 6.0 Windows NT 5.1
10561   MSIE 7.0 Windows NT 5.1 Trident/4.0
8944    Windows 2000 5.0 Java/1.4.2_04
7616    MSIE 6.0 Windows NT 5.0
6399    MSIE 6.0 Win32
5886    MSIE 6.0 Windows NT 5.1 SV1
5384    MSIE 6.0 Windows NT 5.1 SV1
4931    MSIE 6.0 Windows NT 5.1 SV1
4675    MSIE 6.0 Windows NT 5.1 SV1
4260    MSIE 6.0 Windows NT 5.1 SV1
3859    MSIE 6.0 Windows NT 5.0
3647    MSIE 6.0 Windows NT 5.1 SV1
3295    MSIE 7.0 Windows NT 5.1
3146    MSIE 6.0 Windows NT 5.1 SV1
3027    MSIE 6.0 Windows NT 5.1 SV1
2917    MSIE 6.0 Windows NT 5.1 SV1
2835    MSIE 6.0 Windows NT 5.1 SV1
2283    Windows XP 5.1 Java/1.6.0_07
2211    Windows XP 5.1 Java/1.6.0_13
2040    MSIE 6.0 Windows NT 5.1 SV1
1971    MSIE 6.0 Windows NT 5.0
1560    Windows 2003 5.2 Java/1.4.2_04
1237    MSIE 7.0 Windows NT 5.1 GTB6
1191    MSIE 6.0 Windows NT 5.1 SV1
1179    MSIE 6.0 Windows NT 5.2 SV1
1141    MSIE 6.0 Windows NT 5.1 SV1 3P_UVRM 1.0.22.0
1111    MSIE 6.0 Windows NT 5.1 SV1
1019    Windows XP 5.1 Java/1.4.2_07
1011    Windows XP 5.1 Java/1.5.0_06
872     MSIE 6.0 Windows NT 5.1
857     MSIE 6.0 Windows NT 5.1 SV1 GTB6
849     MSIE 6.0 Windows NT 5.1
826     MSIE 6.0 Windows NT 5.1 SV1
772     MSIE 6.0 Windows NT 5.1 SV1
759     MSIE 7.0 Windows NT 5.1
752     Windows XP 5.1 Java/1.4.2_03
740     MSIE 6.0 Windows NT 5.1 SV1
691     Windows XP 5.1 Java/1.5.0_04
658     MSIE 6.0 Windows NT 5.1 SV1
640     Windows XP 5.1 Java/1.6.0_12
602     MSIE 6.0 Windows NT 5.1 SV1 MS-RTC LM 8
595     Windows 2000 5.0 Java/1.6.0_11
507     MSIE 6.0 Windows NT 5.1 SV1
485     MSIE 6.0 Windows NT 5.0
469     Windows XP 5.1 Java/1.5.0_11
432     Windows 2000 5.0 Java/1.5.0_11
379     MSIE 6.0 Windows NT 5.1 SV1 R1 1.3
377     MSIE 6.0 Windows NT 5.1 SV1
372     Windows XP 5.1 Java/1.6.0_02
371     Windows XP 5.1 Java/1.6.0_11
328     MSIE 6.0 Windows NT 5.1 SV1
326     MSIE 6.0 Windows NT 5.1 SV1 GTB6
290     MSIE 6.0 Windows NT 5.1 SV1
271     Windows 2000 5.0 Java/1.5.0_06
204     MSIE 6.0 Windows NT 5.1 SV1
184     Windows XP 5.1 Java/1.6.0_14
176     Windows XP 5.1 Java/1.5.0_09
152     Windows XP 5.1 Java/1.6.0_03
110     MSIE 6.0 Windows NT 5.1 SV1 GTB6
109     Windows XP 5.1 MSIE 7.0.5730.13
108     Windows XP 5.1 Java/1.5.0_07
92      MSIE 6.0 Windows NT 5.1 SV1
92      Windows XP 5.1 Java/1.6.0_10
82      MSIE 6.0 Windows NT 5.1 SV1
66      Windows 2000 5.0 Java/1.6.0_07
65      Windows 2000 5.0 Java/1.6.0_05
65      MSIE 6.0 Windows NT 5.1 SV1
55      MSIE 6.0 Windows NT 5.1 SV1 MS-RTC LM 8
51      MSIE 6.0 Windows NT 5.1 SV1 GTB6
50      Windows XP 5.1 Java/1.6.0_05
42      Jakarta Commons-HttpClient/3.0.1
41      Windows 2000 5.0 Java/1.6.0_03
32      MSIE 6.0 Windows NT 5.1 SV1
30      Windows 2003 5.2 Java/1.5.0_11
26      MSIE 6.0 Windows NT 5.1 SV1
26      Windows XP 5.1 MSIE 7.0.5730.13
20      MSIE 6.0 Windows NT 5.1 SV1 GTB6
17      MSIE 6.0 Windows NT 5.1 SV1
15      MSIE 8.0 Windows NT 5.1 Trident/4.0
13      Windows XP 5.1 Java/1.5.0
10      Gecko/2009060215 Firefox/3.0.11
10      MSIE 6.0 Windows NT 5.1 SV1  MS-RTC LM 8
9       MSIE 6.0 Windows NT 5.1 SV1  
```
</blockquote>
Since there are so many different ways a client can report themselves, I dumped the results into excel and used some PivotTable magic to get this:
<table border="0"><tbody><tr>
     <td>**Browser**</td>
     <td align="right">**% of total**</td>
   </tr><tr>
     <td>IE6SP2</td>
     <td>65.81</td>
   </tr><tr>
     <td>IE6</td>
     <td>26.74</td>
   </tr><tr>
     <td>IE7</td>
     <td>4.21</td>
   </tr><tr>
     <td>JAVA</td>
     <td>3.23</td>
   </tr><tr>
     <td>Unknown</td>
     <td>0.01</td>
   </tr><tr>
     <td>FF</td>
     <td>0.00</td>
   </tr></tbody></table>
I dumped that into the [Google Charts API](http://code.google.com/apis/chart/) to get this:![chart?cht=p&amp;chs=400x275&amp;chd=s:9ZEDAA&amp;chl=IE6SP2%7CIE6%7CIE7%7CJAVA%7CUnknown%7CFF&amp;chtt=Browser%20Distribution](chart?cht=p&amp;chs=400x275&amp;chd=s:9ZEDAA&amp;chl=IE6SP2%7CIE6%7CIE7%7CJAVA%7CUnknown%7CFF&amp;chtt=Browser%20Distribution)

It’s not the overwhelming result I had hoped for with 27% of traffic over the last 2 weeks coming from the defunct browser I was trying to blame. Again, it seems unlikely that 27% of users are experiencing the same problem without reporting it.
But what the hell, I turned off http compression on one of the web servers anyway. I had no other leads at this point so I might as well. As expected, though, the user reported that it didn’t help.
It’d still be nice to narrow this down to a browser so I’ve asked the user to see if they can get a hold of another machine with IE7. If things work well on that machine at least I’ll know it’s either her machine or possibly her machine plus her browser.
It’s also very possible it’s something *she’s* doing. Maybe she clicks things just the wrong way or performs some operation that others don’t.<hr />
It’s at this point where I started gathering all my notes together and reviewing everything to see what I missed. And I missed something huge.
I took the user’s comments at face value and coupled them with a very strong assumption. Here are the predicates that led me *away *from the diagnosis:<ol><li>User: the problem only affects one page </li>  <li>User: when the problem occurs on said page, other pages are fine </li>  <li>Me: if all users on similar machines were having this problem, too, there’d be more people complaining about it. </li></ol>
I might be counting my chickens a little early yet but I’m pretty sure I have this problem figured out, and each of those three “facts” are wrong.
After talking with the user, she revealed that other areas of the site *do* slow down, just “not as bad”. Number 1 and 2 gone.
When reviewing her computer (Windows 2000, IE6, tiny amount of memory), and recalling the amount of patience users have with this product (a lot), I realized that assumption 3 isn’t very solid either.
Once I ignored those three items, it was obvious that the application itself had a problem that could likely be reproduced by me, in house. So that’s what I did—**something I should have tried in the very beginning.** I dug out an ancient laptop with Windows 2000 and IE6SP1 and started running the app. Much to my surprise (though I guess I should have expected it by this point), after 10 minutes, the app started to crawl. Badly.
Being the computer person, I immediately saw why in the little hard drive light. Internet Explorer was leaking memory like crazy and eventually, when the system ran out, caused the disk to thrash as Windows actively consumed and grew the page file. Watching the task manager, I could see a 1-2mb jump in memory usage with *every click*.
![yikes%5B6%5D.png](yikes%5B6%5D.png) I tore the page apart and was able to create a simple page to reproduce the problem and share. The above chart (generated with [Perfmon](http://adminfoo.net/2007/04/windows-perfmon-top-ten-counters.html)—a sweet tool on most windows machines) shows that simple page being executed over a period of about 3 minutes. You can see memory usage rose to about 90%, with the page file in tow. Each dropped quite suddenly when I terminated Internet Explorer.

Here’s the simple page that produces the above behavior in IE6SP1 (but not Opera 9.5, Firefox 3.5, Chrome 2, or Internet Explorer 8):<blockquote></blockquote><blockquote>
```cs
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<link type="text/css" href="jquery-ui-1.7.1.custom.css" rel="stylesheet" />
<script type="text/javascript" src="jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="jquery-ui-1.7.1.custom.min.js"></script>
<script type="text/javascript">
   $(document).ready(function() {
       $('.DatePicker:enabled').datepicker();
       setTimeout("Form1.submit();", 500);
   });
</script>
</head>
<body >
<form id='Form1' action='LeakTest2.htm'>
   <input class='DatePicker' />
   <input type='button' value<span class="kwrd">='Refresh'
         </span> onclick='Form1.submit();' />
</form>
</body>
</html>
```
</blockquote>
The problem is jquery. It's not really jquery's fault--this is a [documented bug](http://support.microsoft.com/kb/929874) with IE that's being triggered by jQuery. I hopped onto Google and started looking for solutions to “[IE6 jquery memory leak](http://www.google.com/search?q=IE6+jquery+memory+leak)”. I made another bad assumption when I wagered that there’d be an easy fix for this problem. 
After trying a bunch of things, I opened a [question on Stackoverflow](http://stackoverflow.com/questions/1051090/how-can-i-control-ie6jqueryjquery-ui-memory-leaks) and that’s where I stand now. My leads are currently:<ol><li>Keep googling for a solution </li><li>Wait for someone to answer my question on SO </li><li>Post on the jquery mailing list for help</li><li>Learn a lot more about IE6’s memory leaks and attempt to patch jQuery myself </li></ol>
When I resolve this problem, I’ll post a follow up. Hopefully soon!

---

## 2 comments captured from [original post](https://blog.wassupy.com/2009/06/troubleshooting-elusive-site-slow-down.html) on Blogger

**Math Zombie said on 2009-06-28**

This is like House. Except very, very lame for non-computer people. I hope you solve it.

**Michael Haren said on 2009-06-28**

So is the life of a computer engineer...

