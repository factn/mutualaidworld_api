apt management packages:
  pkg.installed:
    - names:
        - python-apt
        - apt-transport-https
node repository:
  pkgrepo.managed:
    - name: deb https://deb.nodesource.com/node_8.x buster main
    - key_url: https://deb.nodesource.com/gpgkey/nodesource.gpg.key
    - file: /etc/apt/sources.list.d/nodejs.list
    - require:
        - pkg: apt management packages

yarn repository:
  pkgrepo.managed:
    - name: deb https://dl.yarnpkg.com/debian/ stable main
    - key_url: https://dl.yarnpkg.com/debian/pubkey.gpg
    - file: /etc/apt/sources.list.d/yarn.list
    
packages required by coronadonor-api project:
  pkg.installed:
    - names:
      - libpq-dev
      - imagemagick
      - nodejs
    - require:
        - pkgrepo: yarn repository
        - pkgrepo: node repository
