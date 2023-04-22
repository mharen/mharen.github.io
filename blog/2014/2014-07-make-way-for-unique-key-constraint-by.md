---
date: '2014-07-08T14:47:00.002-04:00'
description: ''
published: true
slug: 2014-07-make-way-for-unique-key-constraint-by
tags:
- http://schemas.google.com/blogger/2008/kind#post
- legacy-blogger
time_to_read: 5
title: Make way for a unique key constraint by renaming/updating duplicate rows in
  SQL Server
---

If you want to add a unique key constraint or index to a table that might have duplicate records you're in for some fun. You can either delete the duplicates, or fix the data to make them unique.

Suppose you have a table "Widgets", which *should*&nbsp;be unique on SupplierId and Name, but isn't. This tsql script will update the duplicates by appending a "(1)", "(2)", etc. to the Name, thus satisfying the proposed UKC:<br />
<blockquote class="tr_bq">
<pre style="color: #333333; line-height: 16.25px;"><span style="color: #008800; font-weight: bold;">DECLARE</span> @Widgets <span style="color: #008800; font-weight: bold;">TABLE</span>(
  Id <span style="color: #007020;">INT</span> <span style="color: #008800; font-weight: bold;">NOT</span> <span style="color: #008800; font-weight: bold;">NULL</span> <span style="color: #008800; font-weight: bold;">PRIMARY</span> <span style="color: #008800; font-weight: bold;">KEY</span>, 
  SupplierId <span style="color: #007020;">INT</span> <span style="color: #008800; font-weight: bold;">NOT</span> <span style="color: #008800; font-weight: bold;">NULL</span>, 
  Name NVARCHAR(<span style="color: #0000dd; font-weight: bold;">50</span>) <span style="color: #008800; font-weight: bold;">NOT</span> <span style="color: #008800; font-weight: bold;">NULL</span>)

<span style="color: #008800; font-weight: bold;">INSERT</span> <span style="color: #008800; font-weight: bold;">INTO</span> @Widgets (Id, SupplierId, Name)
<span style="color: #008800; font-weight: bold;">VALUES</span> (<span style="color: #0000dd; font-weight: bold;">1</span>, <span style="color: #0000dd; font-weight: bold;">1</span>, <span style="background-color: #fff0f0;">'WidgetA'</span>),
       (<span style="color: #0000dd; font-weight: bold;">2</span>, <span style="color: #0000dd; font-weight: bold;">2</span>, <span style="background-color: #fff0f0;">'WidgetA'</span>),
       
       (<span style="color: #0000dd; font-weight: bold;">3</span>, <span style="color: #0000dd; font-weight: bold;">3</span>, <span style="background-color: #fff0f0;">'WidgetB'</span>),
       (<span style="color: #0000dd; font-weight: bold;">4</span>, <span style="color: #0000dd; font-weight: bold;">3</span>, <span style="background-color: #fff0f0;">'WidgetB'</span>),
       
       (<span style="color: #0000dd; font-weight: bold;">5</span>, <span style="color: #0000dd; font-weight: bold;">3</span>, <span style="background-color: #fff0f0;">'WidgetC'</span>),
       (<span style="color: #0000dd; font-weight: bold;">6</span>, <span style="color: #0000dd; font-weight: bold;">3</span>, <span style="background-color: #fff0f0;">'WidgetC'</span>),
       (<span style="color: #0000dd; font-weight: bold;">7</span>, <span style="color: #0000dd; font-weight: bold;">3</span>, <span style="background-color: #fff0f0;">'WidgetC'</span>)

<span style="color: #008800; font-weight: bold;">SELECT</span> * <span style="color: #008800; font-weight: bold;">FROM</span> @Widgets

;<span style="color: #008800; font-weight: bold;">WITH</span> cte <span style="color: #008800; font-weight: bold;">AS</span>
(
  <span style="color: #008800; font-weight: bold;">SELECT</span> 
    ROW_NUMBER() OVER(PARTITION <span style="color: #008800; font-weight: bold;">BY</span> SupplierId, Name <span style="color: #008800; font-weight: bold;">ORDER</span> <span style="color: #008800; font-weight: bold;">BY</span> Id) <span style="color: #008800; font-weight: bold;">AS</span> rno, 
    Name
  <span style="color: #008800; font-weight: bold;">FROM</span> @Widgets
)

<span style="color: #008800; font-weight: bold;">UPDATE</span> cte <span style="color: #008800; font-weight: bold;">SET</span> Name = Name + <span style="background-color: #fff0f0;">' ('</span> + <span style="color: #008800; font-weight: bold;">CONVERT</span>(<span style="color: #007020;">varchar</span>(<span style="color: #0000dd; font-weight: bold;">10</span>), rno) + <span style="background-color: #fff0f0;">')'</span>
<span style="color: #008800; font-weight: bold;">WHERE</span> rno&gt;<span style="color: #0000dd; font-weight: bold;">1</span>

<span style="color: #008800; font-weight: bold;">SELECT</span> * <span style="color: #008800; font-weight: bold;">FROM</span> @Widgets</pre>
</blockquote>
You ought to be able to run all that and get these results in SQL Server:<br />
<div class="separator" style="clear: both; text-align: center;">
</div>
<blockquote class="tr_bq">
![query-results.png](query-results.png)</blockquote>
<br />
Adapt to your needs :).