---
layout: default
---

<ol class="none comfortable">
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title | smartify | escape }}</a>
      <em><time class="dt-published" datetime="{{ post.date | date_to_xmlschema }}">
        {{ post.date | date: "%b %-d, %Y" }}
      </time></em>
    </li>
  {% endfor %}
</ol>