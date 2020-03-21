base:
  'salt-test.local':
    - postgres
    - mosquitto
    - nginx
    - nginx.site_config
    - ruby-install
    - coronadonor_api.service_account
    - coronadonor_api.shared_config
