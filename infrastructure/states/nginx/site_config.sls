include:
  - nginx

/etc/nginx/sites-available/coronadonor_api:
  file.managed:
    - source: salt://coronadonor_api/files/nginx.site.conf
    - watch_in:
        - service: nginx

/etc/nginx/sites-enabled/coronadonor_api:
  file.symlink:
    - target: /etc/nginx/sites-available/coronadonor_api
    - watch_in:
        - service: nginx
