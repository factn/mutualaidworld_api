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

Create a donation

```
curl --request POST \
  --url http://localhost:3000/donations \
  --header 'accept: application/vnd.api+json' \
  --header 'content-type: application/vnd.api+json' \
  --data '{
  "data": {
    "type": "donations",
    "attributes": {
      "amount": "17"
    },
    "relationships": {
      "donator": {
        "data": {
          "type": "users",
          "id": "1"
        }
      },
      "scenario": {
        "data": {
          "id": "1",
          "type": "scenarios"
        }
      }
    }
  }
}'
```

Create a scenario - minimum

```
curl --request POST \
  --url http://localhost:3000/scenarios \
  --header 'accept: application/vnd.api+json' \
  --header 'content-type: application/vnd.api+json' \
  --data '{
  "data": {
    "type": "scenarios",
    "attributes": {

    },
    "relationships": {
			"verb": {
        "data": {
          "id": "1",
          "type": "verbs"
        }
      },
			"noun": {
        "data": {
          "id": "1",
          "type": "nouns"
        }
      },
			"event": {
        "data": {
          "id": "1",
          "type": "events"
        }
      }

    }
  }
}'
```

update a scenario with a doerlat

```
curl --request PATCH \
  --url http://localhost:3000/scenarios/15 \
  --header 'accept: application/vnd.api+json' \
  --header 'content-type: application/vnd.api+json' \
  --data '{
  "data": {
    "type": "scenarios",
		"id": 15,
    "attributes": {

    },
    "relationships": {
			"doer": {
        "data": {
          "id": "1",
          "type": "users"
        }
      }

    }
  }
}'
```

Get a scenario with all its child scenarios

```
curl --request GET \
  --url 'http://localhost:3000/scenarios/1?include=children_scenario' \
  --header 'accept: application/vnd.api+json' \
  --header 'content-type: application/vnd.api+json'
```

Create a requester ad "served to" interaction for user id 1, scenario id 1,

```
curl --request POST \
  --url http://localhost:3000/user_ad_interactions \
  --header 'accept: application/vnd.api+json' \
  --header 'content-type: application/vnd.api+json' \
  --data '
  {
    "data": {
      "type": "user_ad_interactions",
      "attributes": {},
      "relationships": {
        "user": {
          "data": {
            "type": "users",
            "id": "1"
          }
        },
        "scenario": {
          "data": {
            "id": "1",
            "type": "scenarios"
          }
        },
        "ad_type": {
          "data": {
            "id": "2",
            "type": "ad_types"
          }
        },
        "interaction_type": {
          "data": {
            "id": "1",
            "type": "interaction_types"
          }
        }
      }
    }
  }

  '
  ```

  Add a parent_scenario to a scenarios

  ```
  {
  "data": {
    "type": "scenarios",
		"id": 1,
    "relationships": {
			"parent_scenario": {
        "data": {
          "id": "2",
          "type": "scenarios"
        }
      }
    }
  }
}
```

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
