{%- set creds = salt['pillar.get']('coronadonor-api:database') %}

production user for coronadonor-api endpoint:
  postgres_user.present:
    - name: {{ creds.username }}
    - login: True
    - password: {{ creds.password }}
    - require:
      - service: postgresql@11-main
#
postgres database for coronadonor-api:
  postgres_database:
    - present
    - name: {{ creds.name }}
    - owner: {{ creds.username }}
    - require:
        - postgres_user: {{ creds.username }}

postgresql-11:
  pkg.installed

postgresql@11-main:
  service:
    - running
    - enable: True
    - watch:
        - file: /etc/postgresql/11/main/pg_hba.conf
    - require:
      - pkg: postgresql-11

/etc/postgresql/11/main/pg_hba.conf:
  file.managed:
    - source: salt://postgres/files/pg_hba.conf
