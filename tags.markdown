---
layout: default
title: Tags
permalink: /search/label/
sitemap: true
---

<h2>Tags</h2>

{% assign sorted = site.categories | sort %}

<ul class="tag-list none">
{% for category in sorted %}
{%- assign cat = category | first -%}
{%- assign size = category[1] | size -%}
{% if size >= 3 %}
<li><a href="/search/label/{{ cat | slugify: 'latin' }}">{{ cat }}</a> ({{ size }})</li>
{%- endif -%}
{% endfor %}
</ul>