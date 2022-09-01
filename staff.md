---
layout: default
title: Staff
windowTitle: STAFF
icon: staff_icon.png
link_types: []
links: []
---

<!-- # {{ page.title }} -->

### Professor and HTA

<div class="uta-container">
  {% assign professors = site.staff | where: 'role', 'Professor' %}
  {% for staffer in professors %}
  {{ staffer }}
  {% endfor %}
<!-- </div> -->

{% assign HTAs = site.staff | where: 'role', 'HTA' %}
{% if HTAs.size != 0 %}

<!-- <div class="uta-container"> -->
  {% for staffer in HTAs %}
  {{ staffer }}
  {% endfor %}
  {% endif %}
</div>

{% assign STAs = site.staff | where: 'role', 'STA' %}
{% if STAs.size != 0 %}

### STAs

<div class="uta-container">
  {% for staffer in STAs %}
  {{ staffer }}
  {% endfor %}
  {% endif %}
</div>

{% assign UTAs = site.staff | where: 'role', 'UTA' %}
{% if UTAs.size != 0 %}

### UTAs

<div class="uta-container">
  {% for staffer in UTAs %}
  {{ staffer }}
  {% endfor %}
  {% endif %}
</div>
