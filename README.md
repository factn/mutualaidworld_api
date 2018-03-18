# README

* Development first-time deployment instructions

Pull this repos
Install the gems:
`bundle install`

Create, and seed, the database:
`rake db:drop db:create db:migrate db:seed`

Run:
`rails s`

Connect to localhost:3000

Note there are no logins etc.... at the moment

* Heroku deployment instructions

Download and install the Heroku CLI https://devcenter.heroku.com/articles/heroku-command-line

`heroku login`

`heroku git:remote -a lion-uat`

Deploy your application

`git push heroku master`

This stuff should be automated, but isn't at the moment:
Migrate and seed:

```
heroku rake db:migrate
heroku rake db:seed
```

Now create some test users for testing

`heroku run rails console`

```
User.create([{ email: 'test@example.com', password: 'password', password_confirmation: 'password' },
               { email: 'test2@example.com', password: 'password', password_confirmation: 'password' },
               { email: 'test3@example.com', password: 'password', password_confirmation: 'password' }])
```



This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)
