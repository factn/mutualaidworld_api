json.extract! scenario, :id, :created_at, :updated_at
json.verb scenario.verb.description
json.noun scenario.noun.description
json.requestor scenario.requestor.email
json.doer scenario.doer.email

json.url scenario_url(scenario, format: :json)
