---
layout: default
title: Archives
permalink: /archives/
sitemap: true
---

{% assign dates = site.posts | reverse | map: "date" %}

{% assign sinceYear = dates | first | date: "%Y" %}
{% assign untilYear = dates | last  | date: "%Y" %}

{% assign yearMonths = "" | split: ',' %}
{% assign years = "" | split: ',' %}

{% for date in dates %}
    {% assign yearMonth = date | date: "%Y/%m" %}
    {% assign yearMonths = yearMonths | push: yearMonth %}
    
    {% assign year = date | date: "%Y" %}
    {% assign years = years | push: year %}
{% endfor %}

{% assign yearMonths = yearMonths | uniq %}
{% assign years = years | uniq %}

<h2>Archives</h2>
<table class="archives">
    {%- for year in (sinceYear..untilYear) reversed %}
    <tr class="archive-year">
        {%- capture yStr %}{{year}}{%- endcapture %}

        {% if years contains yStr %}
        <td><h3><a href="/{{year}}/">{{ year }}</a></h3></td>
        {%- else -%} 
        <td><h3>{{ year }}</h3></td>
        {%- endif %}

        <td><ol>
            {%- for m in (1..12) %}
            {%- assign month = m | prepend: '00' | slice: -2, 2 %}
            {%- capture yearMonth %}{{year}}/{{month}}{%- endcapture %}
            {%- capture display %}{{yearMonth | date: "%b"}}{%- endcapture %}
            {% if yearMonths contains yearMonth %}
            <li><a href="/{{year}}/{{month}}/">{{ display }}</a></li>
            {%- else -%} 
            <li>{{ display }}</li>
            {%- endif %}
            {%- endfor %}
        </ol></td>
    </tr>
    {%- endfor %}
</table>