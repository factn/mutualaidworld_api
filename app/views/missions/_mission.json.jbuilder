json.extract! mission, :id, :created_at, :updated_at
json.verb mission.verb.description
json.noun mission.noun.description
json.requestor mission.requestor.email
json.solver mission.solver.email
json.longitude mission.location.x
json.latitude mission.location.y

json.url mission_url(mission, format: :json)
