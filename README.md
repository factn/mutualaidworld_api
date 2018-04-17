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
			"image": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/001/original/audrey.jpeg?1523492350",
			"noun": "roof",
			"event": "Hurricane Katrina",
			"imagethumb": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/001/thumb/audrey.jpeg?1523492350",
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
			"proofs": {
				"links": {
					"self": "http://localhost:3000/scenarios/1/relationships/proofs",
					"related": "http://localhost:3000/scenarios/1/proofs"
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
				"proofs": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/proofs",
						"related": "http://localhost:3000/scenarios/11/proofs"
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
				"proofs": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/proofs",
						"related": "http://localhost:3000/scenarios/12/proofs"
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
				"proofs": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/proofs",
						"related": "http://localhost:3000/scenarios/13/proofs"
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
				"image": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/001/original/audrey.jpeg?1523492350",
				"noun": "roof",
				"event": "Hurricane Katrina",
				"imagethumb": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/001/thumb/audrey.jpeg?1523492350",
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
				"proofs": {
					"links": {
						"self": "http://localhost:3000/scenarios/1/relationships/proofs",
						"related": "http://localhost:3000/scenarios/1/proofs"
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
				"proofs": {
					"links": {
						"self": "http://localhost:3000/scenarios/11/relationships/proofs",
						"related": "http://localhost:3000/scenarios/11/proofs"
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
				"proofs": {
					"links": {
						"self": "http://localhost:3000/scenarios/12/relationships/proofs",
						"related": "http://localhost:3000/scenarios/12/proofs"
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
				"proofs": {
					"links": {
						"self": "http://localhost:3000/scenarios/13/relationships/proofs",
						"related": "http://localhost:3000/scenarios/13/proofs"
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
				"image": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/023/original/data?1523500422",
				"noun": "nails",
				"event": "Hurricane Katrina",
				"imagethumb": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/023/thumb/data?1523500422",
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
				"proofs": {
					"links": {
						"self": "http://localhost:3000/scenarios/23/relationships/proofs",
						"related": "http://localhost:3000/scenarios/23/proofs"
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
				"image": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/024/original/data?1523500422",
				"noun": "labourer",
				"event": "Hurricane Katrina",
				"imagethumb": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/024/thumb/data?1523500422",
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
				"proofs": {
					"links": {
						"self": "http://localhost:3000/scenarios/24/relationships/proofs",
						"related": "http://localhost:3000/scenarios/24/proofs"
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
				"image": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/025/original/data?1523500422",
				"noun": "volunteers",
				"event": "Hurricane Katrina",
				"imagethumb": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/025/thumb/data?1523500422",
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
				"proofs": {
					"links": {
						"self": "http://localhost:3000/scenarios/25/relationships/proofs",
						"related": "http://localhost:3000/scenarios/25/proofs"
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
				"image": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/027/original/data?1523500499",
				"noun": "labourer",
				"event": "Kaikora Earthquake",
				"imagethumb": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/027/thumb/data?1523500499",
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
				"proofs": {
					"links": {
						"self": "http://localhost:3000/scenarios/27/relationships/proofs",
						"related": "http://localhost:3000/scenarios/27/proofs"
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
				"image": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/028/original/data?1523500499",
				"noun": "nails",
				"event": "Kaikora Earthquake",
				"imagethumb": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/028/thumb/data?1523500499",
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
				"proofs": {
					"links": {
						"self": "http://localhost:3000/scenarios/28/relationships/proofs",
						"related": "http://localhost:3000/scenarios/28/proofs"
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
				"image": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/029/original/data?1523500499",
				"noun": "volunteers",
				"event": "Kaikora Earthquake",
				"imagethumb": "//s3-ap-southeast-2.amazonaws.com/lion-uat/scenarios/images/000/000/029/thumb/data?1523500499",
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
				"proofs": {
					"links": {
						"self": "http://localhost:3000/scenarios/29/relationships/proofs",
						"related": "http://localhost:3000/scenarios/29/proofs"
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

Pagination:

```
Offset Pagination

Limiting Returned Resources:

    /users?page[limit]={resource_count}
    {resource_count} = number of resources you want returned
    e.g. /users?page[limit]=5 will return the first 5 user resources

Offsetting Returned Resources:

    /users?page[offset]={resource_offset}
    {resource_offset} = the number of records to offset by prior to returning resources
    e.g. /users?page[offset]=10 will skip the first 10 user resources in the collection

Combining Limiting/Offsetting:

    /users?page[limit]={resource_count}&page[offset]={resource_offset}
    e.g. /users?page[limit]=5&page[offset]=10 will skip user resources 0-10 and return resources 11-15
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
