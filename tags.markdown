---
layout: page
title: Tags
permalink: /search/label/
sitemap: true
---

{% assign sorted = site.categories | sort %}

{% for category in sorted %}
{%- assign cat = category | first -%}
 * [{{ cat }}](/search/label/{{ cat | slugify: 'latin' }}) ({{ category[1] | size }})
{% endfor %}