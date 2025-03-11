---
layout: post
date: "2025-03-11"
categories:
    - technology
    - code
title: Drain Octopus Deploy workers for patching
---

If you reboot a Linux Octopus worker while a deploy is running, that deploy will fail. It's better to decluster it during routine patching/maintenance. The following Ansible tasks do that:

{% raw %}
```yaml
- name: Patch octopus workers
  hosts: workers
  gather_facts: false
  vars:
    api_url: "https://octopusserver"
    api_key: "TODO"

  tasks:
    - name: Get worker status
      uri:
        url: "{{ api_url }}/api/workers/{{ octopus_id }}"
        method: GET
        headers:
          X-Octopus-ApiKey: "{{ api_key }}"
        body_format: json
        status_code: 200
      register: worker_status

    - name: Determine if worker requires draining
      set_fact:
        is_draining_required: "{{ worker_status.json.IsDisabled == false }}"

    - name: Is draining required?
      debug:
        msg: "Draining required: {{ is_draining_required }}"

    - name: Disable worker
      when: is_draining_required
      uri:
        url: "{{ api_url }}/api/workers/{{ octopus_id }}"
        method: PUT
        headers:
          X-Octopus-ApiKey: "{{ api_key }}"
        body: "{{ worker_status.json | combine({'IsDisabled': true}) | to_json }}"
        body_format: json
        status_code: 200

    - name: Wait for worker to drain
      when: is_draining_required
      block:
        - name: Check for active leases
          uri:
            url: "{{ api_url }}/api/Spaces-1/workertaskleases?skip=0&take=1000"
            method: GET
            headers:
              X-Octopus-ApiKey: "{{ api_key }}"
                status_code: 200
          register: lease_status
          # if you have jmespath installed this can be improved
          until: "not lease_status is search(octopus_id)"
          retries: 60
          delay: 15

    # do patching
    - name: Sleep to simulate patching
      pause:
        seconds: 5

    - name: Enable worker
      when: is_draining_required
      uri:
        url: "{{ api_url }}/api/workers/{{ octopus_id }}"
        method: PUT
        headers:
          X-Octopus-ApiKey: "{{ api_key }}"
        body: "{{ worker_status.json | combine({'IsDisabled': false}) | to_json }}"
        body_format: json
        status_code: 200

```
{% endraw %}

Example inventory:

```yaml
workers:
  hosts:
    worker1a:
      octopus_id: Workers-1
```

This attempts to leave the worker status in the same state it finds it, but that handling could be improved to better
handle failures.