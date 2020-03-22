required packages:
  pkg.installed:
    - names:
      - gcc
      - bash

ruby-install:
  archive.extracted:
    - name: /usr/src/ruby-install/
    - source_hash: 500a8ac84b8f65455958a02bcefd1ed4bfcaeaa2bb97b8f31e61ded5cd0fd70b
    - source: https://github.com/postmodern/ruby-install/archive/v0.7.0.tar.gz
    - require:
        - pkg: required packages

install ruby-install:
  cmd.run:
    - name: "make install"
    - cwd: /usr/src/ruby-install/ruby-install-0.7.0/
    - creates: /usr/local/bin/ruby-install
    - require:
        - archive: ruby-install

install ruby:
  cmd.run:
    - name: "ruby-install --system ruby 2.6.5"
    - creates: /usr/local/bin/ruby
    - require:
        - archive: ruby-install
        - cmd: install ruby-install

install gemrc:
  file.managed:
    - name: /etc/gemrc
    - contents: -N --no-ri --no-rdoc

update rubygems:
  cmd.run:
    - name: gem update --system
    - onchanges:
        - cmd: install ruby

install bundler:
  cmd.run:
    - name: "gem install bundler --no-ri --no-rdoc"
    - creates: /usr/local/bin/bundler
    - require:
        - cmd: install ruby
