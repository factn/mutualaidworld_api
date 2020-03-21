apt management packages:
  pkg.installed:
    - names:
        - python-apt
        - apt-transport-https

# yarn repository:
#   pkgrepo.managed:
#     - name: deb https://dl.yarnpkg.com/debian/ stable main
#     - key_url: https://dl.yarnpkg.com/debian/pubkey.gpg
#     - file: /etc/apt/sources.list.d/yarn.list
    
packages required by coronadonor-api project:
  pkg.installed:
    - names:
      - libpq-dev
      - imagemagick
    # - require:
    #     - pkgrepo: yarn repository
