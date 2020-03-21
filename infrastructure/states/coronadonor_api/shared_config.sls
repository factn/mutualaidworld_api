{% set username = salt['pillar.get']('coronadonor_api:service_account', 'coronadonor-api_development') %}


/home/{{ username }}/shared:
  file.directory:
    - owner: {{ username }}
    - group: {{ username }}


# master decryption key for rails creds
/home/{{ username }}/shared/config/master.key:
  file.managed:
    - makedirs: True
    - contents_pillar: coronadonor-api:master_key
    - owner: {{ username }}
    - group: {{ username }}
