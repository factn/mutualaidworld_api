# README

## Development first-time deployment instructions

Pull this repos
Install the gems:

`bundle install`

Create, and seed, the database:

`rake db:drop db:create db:migrate db:seed`

Run:

`rails s`

Connect to localhost:3000

Note there are no logins etc.... at the moment

## Usage

To get a scenarios data:

`curl -s -H "Accept: application/vnd.api+json" "http://localhost:3000/scenarios/3" | jq`

This will output:

```
{
  "data": {
    "id": "3",
    "type": "scenarios",
    "links": {
      "self": "http://localhost:3000/scenarios/3"
    },
    "attributes": {
      "image": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/003/original/food.jpg?1522183655",
      "verb": "find",
      "noun": "food",
      "imagethumb": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/003/thumb/food.jpg?1522183655",
      "requestorlat": 1.234,
      "requestorlon": 1.456,
      "doerlat": 2.543,
      "doerlon": 2.987,
      "donated": "$57.34"
    },
    "relationships": {
      "verb": {
        "links": {
          "self": "http://localhost:3000/scenarios/3/relationships/verb",
          "related": "http://localhost:3000/scenarios/3/verb"
        }
      },
      "noun": {
        "links": {
          "self": "http://localhost:3000/scenarios/3/relationships/noun",
          "related": "http://localhost:3000/scenarios/3/noun"
        }
      },
      "requestor": {
        "links": {
          "self": "http://localhost:3000/scenarios/3/relationships/requestor",
          "related": "http://localhost:3000/scenarios/3/requestor"
        }
      },
      "doer": {
        "links": {
          "self": "http://localhost:3000/scenarios/3/relationships/doer",
          "related": "http://localhost:3000/scenarios/3/doer"
        }
      }
    }
  }
}

```

To get a scenarios doer user:

`curl -s -H "Accept: application/vnd.api+json" "http://localhost:3000/scenarios/3/doer"  | jq`

which will output:

```
{
  "data": {
    "id": "1",
    "type": "users",
    "links": {
      "self": "http://localhost:3000/users/1"
    },
    "attributes": {
      "latitude": 2.543,
      "longitude": 2.987,
      "email": "admin@example.com",
      "firstname": "Place",
      "lastname": "Holder"
    }
  }
}

```

To update a users location:

`curl -i -H "Accept: application/vnd.api+json" -H 'Content-Type:application/vnd.api+json' -X PATCH -d '{"data": {"type":"users", "id": "1", "attributes":{"latitude":"2.543", "longitude": "2.987"}}}' http://localhost:3000/users/1 | jq`


## Heroku deployment instructions

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
