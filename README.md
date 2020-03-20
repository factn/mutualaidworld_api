# Corona Donor project (Rails Back end)

## Development deployment instructions

1. Ensure ImageMagick is installed locally, this is used for image manipulation.
1. Pull this repos
1. Install the gems - `bundle install`
1. Create, and seed, the database - `rake db:drop db:create db:migrate db:seed`
1. update the .env file with your AWS S3 credentials - used by paperclip
1. Run `rails s`
1. Connect to [http://localhost:3000]

### Seed data

This is stored in db/seed.rb

## Run via docker/docker-compose

```shell
# install gems (first time only)
$ cp .env.example .env # make necessary changes in .env (if required)
$ docker-compose up
```

App should be running at [localhost:3000](http://localhost:3000)

## Heroku deployment instructions

Download and install the Heroku CLI https://devcenter.heroku.com/articles/heroku-command-line

`heroku login`

`heroku git:remote -a <APP NAME>`

Deploy your application

`git push heroku master`

Reset database, note this is a destructive operation and should only be done if you don't want the data:

```
heroku pg:reset --confirm <APP NAME>
```

migrate and seed:
```
heroku rake db:migrate db:seed
```

## Examples of use

To use these endpoints, you must set certain headers correctly - "Accept" must be set to "application/vnd.api+json" for GET, if you are POST, PATCH, or PUTting you need to also set "Content-Type" to "application/vnd.api+json"
One way to interact with the API is on the command line with curl:

To get the data for scenario with id 2:
`curl -s -H "Accept: application/vnd.api+json"  "https://<APP NAME>.herokuapp.com/scenarios/2?email=user@example.com&password=abc123`

you can also use postman, or insomnia, if you prefer a GUI. The API conforms to the [jsonapi specifications](http://jsonapi.org/format/), but I've added some fields - such as `requester_username` in the `scenario` resource - for convenience that don't actually exist in that specific resource. I did this before I fully understood the API, and how the API consumer could properly ask for that information, but I guess that's fine for now.

Create a donation using curl:

```
curl --request POST \
  --url http://localhost:3000/donations?email=user@example.com&password=abc123 \
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

update a scenario, assigning it to a user to perform (a "doer"):

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


Create a requester ad "served to" interaction for user id 1, scenario id 1:

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
  }'
```

Add a parent_scenario to a scenario:

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

To get all children scenarios:

`http://localhost:3000/scenarios/1?include=children_scenario`

This will return the scenario with id 1, with an extended relationships section - it adds the "data" element:

```
"children_scenario": {
  "links": {
    "self": "http://localhost:3000/scenarios/1/relationships/children-scenario",
    "related": "http://localhost:3000/scenarios/1/children-scenario"
  },
  "data": [
    {
      "type": "scenarios",
      "id": "11"
    },
    {
      "type": "scenarios",
      "id": "12"
    },
    {
      "type": "scenarios",
      "id": "13"
    }
  ]
},
```

It also includes a full "scenario" at the end.

Here is the full output:

```
{
	"data": {
		"id": "1",
		"type": "scenarios",
		"links": {
			"self": "http://localhost:3000/scenarios/1"
		},
		"attributes": {
			"image": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/001/original/audrey.jpeg?1523492350",
			"noun": "roof",
			"event": "Hurricane Katrina",
			"imagethumb": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/001/thumb/audrey.jpeg?1523492350",
			"requesterlat": -41.2718598,
			"requesterlon": 174.7818482,
			"doerlat": -41.2718598,
			"doerlon": 174.7818482,
			"donated": "0.0",
			"funding_goal": "1000.0",
			"verified": false,
			"requester_firstname": "Audrey",
			"requester_lastname": "Audreyson",
			"doer_firstname": "jack",
			"doer_lastname": "jackson",
			"custom_message": "Help me fix my roof!",
			"parent_scenario_id": 2,
			"children": [
				11,
				12,
				13
			]
		},
		"relationships": {
			"verb": {
				"links": {
					"self": "http://localhost:3000/scenarios/1/relationships/verb",
					"related": "http://localhost:3000/scenarios/1/verb"
				}
			},
			"noun": {
				"links": {
					"self": "http://localhost:3000/scenarios/1/relationships/noun",
					"related": "http://localhost:3000/scenarios/1/noun"
				}
			},
			"requester": {
				"links": {
					"self": "http://localhost:3000/scenarios/1/relationships/requester",
					"related": "http://localhost:3000/scenarios/1/requester"
				}
			},
			"doer": {
				"links": {
					"self": "http://localhost:3000/scenarios/1/relationships/doer",
					"related": "http://localhost:3000/scenarios/1/doer"
				}
			},
			"event": {
				"links": {
					"self": "http://localhost:3000/scenarios/1/relationships/event",
					"related": "http://localhost:3000/scenarios/1/event"
				}
			},
			"parent_scenario": {
				"links": {
					"self": "http://localhost:3000/scenarios/1/relationships/parent-scenario",
					"related": "http://localhost:3000/scenarios/1/parent-scenario"
				}
			},
			"vouches": {
				"links": {
					"self": "http://localhost:3000/scenarios/1/relationships/vouches",
					"related": "http://localhost:3000/scenarios/1/vouches"
				}
			},
			"donations": {
				"links": {
					"self": "http://localhost:3000/scenarios/1/relationships/donations",
					"related": "http://localhost:3000/scenarios/1/donations"
				}
			},
			"children_scenario": {
				"links": {
					"self": "http://localhost:3000/scenarios/1/relationships/children-scenario",
					"related": "http://localhost:3000/scenarios/1/children-scenario"
				},
				"data": [
					{
						"type": "scenarios",
						"id": "11"
					},
					{
						"type": "scenarios",
						"id": "12"
					},
					{
						"type": "scenarios",
						"id": "13"
					}
				]
			},
			"user_ad_interaction": {
				"links": {
					"self": "http://localhost:3000/scenarios/1/relationships/user-ad-interaction",
					"related": "http://localhost:3000/scenarios/1/user-ad-interaction"
				}
			}
		}
	},
	"included": [
		{
			"id": "11",
			"type": "scenarios",
			"links": {
				"self": "http://localhost:3000/scenarios/11"
			},
			"attributes": {
				"image": "/images/original/missing.png",
				"noun": "materials",
				"event": "Hurricane Katrina",
				"imagethumb": "/images/thumb/missing.png",
				"requesterlat": -41.2718598,
				"requesterlon": 174.7818482,
				"doerlat": null,
				"doerlon": null,
				"donated": "0.0",
				"funding_goal": null,
				"verified": false,
				"requester_firstname": "jack",
				"requester_lastname": "jackson",
				"doer_firstname": null,
				"doer_lastname": null,
				"custom_message": null,
				"parent_scenario_id": 1,
				"children": []
			},
			"relationships": {
				"verb": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/verb",
						"related": "http://localhost:3000/scenarios/11/verb"
					}
				},
				"noun": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/noun",
						"related": "http://localhost:3000/scenarios/11/noun"
					}
				},
				"requester": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/requester",
						"related": "http://localhost:3000/scenarios/11/requester"
					}
				},
				"doer": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/doer",
						"related": "http://localhost:3000/scenarios/11/doer"
					}
				},
				"event": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/event",
						"related": "http://localhost:3000/scenarios/11/event"
					}
				},
				"parent_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/parent-scenario",
						"related": "http://localhost:3000/scenarios/11/parent-scenario"
					}
				},
				"vouches": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/vouches",
						"related": "http://localhost:3000/scenarios/11/vouches"
					}
				},
				"donations": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/donations",
						"related": "http://localhost:3000/scenarios/11/donations"
					}
				},
				"children_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/children-scenario",
						"related": "http://localhost:3000/scenarios/11/children-scenario"
					}
				},
				"user_ad_interaction": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/user-ad-interaction",
						"related": "http://localhost:3000/scenarios/11/user-ad-interaction"
					}
				}
			}
		},
		{
			"id": "12",
			"type": "scenarios",
			"links": {
				"self": "http://localhost:3000/scenarios/12"
			},
			"attributes": {
				"image": "/images/original/missing.png",
				"noun": "transportation",
				"event": "Hurricane Katrina",
				"imagethumb": "/images/thumb/missing.png",
				"requesterlat": -41.2718598,
				"requesterlon": 174.7818482,
				"doerlat": null,
				"doerlon": null,
				"donated": "0.0",
				"funding_goal": null,
				"verified": false,
				"requester_firstname": "jack",
				"requester_lastname": "jackson",
				"doer_firstname": null,
				"doer_lastname": null,
				"custom_message": null,
				"parent_scenario_id": 1,
				"children": []
			},
			"relationships": {
				"verb": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/verb",
						"related": "http://localhost:3000/scenarios/12/verb"
					}
				},
				"noun": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/noun",
						"related": "http://localhost:3000/scenarios/12/noun"
					}
				},
				"requester": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/requester",
						"related": "http://localhost:3000/scenarios/12/requester"
					}
				},
				"doer": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/doer",
						"related": "http://localhost:3000/scenarios/12/doer"
					}
				},
				"event": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/event",
						"related": "http://localhost:3000/scenarios/12/event"
					}
				},
				"parent_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/parent-scenario",
						"related": "http://localhost:3000/scenarios/12/parent-scenario"
					}
				},
				"vouches": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/vouches",
						"related": "http://localhost:3000/scenarios/12/vouches"
					}
				},
				"donations": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/donations",
						"related": "http://localhost:3000/scenarios/12/donations"
					}
				},
				"children_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/children-scenario",
						"related": "http://localhost:3000/scenarios/12/children-scenario"
					}
				},
				"user_ad_interaction": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/user-ad-interaction",
						"related": "http://localhost:3000/scenarios/12/user-ad-interaction"
					}
				}
			}
		},
		{
			"id": "13",
			"type": "scenarios",
			"links": {
				"self": "http://localhost:3000/scenarios/13"
			},
			"attributes": {
				"image": "/images/original/missing.png",
				"noun": "volunteers",
				"event": "Hurricane Katrina",
				"imagethumb": "/images/thumb/missing.png",
				"requesterlat": -41.2718598,
				"requesterlon": 174.7818482,
				"doerlat": null,
				"doerlon": null,
				"donated": "0.0",
				"funding_goal": null,
				"verified": false,
				"requester_firstname": "jack",
				"requester_lastname": "jackson",
				"doer_firstname": null,
				"doer_lastname": null,
				"custom_message": null,
				"parent_scenario_id": 1,
				"children": []
			},
			"relationships": {
				"verb": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/verb",
						"related": "http://localhost:3000/scenarios/13/verb"
					}
				},
				"noun": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/noun",
						"related": "http://localhost:3000/scenarios/13/noun"
					}
				},
				"requester": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/requester",
						"related": "http://localhost:3000/scenarios/13/requester"
					}
				},
				"doer": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/doer",
						"related": "http://localhost:3000/scenarios/13/doer"
					}
				},
				"event": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/event",
						"related": "http://localhost:3000/scenarios/13/event"
					}
				},
				"parent_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/parent-scenario",
						"related": "http://localhost:3000/scenarios/13/parent-scenario"
					}
				},
				"vouches": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/vouches",
						"related": "http://localhost:3000/scenarios/13/vouches"
					}
				},
				"donations": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/donations",
						"related": "http://localhost:3000/scenarios/13/donations"
					}
				},
				"children_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/children-scenario",
						"related": "http://localhost:3000/scenarios/13/children-scenario"
					}
				},
				"user_ad_interaction": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/user-ad-interaction",
						"related": "http://localhost:3000/scenarios/13/user-ad-interaction"
					}
				}
			}
		}
	]
}
```

To get a list of all parent scenarios, with their children scenarios embedded:
`http://localhost:3000/scenarios?include=children_scenario&filter[is_sub_task]=false`

```
{
	"data": [
		{
			"id": "1",
			"type": "scenarios",
			"links": {
				"self": "http://localhost:3000/scenarios/1"
			},
			"attributes": {
				"image": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/001/original/audrey.jpeg?1523492350",
				"noun": "roof",
				"event": "Hurricane Katrina",
				"imagethumb": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/001/thumb/audrey.jpeg?1523492350",
				"requesterlat": -41.2718598,
				"requesterlon": 174.7818482,
				"doerlat": -41.2718598,
				"doerlon": 174.7818482,
				"donated": "0.0",
				"funding_goal": "1000.0",
				"verified": false,
				"requester_firstname": "Audrey",
				"requester_lastname": "Audreyson",
				"doer_firstname": "jack",
				"doer_lastname": "jackson",
				"custom_message": "Help me fix my roof!",
				"parent_scenario_id": 2,
				"ratio_for_user": 6,
				"is_parent": false,
				"is_child": true,
				"is_complete": false
			},
			"relationships": {
				"verb": {
					"links": {
						"self": "http://localhost:3000/scenarios/1/relationships/verb",
						"related": "http://localhost:3000/scenarios/1/verb"
					}
				},
				"noun": {
					"links": {
						"self": "http://localhost:3000/scenarios/1/relationships/noun",
						"related": "http://localhost:3000/scenarios/1/noun"
					}
				},
				"requester": {
					"links": {
						"self": "http://localhost:3000/scenarios/1/relationships/requester",
						"related": "http://localhost:3000/scenarios/1/requester"
					}
				},
				"doer": {
					"links": {
						"self": "http://localhost:3000/scenarios/1/relationships/doer",
						"related": "http://localhost:3000/scenarios/1/doer"
					}
				},
				"event": {
					"links": {
						"self": "http://localhost:3000/scenarios/1/relationships/event",
						"related": "http://localhost:3000/scenarios/1/event"
					}
				},
				"parent_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/1/relationships/parent-scenario",
						"related": "http://localhost:3000/scenarios/1/parent-scenario"
					}
				},
				"vouches": {
					"links": {
						"self": "http://localhost:3000/scenarios/1/relationships/vouches",
						"related": "http://localhost:3000/scenarios/1/vouches"
					}
				},
				"donations": {
					"links": {
						"self": "http://localhost:3000/scenarios/1/relationships/donations",
						"related": "http://localhost:3000/scenarios/1/donations"
					}
				},
				"children_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/1/relationships/children-scenario",
						"related": "http://localhost:3000/scenarios/1/children-scenario"
					},
					"data": [
						{
							"type": "scenarios",
							"id": "11"
						},
						{
							"type": "scenarios",
							"id": "12"
						},
						{
							"type": "scenarios",
							"id": "13"
						}
					]
				},
				"user_ad_interaction": {
					"links": {
						"self": "http://localhost:3000/scenarios/1/relationships/user-ad-interaction",
						"related": "http://localhost:3000/scenarios/1/user-ad-interaction"
					}
				}
			}
		},
		{
			"id": "11",
			"type": "scenarios",
			"links": {
				"self": "http://localhost:3000/scenarios/11"
			},
			"attributes": {
				"image": "/images/original/missing.png",
				"noun": "materials",
				"event": "Hurricane Katrina",
				"imagethumb": "/images/thumb/missing.png",
				"requesterlat": -41.2718598,
				"requesterlon": 174.7818482,
				"doerlat": null,
				"doerlon": null,
				"donated": "0.0",
				"funding_goal": null,
				"verified": false,
				"requester_firstname": "jack",
				"requester_lastname": "jackson",
				"doer_firstname": null,
				"doer_lastname": null,
				"custom_message": null,
				"parent_scenario_id": 1,
				"ratio_for_user": 6,
				"is_parent": false,
				"is_child": true,
				"is_complete": false
			},
			"relationships": {
				"verb": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/verb",
						"related": "http://localhost:3000/scenarios/11/verb"
					}
				},
				"noun": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/noun",
						"related": "http://localhost:3000/scenarios/11/noun"
					}
				},
				"requester": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/requester",
						"related": "http://localhost:3000/scenarios/11/requester"
					}
				},
				"doer": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/doer",
						"related": "http://localhost:3000/scenarios/11/doer"
					}
				},
				"event": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/event",
						"related": "http://localhost:3000/scenarios/11/event"
					}
				},
				"parent_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/parent-scenario",
						"related": "http://localhost:3000/scenarios/11/parent-scenario"
					}
				},
				"vouches": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/vouches",
						"related": "http://localhost:3000/scenarios/11/vouches"
					}
				},
				"donations": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/donations",
						"related": "http://localhost:3000/scenarios/11/donations"
					}
				},
				"children_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/children-scenario",
						"related": "http://localhost:3000/scenarios/11/children-scenario"
					},
					"data": []
				},
				"user_ad_interaction": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/user-ad-interaction",
						"related": "http://localhost:3000/scenarios/11/user-ad-interaction"
					}
				}
			}
		},
		{
			"id": "12",
			"type": "scenarios",
			"links": {
				"self": "http://localhost:3000/scenarios/12"
			},
			"attributes": {
				"image": "/images/original/missing.png",
				"noun": "transportation",
				"event": "Hurricane Katrina",
				"imagethumb": "/images/thumb/missing.png",
				"requesterlat": -41.2718598,
				"requesterlon": 174.7818482,
				"doerlat": null,
				"doerlon": null,
				"donated": "0.0",
				"funding_goal": null,
				"verified": false,
				"requester_firstname": "jack",
				"requester_lastname": "jackson",
				"doer_firstname": null,
				"doer_lastname": null,
				"custom_message": null,
				"parent_scenario_id": 1,
				"ratio_for_user": 6,
				"is_parent": false,
				"is_child": true,
				"is_complete": false
			},
			"relationships": {
				"verb": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/verb",
						"related": "http://localhost:3000/scenarios/12/verb"
					}
				},
				"noun": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/noun",
						"related": "http://localhost:3000/scenarios/12/noun"
					}
				},
				"requester": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/requester",
						"related": "http://localhost:3000/scenarios/12/requester"
					}
				},
				"doer": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/doer",
						"related": "http://localhost:3000/scenarios/12/doer"
					}
				},
				"event": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/event",
						"related": "http://localhost:3000/scenarios/12/event"
					}
				},
				"parent_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/parent-scenario",
						"related": "http://localhost:3000/scenarios/12/parent-scenario"
					}
				},
				"vouches": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/vouches",
						"related": "http://localhost:3000/scenarios/12/vouches"
					}
				},
				"donations": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/donations",
						"related": "http://localhost:3000/scenarios/12/donations"
					}
				},
				"children_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/children-scenario",
						"related": "http://localhost:3000/scenarios/12/children-scenario"
					},
					"data": []
				},
				"user_ad_interaction": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/user-ad-interaction",
						"related": "http://localhost:3000/scenarios/12/user-ad-interaction"
					}
				}
			}
		},
		{
			"id": "13",
			"type": "scenarios",
			"links": {
				"self": "http://localhost:3000/scenarios/13"
			},
			"attributes": {
				"image": "/images/original/missing.png",
				"noun": "volunteers",
				"event": "Hurricane Katrina",
				"imagethumb": "/images/thumb/missing.png",
				"requesterlat": -41.2718598,
				"requesterlon": 174.7818482,
				"doerlat": null,
				"doerlon": null,
				"donated": "0.0",
				"funding_goal": null,
				"verified": false,
				"requester_firstname": "jack",
				"requester_lastname": "jackson",
				"doer_firstname": null,
				"doer_lastname": null,
				"custom_message": null,
				"parent_scenario_id": 1,
				"ratio_for_user": 6,
				"is_parent": false,
				"is_child": true,
				"is_complete": false
			},
			"relationships": {
				"verb": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/verb",
						"related": "http://localhost:3000/scenarios/13/verb"
					}
				},
				"noun": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/noun",
						"related": "http://localhost:3000/scenarios/13/noun"
					}
				},
				"requester": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/requester",
						"related": "http://localhost:3000/scenarios/13/requester"
					}
				},
				"doer": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/doer",
						"related": "http://localhost:3000/scenarios/13/doer"
					}
				},
				"event": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/event",
						"related": "http://localhost:3000/scenarios/13/event"
					}
				},
				"parent_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/parent-scenario",
						"related": "http://localhost:3000/scenarios/13/parent-scenario"
					}
				},
				"vouches": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/vouches",
						"related": "http://localhost:3000/scenarios/13/vouches"
					}
				},
				"donations": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/donations",
						"related": "http://localhost:3000/scenarios/13/donations"
					}
				},
				"children_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/children-scenario",
						"related": "http://localhost:3000/scenarios/13/children-scenario"
					},
					"data": []
				},
				"user_ad_interaction": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/user-ad-interaction",
						"related": "http://localhost:3000/scenarios/13/user-ad-interaction"
					}
				}
			}
		},
		{
			"id": "23",
			"type": "scenarios",
			"links": {
				"self": "http://localhost:3000/scenarios/23"
			},
			"attributes": {
				"image": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/023/original/data?1523500422",
				"noun": "nails",
				"event": "Hurricane Katrina",
				"imagethumb": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/023/thumb/data?1523500422",
				"requesterlat": -41.2855188,
				"requesterlon": 174.7952354,
				"doerlat": -41.2855188,
				"doerlon": 174.7952354,
				"donated": "0.0",
				"funding_goal": "50.0",
				"verified": false,
				"requester_firstname": "tom",
				"requester_lastname": "johnson",
				"doer_firstname": "tom",
				"doer_lastname": "johnson",
				"custom_message": null,
				"parent_scenario_id": 22,
				"ratio_for_user": 6,
				"is_parent": false,
				"is_child": true,
				"is_complete": false
			},
			"relationships": {
				"verb": {
					"links": {
						"self": "http://localhost:3000/scenarios/23/relationships/verb",
						"related": "http://localhost:3000/scenarios/23/verb"
					}
				},
				"noun": {
					"links": {
						"self": "http://localhost:3000/scenarios/23/relationships/noun",
						"related": "http://localhost:3000/scenarios/23/noun"
					}
				},
				"requester": {
					"links": {
						"self": "http://localhost:3000/scenarios/23/relationships/requester",
						"related": "http://localhost:3000/scenarios/23/requester"
					}
				},
				"doer": {
					"links": {
						"self": "http://localhost:3000/scenarios/23/relationships/doer",
						"related": "http://localhost:3000/scenarios/23/doer"
					}
				},
				"event": {
					"links": {
						"self": "http://localhost:3000/scenarios/23/relationships/event",
						"related": "http://localhost:3000/scenarios/23/event"
					}
				},
				"parent_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/23/relationships/parent-scenario",
						"related": "http://localhost:3000/scenarios/23/parent-scenario"
					}
				},
				"vouches": {
					"links": {
						"self": "http://localhost:3000/scenarios/23/relationships/vouches",
						"related": "http://localhost:3000/scenarios/23/vouches"
					}
				},
				"donations": {
					"links": {
						"self": "http://localhost:3000/scenarios/23/relationships/donations",
						"related": "http://localhost:3000/scenarios/23/donations"
					}
				},
				"children_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/23/relationships/children-scenario",
						"related": "http://localhost:3000/scenarios/23/children-scenario"
					},
					"data": []
				},
				"user_ad_interaction": {
					"links": {
						"self": "http://localhost:3000/scenarios/23/relationships/user-ad-interaction",
						"related": "http://localhost:3000/scenarios/23/user-ad-interaction"
					}
				}
			}
		},
		{
			"id": "24",
			"type": "scenarios",
			"links": {
				"self": "http://localhost:3000/scenarios/24"
			},
			"attributes": {
				"image": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/024/original/data?1523500422",
				"noun": "labourer",
				"event": "Hurricane Katrina",
				"imagethumb": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/024/thumb/data?1523500422",
				"requesterlat": -41.2855188,
				"requesterlon": 174.7952354,
				"doerlat": -41.2855188,
				"doerlon": 174.7952354,
				"donated": "0.0",
				"funding_goal": "50.0",
				"verified": false,
				"requester_firstname": "tom",
				"requester_lastname": "johnson",
				"doer_firstname": "tom",
				"doer_lastname": "johnson",
				"custom_message": null,
				"parent_scenario_id": 22,
				"ratio_for_user": 6,
				"is_parent": false,
				"is_child": true,
				"is_complete": false
			},
			"relationships": {
				"verb": {
					"links": {
						"self": "http://localhost:3000/scenarios/24/relationships/verb",
						"related": "http://localhost:3000/scenarios/24/verb"
					}
				},
				"noun": {
					"links": {
						"self": "http://localhost:3000/scenarios/24/relationships/noun",
						"related": "http://localhost:3000/scenarios/24/noun"
					}
				},
				"requester": {
					"links": {
						"self": "http://localhost:3000/scenarios/24/relationships/requester",
						"related": "http://localhost:3000/scenarios/24/requester"
					}
				},
				"doer": {
					"links": {
						"self": "http://localhost:3000/scenarios/24/relationships/doer",
						"related": "http://localhost:3000/scenarios/24/doer"
					}
				},
				"event": {
					"links": {
						"self": "http://localhost:3000/scenarios/24/relationships/event",
						"related": "http://localhost:3000/scenarios/24/event"
					}
				},
				"parent_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/24/relationships/parent-scenario",
						"related": "http://localhost:3000/scenarios/24/parent-scenario"
					}
				},
				"vouches": {
					"links": {
						"self": "http://localhost:3000/scenarios/24/relationships/vouches",
						"related": "http://localhost:3000/scenarios/24/vouches"
					}
				},
				"donations": {
					"links": {
						"self": "http://localhost:3000/scenarios/24/relationships/donations",
						"related": "http://localhost:3000/scenarios/24/donations"
					}
				},
				"children_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/24/relationships/children-scenario",
						"related": "http://localhost:3000/scenarios/24/children-scenario"
					},
					"data": []
				},
				"user_ad_interaction": {
					"links": {
						"self": "http://localhost:3000/scenarios/24/relationships/user-ad-interaction",
						"related": "http://localhost:3000/scenarios/24/user-ad-interaction"
					}
				}
			}
		},
		{
			"id": "25",
			"type": "scenarios",
			"links": {
				"self": "http://localhost:3000/scenarios/25"
			},
			"attributes": {
				"image": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/025/original/data?1523500422",
				"noun": "volunteers",
				"event": "Hurricane Katrina",
				"imagethumb": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/025/thumb/data?1523500422",
				"requesterlat": -41.2855188,
				"requesterlon": 174.7952354,
				"doerlat": -41.2855188,
				"doerlon": 174.7952354,
				"donated": "0.0",
				"funding_goal": "50.0",
				"verified": false,
				"requester_firstname": "tom",
				"requester_lastname": "johnson",
				"doer_firstname": "tom",
				"doer_lastname": "johnson",
				"custom_message": null,
				"parent_scenario_id": 22,
				"ratio_for_user": 6,
				"is_parent": false,
				"is_child": true,
				"is_complete": false
			},
			"relationships": {
				"verb": {
					"links": {
						"self": "http://localhost:3000/scenarios/25/relationships/verb",
						"related": "http://localhost:3000/scenarios/25/verb"
					}
				},
				"noun": {
					"links": {
						"self": "http://localhost:3000/scenarios/25/relationships/noun",
						"related": "http://localhost:3000/scenarios/25/noun"
					}
				},
				"requester": {
					"links": {
						"self": "http://localhost:3000/scenarios/25/relationships/requester",
						"related": "http://localhost:3000/scenarios/25/requester"
					}
				},
				"doer": {
					"links": {
						"self": "http://localhost:3000/scenarios/25/relationships/doer",
						"related": "http://localhost:3000/scenarios/25/doer"
					}
				},
				"event": {
					"links": {
						"self": "http://localhost:3000/scenarios/25/relationships/event",
						"related": "http://localhost:3000/scenarios/25/event"
					}
				},
				"parent_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/25/relationships/parent-scenario",
						"related": "http://localhost:3000/scenarios/25/parent-scenario"
					}
				},
				"vouches": {
					"links": {
						"self": "http://localhost:3000/scenarios/25/relationships/vouches",
						"related": "http://localhost:3000/scenarios/25/vouches"
					}
				},
				"donations": {
					"links": {
						"self": "http://localhost:3000/scenarios/25/relationships/donations",
						"related": "http://localhost:3000/scenarios/25/donations"
					}
				},
				"children_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/25/relationships/children-scenario",
						"related": "http://localhost:3000/scenarios/25/children-scenario"
					},
					"data": []
				},
				"user_ad_interaction": {
					"links": {
						"self": "http://localhost:3000/scenarios/25/relationships/user-ad-interaction",
						"related": "http://localhost:3000/scenarios/25/user-ad-interaction"
					}
				}
			}
		},
		{
			"id": "27",
			"type": "scenarios",
			"links": {
				"self": "http://localhost:3000/scenarios/27"
			},
			"attributes": {
				"image": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/027/original/data?1523500499",
				"noun": "labourer",
				"event": "Kaikora Earthquake",
				"imagethumb": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/027/thumb/data?1523500499",
				"requesterlat": -41.2855188,
				"requesterlon": 174.7952354,
				"doerlat": -41.2855188,
				"doerlon": 174.7952354,
				"donated": "0.0",
				"funding_goal": "50.0",
				"verified": false,
				"requester_firstname": "tom",
				"requester_lastname": "johnson",
				"doer_firstname": "tom",
				"doer_lastname": "johnson",
				"custom_message": null,
				"parent_scenario_id": 26,
				"ratio_for_user": 6,
				"is_parent": false,
				"is_child": true,
				"is_complete": false
			},
			"relationships": {
				"verb": {
					"links": {
						"self": "http://localhost:3000/scenarios/27/relationships/verb",
						"related": "http://localhost:3000/scenarios/27/verb"
					}
				},
				"noun": {
					"links": {
						"self": "http://localhost:3000/scenarios/27/relationships/noun",
						"related": "http://localhost:3000/scenarios/27/noun"
					}
				},
				"requester": {
					"links": {
						"self": "http://localhost:3000/scenarios/27/relationships/requester",
						"related": "http://localhost:3000/scenarios/27/requester"
					}
				},
				"doer": {
					"links": {
						"self": "http://localhost:3000/scenarios/27/relationships/doer",
						"related": "http://localhost:3000/scenarios/27/doer"
					}
				},
				"event": {
					"links": {
						"self": "http://localhost:3000/scenarios/27/relationships/event",
						"related": "http://localhost:3000/scenarios/27/event"
					}
				},
				"parent_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/27/relationships/parent-scenario",
						"related": "http://localhost:3000/scenarios/27/parent-scenario"
					}
				},
				"vouches": {
					"links": {
						"self": "http://localhost:3000/scenarios/27/relationships/vouches",
						"related": "http://localhost:3000/scenarios/27/vouches"
					}
				},
				"donations": {
					"links": {
						"self": "http://localhost:3000/scenarios/27/relationships/donations",
						"related": "http://localhost:3000/scenarios/27/donations"
					}
				},
				"children_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/27/relationships/children-scenario",
						"related": "http://localhost:3000/scenarios/27/children-scenario"
					},
					"data": []
				},
				"user_ad_interaction": {
					"links": {
						"self": "http://localhost:3000/scenarios/27/relationships/user-ad-interaction",
						"related": "http://localhost:3000/scenarios/27/user-ad-interaction"
					}
				}
			}
		},
		{
			"id": "28",
			"type": "scenarios",
			"links": {
				"self": "http://localhost:3000/scenarios/28"
			},
			"attributes": {
				"image": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/028/original/data?1523500499",
				"noun": "nails",
				"event": "Kaikora Earthquake",
				"imagethumb": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/028/thumb/data?1523500499",
				"requesterlat": -41.2855188,
				"requesterlon": 174.7952354,
				"doerlat": -41.2855188,
				"doerlon": 174.7952354,
				"donated": "0.0",
				"funding_goal": "50.0",
				"verified": false,
				"requester_firstname": "tom",
				"requester_lastname": "johnson",
				"doer_firstname": "tom",
				"doer_lastname": "johnson",
				"custom_message": null,
				"parent_scenario_id": 26,
				"ratio_for_user": 6,
				"is_parent": false,
				"is_child": true,
				"is_complete": false
			},
			"relationships": {
				"verb": {
					"links": {
						"self": "http://localhost:3000/scenarios/28/relationships/verb",
						"related": "http://localhost:3000/scenarios/28/verb"
					}
				},
				"noun": {
					"links": {
						"self": "http://localhost:3000/scenarios/28/relationships/noun",
						"related": "http://localhost:3000/scenarios/28/noun"
					}
				},
				"requester": {
					"links": {
						"self": "http://localhost:3000/scenarios/28/relationships/requester",
						"related": "http://localhost:3000/scenarios/28/requester"
					}
				},
				"doer": {
					"links": {
						"self": "http://localhost:3000/scenarios/28/relationships/doer",
						"related": "http://localhost:3000/scenarios/28/doer"
					}
				},
				"event": {
					"links": {
						"self": "http://localhost:3000/scenarios/28/relationships/event",
						"related": "http://localhost:3000/scenarios/28/event"
					}
				},
				"parent_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/28/relationships/parent-scenario",
						"related": "http://localhost:3000/scenarios/28/parent-scenario"
					}
				},
				"vouches": {
					"links": {
						"self": "http://localhost:3000/scenarios/28/relationships/vouches",
						"related": "http://localhost:3000/scenarios/28/vouches"
					}
				},
				"donations": {
					"links": {
						"self": "http://localhost:3000/scenarios/28/relationships/donations",
						"related": "http://localhost:3000/scenarios/28/donations"
					}
				},
				"children_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/28/relationships/children-scenario",
						"related": "http://localhost:3000/scenarios/28/children-scenario"
					},
					"data": []
				},
				"user_ad_interaction": {
					"links": {
						"self": "http://localhost:3000/scenarios/28/relationships/user-ad-interaction",
						"related": "http://localhost:3000/scenarios/28/user-ad-interaction"
					}
				}
			}
		},
		{
			"id": "29",
			"type": "scenarios",
			"links": {
				"self": "http://localhost:3000/scenarios/29"
			},
			"attributes": {
				"image": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/029/original/data?1523500499",
				"noun": "volunteers",
				"event": "Kaikora Earthquake",
				"imagethumb": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/029/thumb/data?1523500499",
				"requesterlat": -41.2855188,
				"requesterlon": 174.7952354,
				"doerlat": -41.2855188,
				"doerlon": 174.7952354,
				"donated": "0.0",
				"funding_goal": "50.0",
				"verified": false,
				"requester_firstname": "tom",
				"requester_lastname": "johnson",
				"doer_firstname": "tom",
				"doer_lastname": "johnson",
				"custom_message": null,
				"parent_scenario_id": 26,
				"ratio_for_user": 6,
				"is_parent": false,
				"is_child": true,
				"is_complete": false
			},
			"relationships": {
				"verb": {
					"links": {
						"self": "http://localhost:3000/scenarios/29/relationships/verb",
						"related": "http://localhost:3000/scenarios/29/verb"
					}
				},
				"noun": {
					"links": {
						"self": "http://localhost:3000/scenarios/29/relationships/noun",
						"related": "http://localhost:3000/scenarios/29/noun"
					}
				},
				"requester": {
					"links": {
						"self": "http://localhost:3000/scenarios/29/relationships/requester",
						"related": "http://localhost:3000/scenarios/29/requester"
					}
				},
				"doer": {
					"links": {
						"self": "http://localhost:3000/scenarios/29/relationships/doer",
						"related": "http://localhost:3000/scenarios/29/doer"
					}
				},
				"event": {
					"links": {
						"self": "http://localhost:3000/scenarios/29/relationships/event",
						"related": "http://localhost:3000/scenarios/29/event"
					}
				},
				"parent_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/29/relationships/parent-scenario",
						"related": "http://localhost:3000/scenarios/29/parent-scenario"
					}
				},
				"vouches": {
					"links": {
						"self": "http://localhost:3000/scenarios/29/relationships/vouches",
						"related": "http://localhost:3000/scenarios/29/vouches"
					}
				},
				"donations": {
					"links": {
						"self": "http://localhost:3000/scenarios/29/relationships/donations",
						"related": "http://localhost:3000/scenarios/29/donations"
					}
				},
				"children_scenario": {
					"links": {
						"self": "http://localhost:3000/scenarios/29/relationships/children-scenario",
						"related": "http://localhost:3000/scenarios/29/children-scenario"
					},
					"data": []
				},
				"user_ad_interaction": {
					"links": {
						"self": "http://localhost:3000/scenarios/29/relationships/user-ad-interaction",
						"related": "http://localhost:3000/scenarios/29/user-ad-interaction"
					}
				}
			}
		}
	],
	"links": {
		"first": "http://localhost:3000/scenarios?filter%5Bis_sub_task%5D=false&include=children_scenario&page%5Blimit%5D=100&page%5Boffset%5D=0",
		"last": "http://localhost:3000/scenarios?filter%5Bis_sub_task%5D=false&include=children_scenario&page%5Blimit%5D=100&page%5Boffset%5D=0"
	}
}
```

Getting all the sceanrios you haven't dismissed the doer ads for:

`get "/scenarios?filter[doer_ad_not_dismissed_by]=A_USER_ID_GOES_HERE", headers: headers`


## Pagination:

Offset Pagination

Limiting Returned Resources `/users?page[limit]={resource_count}` where {resource_count} = number of resources you want returned
e.g. `/users?page[limit]=5` will return the first 5 user resources

Offsetting Returned Resources:

`/users?page[offset]={resource_offset}` where {resource_offset} = the number of records to offset by prior to returning resources
e.g. `/users?page[offset]=10` will skip the first 10 user resources in the collection

Combining Limiting/Offsetting:

The limit and offset can be combined `/users?page[limit]={resource_count}&page[offset]={resource_offset}`
e.g. `/users?page[limit]=5&page[offset]=10` will skip user resources 0-10 and return resources 11-15

## Walkthrough of a process to add children to a parent

Say we have 3 existing scenarios, 1, 2, and 3. We want 2 to be the parent and 1 and 3 to be children. At the moment, none of them have children or parents.

Here are the steps I took to assign scenario 1 a parent. The parent is scenario 2. This makes scenario 1 a child of scenario 2.

PATCH to `https://<APP NAME>.herokuapp.com/scenarios/1` with

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

we get a 200 response, with this partial json including

```
{
	"data": {
		"id": "1",
		"type": "scenarios",
		...
		"attributes": {
			...
      ...
			"parent_scenario_id": 2,
			"ratio_for_user": 2,
			"is_parent": false,
			"is_child": true,
			"is_complete": false
		},
		"relationships": {
    ...
    ...
```

Now, we GET the parent scenario 2 - including the children with `https://<APP NAME>.herokuapp.com/scenarios/2?include=children_scenario`

which gives us a scenario stanza with the boolean "is_parent": true, and an included child scenario under "relationships", and also it adds an "included" element as a sibling of "data"  :

```
{
	"data": {
		"id": "2",
		"type": "scenarios",child
    ...
		"attributes": {
      ...
    	"parent_scenario_id": null,
			"ratio_for_user": 2,
			"is_parent": true,
			"is_child": false,
			"is_complete": false
		},
		"relationships": {
			...
      ...
			"children_scenario": {
				"links": {
					"self": "https://<APP NAME>.herokuapp.com/scenarios/2/relationships/children-scenario",
					"related": "https://<APP NAME>.herokuapp.com/scenarios/2/children-scenario"
				},
				"data": [
					{
						"type": "scenarios",
						"id": "1"
					}
				]
			},
			...
      ...
		}
	},
	"included": [
		{
			"id": "1",
			"type": "scenarios",
			"links": {
				"self": "https://<APP NAME>.herokuapp.com/scenarios/1"
			},
			"attributes": {
				"image": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/001/original/audrey.jpeg?1523932085",
				"noun": "roof",
				"event": "Hurricane Katrina",
				"imagethumb": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/001/thumb/audrey.jpeg?1523932085",
				"requesterlat": -41.2718598,
				"requesterlon": 174.7818482,
				"doerlat": -41.2718598,
				"doerlon": 174.7818482,
				"donated": "0.0",
				"funding_goal": "1000.0",
				"verified": false,
				"requester_firstname": "Audrey",
				"requester_lastname": "Audreyson",
				"doer_firstname": "jack",
				"doer_lastname": "jackson",
				"custom_message": "Help me fix my roof!",
				"parent_scenario_id": 2,
				"ratio_for_user": 2,
				"is_parent": false,
				"is_child": true,
				"is_complete": false
			},
			"relationships": {
				"verb": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/verb",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/verb"
					}
				},
				"noun": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/noun",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/noun"
					}
				},
				"requester": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/requester",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/requester"
					}
				},
				"doer": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/doer",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/doer"
					}
				},
				"event": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/event",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/event"
					}
				},
				"parent_scenario": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/parent-scenario",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/parent-scenario"
					}
				},
				"vouches": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/vouches",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/vouches"
					}
				},
				"donations": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/donations",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/donations"
					}
				},
				"children_scenario": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/children-scenario",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/children-scenario"
					}
				},
				"user_ad_interaction": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/user-ad-interaction",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/user-ad-interaction"
					}
				}
			}
		}
	]
}
```

Lets make scenario 2 the parent of the other scenario - scenario 3:

PATCH `https://<APP NAME>.herokuapp.com/scenarios/3` with

```
{
  "data": {
    "type": "scenarios",
		"id": 3,
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

We get back a 200 and a similar body to the first one.

Again, GET the parent scenario 2 - including the children with `https://<APP NAME>.herokuapp.com/scenarios/2?include=children_scenario`

we get a response that includes both children:

```
{
	"data": {
		"id": "2",
		"type": "scenarios",
    ...
		"attributes": {
			"image": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/002/original/gold.jpg?1523932087",
			...
			"parent_scenario_id": null,
			"ratio_for_user": 2,
			"is_parent": true,
			"is_child": false,
			"is_complete": false
		},
		"relationships": {
			...
      ...
			"children_scenario": {
				"links": {
					"self": "https://<APP NAME>.herokuapp.com/scenarios/2/relationships/children-scenario",
					"related": "https://<APP NAME>.herokuapp.com/scenarios/2/children-scenario"
				},
				"data": [
					{
						"type": "scenarios",
						"id": "1"
					},
					{
						"type": "scenarios",
						"id": "3"
					}
				]
			},
      ...
		}
	},
	"included": [
		{
			"id": "1",
			"type": "scenarios",
			"links": {
				"self": "https://<APP NAME>.herokuapp.com/scenarios/1"
			},
      ...
      ...
		},
		{
			"id": "3",
			"type": "scenarios",
			"links": {
				"self": "https://<APP NAME>.herokuapp.com/scenarios/3"
			},
		  ...
      ...
		}
	]
}
```


The full response is:

```
{
	"data": {
		"id": "2",
		"type": "scenarios",
		"links": {
			"self": "https://<APP NAME>.herokuapp.com/scenarios/2"
		},
		"attributes": {
			"image": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/002/original/gold.jpg?1523932087",
			"noun": "gold",
			"event": "Kaikora Earthquake",
			"imagethumb": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/002/thumb/gold.jpg?1523932087",
			"requesterlat": -41.2718598,
			"requesterlon": 174.7818482,
			"doerlat": -41.2718598,
			"doerlon": 174.7818482,
			"donated": "0.0",
			"funding_goal": "3334.43",
			"verified": false,
			"requester_firstname": "jack",
			"requester_lastname": "jackson",
			"doer_firstname": "jean",
			"doer_lastname": "jeanson",
			"custom_message": null,
			"parent_scenario_id": null,
			"ratio_for_user": 2,
			"is_parent": true,
			"is_child": false,
			"is_complete": false
		},
		"relationships": {
			"verb": {
				"links": {
					"self": "https://<APP NAME>.herokuapp.com/scenarios/2/relationships/verb",
					"related": "https://<APP NAME>.herokuapp.com/scenarios/2/verb"
				}
			},
			"noun": {
				"links": {
					"self": "https://<APP NAME>.herokuapp.com/scenarios/2/relationships/noun",
					"related": "https://<APP NAME>.herokuapp.com/scenarios/2/noun"
				}
			},
			"requester": {
				"links": {
					"self": "https://<APP NAME>.herokuapp.com/scenarios/2/relationships/requester",
					"related": "https://<APP NAME>.herokuapp.com/scenarios/2/requester"
				}
			},
			"doer": {
				"links": {
					"self": "https://<APP NAME>.herokuapp.com/scenarios/2/relationships/doer",
					"related": "https://<APP NAME>.herokuapp.com/scenarios/2/doer"
				}
			},
			"event": {
				"links": {
					"self": "https://<APP NAME>.herokuapp.com/scenarios/2/relationships/event",
					"related": "https://<APP NAME>.herokuapp.com/scenarios/2/event"
				}
			},
			"parent_scenario": {
				"links": {
					"self": "https://<APP NAME>.herokuapp.com/scenarios/2/relationships/parent-scenario",
					"related": "https://<APP NAME>.herokuapp.com/scenarios/2/parent-scenario"
				}
			},
			"vouches": {
				"links": {
					"self": "https://<APP NAME>.herokuapp.com/scenarios/2/relationships/vouches",
					"related": "https://<APP NAME>.herokuapp.com/scenarios/2/vouches"
				}
			},
			"donations": {
				"links": {
					"self": "https://<APP NAME>.herokuapp.com/scenarios/2/relationships/donations",
					"related": "https://<APP NAME>.herokuapp.com/scenarios/2/donations"
				}
			},
			"children_scenario": {
				"links": {
					"self": "https://<APP NAME>.herokuapp.com/scenarios/2/relationships/children-scenario",
					"related": "https://<APP NAME>.herokuapp.com/scenarios/2/children-scenario"
				},
				"data": [
					{
						"type": "scenarios",
						"id": "1"
					},
					{
						"type": "scenarios",
						"id": "3"
					}
				]
			},
			"user_ad_interaction": {
				"links": {
					"self": "https://<APP NAME>.herokuapp.com/scenarios/2/relationships/user-ad-interaction",
					"related": "https://<APP NAME>.herokuapp.com/scenarios/2/user-ad-interaction"
				}
			}
		}
	},
	"included": [
		{
			"id": "1",
			"type": "scenarios",
			"links": {
				"self": "https://<APP NAME>.herokuapp.com/scenarios/1"
			},
			"attributes": {
				"image": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/001/original/audrey.jpeg?1523932085",
				"noun": "roof",
				"event": "Hurricane Katrina",
				"imagethumb": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/001/thumb/audrey.jpeg?1523932085",
				"requesterlat": -41.2718598,
				"requesterlon": 174.7818482,
				"doerlat": -41.2718598,
				"doerlon": 174.7818482,
				"donated": "0.0",
				"funding_goal": "1000.0",
				"verified": false,
				"requester_firstname": "Audrey",
				"requester_lastname": "Audreyson",
				"doer_firstname": "jack",
				"doer_lastname": "jackson",
				"custom_message": "Help me fix my roof!",
				"parent_scenario_id": 2,
				"ratio_for_user": 2,
				"is_parent": false,
				"is_child": true,
				"is_complete": false
			},
			"relationships": {
				"verb": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/verb",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/verb"
					}
				},
				"noun": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/noun",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/noun"
					}
				},
				"requester": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/requester",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/requester"
					}
				},
				"doer": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/doer",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/doer"
					}
				},
				"event": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/event",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/event"
					}
				},
				"parent_scenario": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/parent-scenario",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/parent-scenario"
					}
				},
				"vouches": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/vouches",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/vouches"
					}
				},
				"donations": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/donations",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/donations"
					}
				},
				"children_scenario": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/children-scenario",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/children-scenario"
					}
				},
				"user_ad_interaction": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/1/relationships/user-ad-interaction",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/1/user-ad-interaction"
					}
				}
			}
		},
		{
			"id": "3",
			"type": "scenarios",
			"links": {
				"self": "https://<APP NAME>.herokuapp.com/scenarios/3"
			},
			"attributes": {
				"image": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/003/original/food.jpg?1523932090",
				"noun": "food",
				"event": "Kaikora Earthquake",
				"imagethumb": "//<S3 REGION>.amazonaws.com/<S3 BUCKET NAME>/scenarios/images/000/000/003/thumb/food.jpg?1523932090",
				"requesterlat": -41.2718598,
				"requesterlon": 174.7818482,
				"doerlat": -41.2855188,
				"doerlon": 174.7952354,
				"donated": "0.0",
				"funding_goal": "1111.22",
				"verified": false,
				"requester_firstname": "jean",
				"requester_lastname": "jeanson",
				"doer_firstname": "john",
				"doer_lastname": "johnson",
				"custom_message": null,
				"parent_scenario_id": 2,
				"ratio_for_user": 2,
				"is_parent": false,
				"is_child": true,
				"is_complete": false
			},
			"relationships": {
				"verb": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/3/relationships/verb",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/3/verb"
					}
				},
				"noun": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/3/relationships/noun",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/3/noun"
					}
				},
				"requester": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/3/relationships/requester",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/3/requester"
					}
				},
				"doer": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/3/relationships/doer",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/3/doer"
					}
				},
				"event": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/3/relationships/event",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/3/event"
					}
				},
				"parent_scenario": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/3/relationships/parent-scenario",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/3/parent-scenario"
					}
				},
				"vouches": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/3/relationships/vouches",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/3/vouches"
					}
				},
				"donations": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/3/relationships/donations",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/3/donations"
					}
				},
				"children_scenario": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/3/relationships/children-scenario",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/3/children-scenario"
					}
				},
				"user_ad_interaction": {
					"links": {
						"self": "https://<APP NAME>.herokuapp.com/scenarios/3/relationships/user-ad-interaction",
						"related": "https://<APP NAME>.herokuapp.com/scenarios/3/user-ad-interaction"
					}
				}
			}
		}
	]
}
```

## A list of endpoints:

Below are all the endpoints available. They all conform to the [jsonapi specifications](http://jsonapi.org/format/)

The types of ad's that can exist - requester, doer, donater and verifier at the moment
```
GET       /ad_types
POST      /ad_types
GET       /ad_types/:id
PUT|PATCH /ad_types/:id
DELETE    /ad_types/:id
```

Ways an ad can be interacted with that isn't "doing" it - "dismissed" and "served to" at the moment.
```
GET       /interaction_types
POST      /interaction_types
GET       /interaction_types/:id
PUT|PATCH /interaction_types/:id
DELETE    /interaction_types/:id
```

A list of ad interactions that a user performed - User X Dismissed the Doer ad for Scenario X:
```
GET       /user_ad_interactions
POST      /user_ad_interactions
GET       /user_ad_interactions/:id
PUT|PATCH /user_ad_interactions/:id
DELETE    /user_ad_interactions/:id
```

Any donations made by a user to a scenario:
```
GET       /donations
POST      /donations
GET       /donations/:id
PUT|PATCH /donations/:id
DELETE    /donations/:id
```

The events a scenario can be a part of - like "Kaikora Earthquake" or "Hurricane Katrina":
```
GET       /events
POST      /events
GET       /events/:id
PUT|PATCH /events/:id
DELETE    /events/:id
```

Any photos of the scenario being completed - a picture of a fixed roof, a picture of some bottles of delivered water, this is what a verifier produces:
```
GET       /vouches
POST      /vouches
GET       /vouches/:id
PUT|PATCH /vouches/:id
DELETE    /vouches/:id
```

These get and change related data - /vouches/:vouch_id/scenario gets the scenario this vouch is for
```
GET       /vouches/:vouch_id/relationships/scenario
PUT|PATCH /vouches/:vouch_id/relationships/scenario
DELETE    /vouches/:vouch_id/relationships/scenario
GET       /vouches/:vouch_id/scenario
GET       /vouches/:vouch_id/relationships/verifier
PUT|PATCH /vouches/:vouch_id/relationships/verifier
DELETE    /vouches/:vouch_id/relationships/verifier
GET       /vouches/:vouch_id/verifier
```

The scenarios requesters create, verb noun for requester. Subtasks are stored as other scenarios and can be gotten with `GET {{ base_url }}/scenarios/:scenario_id/children-scenario`
```
GET       /scenarios
POST      /scenarios
GET       /scenarios/:id
PUT|PATCH /scenarios/:id
DELETE    /scenarios/:id
GET       /scenarios/:scenario_id/relationships/verb
PUT|PATCH /scenarios/:scenario_id/relationships/verb
DELETE    /scenarios/:scenario_id/relationships/verb
GET       /scenarios/:scenario_id/verb
GET       /scenarios/:scenario_id/relationships/noun
PUT|PATCH /scenarios/:scenario_id/relationships/noun
DELETE    /scenarios/:scenario_id/relationships/noun
GET       /scenarios/:scenario_id/noun
GET       /scenarios/:scenario_id/relationships/requester
PUT|PATCH /scenarios/:scenario_id/relationships/requester
DELETE    /scenarios/:scenario_id/relationships/requester
GET       /scenarios/:scenario_id/requester
GET       /scenarios/:scenario_id/relationships/doer
PUT|PATCH /scenarios/:scenario_id/relationships/doer
DELETE    /scenarios/:scenario_id/relationships/doer
GET       /scenarios/:scenario_id/doer
GET       /scenarios/:scenario_id/relationships/event
PUT|PATCH /scenarios/:scenario_id/relationships/event
DELETE    /scenarios/:scenario_id/relationships/event
GET       /scenarios/:scenario_id/event
GET       /scenarios/:scenario_id/relationships/parent-scenario
PUT|PATCH /scenarios/:scenario_id/relationships/parent-scenario
DELETE    /scenarios/:scenario_id/relationships/parent-scenario
GET       /scenarios/:scenario_id/parent-scenario
GET       /scenarios/:scenario_id/relationships/vouches
POST      /scenarios/:scenario_id/relationships/vouches
PUT|PATCH /scenarios/:scenario_id/relationships/vouches
DELETE    /scenarios/:scenario_id/relationships/vouches
GET       /scenarios/:scenario_id/vouches
GET       /scenarios/:scenario_id/relationships/donations
POST      /scenarios/:scenario_id/relationships/donations
PUT|PATCH /scenarios/:scenario_id/relationships/donations
DELETE    /scenarios/:scenario_id/relationships/donations
GET       /scenarios/:scenario_id/donations
GET       /scenarios/:scenario_id/relationships/children-scenario
POST      /scenarios/:scenario_id/relationships/children-scenario
PUT|PATCH /scenarios/:scenario_id/relationships/children-scenario
DELETE    /scenarios/:scenario_id/relationships/children-scenario
GET       /scenarios/:scenario_id/children-scenario
GET       /scenarios/:scenario_id/relationships/user-ad-interaction
POST      /scenarios/:scenario_id/relationships/user-ad-interaction
PUT|PATCH /scenarios/:scenario_id/relationships/user-ad-interaction
DELETE    /scenarios/:scenario_id/relationships/user-ad-interaction
GET       /scenarios/:scenario_id/user-ad-interaction
```

A user:
```
GET       /users
POST      /users
GET       /users/:id
PUT|PATCH /users/:id
DELETE    /users/:id
GET       /users/:user_id/relationships/scenarios
POST      /users/:user_id/relationships/scenarios
PUT|PATCH /users/:user_id/relationships/scenarios
DELETE    /users/:user_id/relationships/scenarios
GET       /users/:user_id/scenarios
GET       /users/:user_id/relationships/requested
POST      /users/:user_id/relationships/requested
PUT|PATCH /users/:user_id/relationships/requested
DELETE    /users/:user_id/relationships/requested
GET       /users/:user_id/requested
GET       /users/:user_id/relationships/done
POST      /users/:user_id/relationships/done
PUT|PATCH /users/:user_id/relationships/done
DELETE    /users/:user_id/relationships/done
GET       /users/:user_id/done
GET       /users/:user_id/relationships/donated
POST      /users/:user_id/relationships/donated
PUT|PATCH /users/:user_id/relationships/donated
DELETE    /users/:user_id/relationships/donated
GET       /users/:user_id/donated
GET       /users/:user_id/relationships/verified
POST      /users/:user_id/relationships/verified
PUT|PATCH /users/:user_id/relationships/verified
DELETE    /users/:user_id/relationships/verified
GET       /users/:user_id/verified
```

Nouns:
```
GET       /nouns
POST      /nouns
GET       /nouns/:id
PUT|PATCH /nouns/:id
DELETE    /nouns/:id
GET       /nouns/:noun_id/relationships/scenarios
POST      /nouns/:noun_id/relationships/scenarios
PUT|PATCH /nouns/:noun_id/relationships/scenarios
DELETE    /nouns/:noun_id/relationships/scenarios
GET       /nouns/:noun_id/scenarios
```

Verbs:
```
GET       /verbs
POST      /verbs
GET       /verbs/:id
PUT|PATCH /verbs/:id
DELETE    /verbs/:id
GET       /verbs/:verb_id/relationships/scenarios
POST      /verbs/:verb_id/relationships/scenarios
PUT|PATCH /verbs/:verb_id/relationships/scenarios
DELETE    /verbs/:verb_id/relationships/scenarios
GET       /verbs/:verb_id/scenarios
```
