FROM talal7860/rails:2.6.5
COPY . .
RUN gem install bundler
EXPOSE 3000
CMD bundle exec puma -C config/puma.rb

LABEL maintainer="Talal Arshad <talal7860@gmail.com>"
