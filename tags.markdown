---
layout: page
title: Tags
permalink: /search/label/
sitemap: true
---

{% assign sorted = site.categories | sort %}

<ul class="tag-list">
{% for category in sorted %}
{%- assign cat = category | first -%}
{%- assign size = category[1] | size -%}
{% if size >= 3 %}
<li><a href="/search/label/{{ cat | slugify: 'latin' }}">{{ cat }}</a> ({{ size }})</li>
{%- endif -%}
{% endfor %}
</ul>