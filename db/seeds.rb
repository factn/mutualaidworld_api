# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development? || Rails.env.test?
  puts 'lookup data'
  # lookup data
  verbs = %w[get deliver find throw fix patch attach borrow]
  nouns = ['water', 'food', 'gold', 'child', 'roof', 'nails', 'materials', 'corrugated iron', 'h4 2x4 rafters', 'waratah', 'tarpaulin', 'rope', 'truck', 'car', 'ute', 'airboat', 'labourer', 'volunteers', 'transportation']
  events = ['Kaikora Earthquake', 'Hurricane Katrina']
  adtypes = %w[doer requester donator verifier]
  interactiontypes = ['served to', 'dismissed']

  verbs.each do |x|
    Verb.create(description: x)
  end

  nouns.each do |x|
    Noun.create(description: x)
  end

  events.each do |x|
    Event.create(description: x)
  end

  adtypes.each do |x|
    AdType.create(description: x)
  end

  interactiontypes.each do |x|
    InteractionType.create(description: x)
  end

  puts 'users'
  User.create([{ email: 'admin@example.com',  firstname: 'john',   lastname: 'johnson',   latitude: -41.2855188, longitude: 174.7952354, password: 'password', password_confirmation: 'password', avatar: File.open(Rails.root.join('vendor', 'avatars', 'face1.jpg')), admin: true },
               { email: 'test@example.com',   firstname: 'jack',   lastname: 'jackson',   latitude: -41.2718598, longitude: 174.7818482, password: 'password', password_confirmation: 'password', avatar: File.open(Rails.root.join('vendor', 'avatars', 'face2.jpg'))},
               { email: 'test2@example.com',  firstname: 'jean',   lastname: 'jeanson',   latitude: -41.2718598, longitude: 174.7818482, password: 'password', password_confirmation: 'password', avatar: File.open(Rails.root.join('vendor', 'avatars', 'face3.jpg'))},
               { email: 'Audrey@example.com', firstname: 'Audrey', lastname: 'Audreyson', latitude: -41.2718598, longitude: 174.7818482, password: 'password', password_confirmation: 'password', avatar: File.open(Rails.root.join('vendor', 'avatars', 'face4.jpg'))},
               { email: 'tracey@example.com', firstname: 'Tracey', lastname: 'Traceyson', latitude: -41.2718598, longitude: 174.7818482, password: 'password', password_confirmation: 'password', avatar: File.open(Rails.root.join('vendor', 'avatars', 'face5.jpg'))},
               { email: 'terry@example.com',  firstname: 'Terry',  lastname: 'Terryson',  latitude: -41.2718598, longitude: 174.7818482, password: 'password', password_confirmation: 'password', avatar: File.open(Rails.root.join('vendor', 'avatars', 'face6.jpg'))},
               { email: 'simon@example.com',  firstname: 'Simon',  lastname: 'Simonson',  latitude: -41.2718598, longitude: 174.7818482, password: 'password', password_confirmation: 'password', avatar: File.open(Rails.root.join('vendor', 'avatars', 'face7.jpg'))},
               { email: 'sally@example.com',  firstname: 'Sally',  lastname: 'Sallyson',  latitude: -41.2718598, longitude: 174.7818482, password: 'password', password_confirmation: 'password', avatar: File.open(Rails.root.join('vendor', 'avatars', 'face8.jpg'))
              }])

  #    User.all.each { |user| user.avatar = File.open(Dir.glob(File.join(Rails.root, 'sampleimages', '*')).sample); user.save! }
  puts 'scenarios'

  Scenario.create([{ verb_id: 6, noun_id: 5, requester_id: 4, doer_id: 2, event_id: 2, funding_goal: '1000.00', parent_scenario_id: nil, custom_message: 'Help me fix my roof!', image: File.open(Rails.root.join('vendor', 'audrey.jpeg')) },
                   { verb_id: 2, noun_id: 3, requester_id: 2, doer_id: 3, event_id: 1, funding_goal: '3334.43', parent_scenario_id: nil, custom_message: nil,                    image: File.open(Rails.root.join('vendor', 'gold.jpg'))  },
                   { verb_id: 3, noun_id: 2, requester_id: 3, doer_id: 1, event_id: 1, funding_goal: '1111.22', parent_scenario_id: nil, custom_message: nil,                    image: File.open(Rails.root.join('vendor', 'food.jpg'))  },
                   { verb_id: 4, noun_id: 1, requester_id: 1, doer_id: 2, event_id: 1, funding_goal: '1111.22', parent_scenario_id: nil, custom_message: nil,                    image: File.open(Rails.root.join('vendor', 'water.jpg')) },
                   { verb_id: 1, noun_id: 1, requester_id: 2, doer_id: 3, event_id: 2, funding_goal: '1111.22', parent_scenario_id: nil, custom_message: nil,                    image: File.open(Rails.root.join('vendor', 'water.jpg')) },
                   { verb_id: 2, noun_id: 2, requester_id: 3, doer_id: 1, event_id: 2, funding_goal: '1111.22', parent_scenario_id: nil, custom_message: nil,                    image: File.open(Rails.root.join('vendor', 'food.jpg'))  },
                   { verb_id: 3, noun_id: 3, requester_id: 1, doer_id: 2, event_id: 2, funding_goal: '1111.22', parent_scenario_id: nil, custom_message: nil,                    image: File.open(Rails.root.join('vendor', 'gold.jpg')) },
                   { verb_id: 4, noun_id: 4, requester_id: 2, doer_id: 3, event_id: 2, funding_goal: '1111.22', parent_scenario_id: nil, custom_message: nil,                    image: File.open(Rails.root.join('vendor', 'child.jpg')) },
                   { verb_id: 5, noun_id: 5, requester_id: 2, doer_id: 3, event_id: 2, funding_goal: '1161.22', parent_scenario_id: nil, custom_message: nil,                    image: File.open(Rails.root.join('vendor', 'roof.jpg')) },
                   { verb_id: 3, noun_id: 6, requester_id: 3, doer_id: 2, event_id: 2, funding_goal: '0',       parent_scenario_id: nil, custom_message: nil,                    image: File.open(Rails.root.join('vendor', 'nails.jpg')) }])

  Scenario.create(verb_id: Verb.find_by(description: 'get').id,
                  noun_id: Noun.find_by(description: 'materials').id,
                  requester_id: User.find_by(email: 'test@example.com').id,
                  doer_id: nil,
                  event_id: Event.find_by(description: 'Hurricane Katrina').id,
                  funding_goal: nil,
                  parent_scenario_id: 1,
                  image: nil)

  Scenario.create(verb_id: Verb.find_by(description: 'get').id,
                  noun_id: Noun.find_by(description: 'transportation').id,
                  requester_id: User.find_by(email: 'test@example.com').id,
                  doer_id: nil,
                  event_id: Event.find_by(description: 'Hurricane Katrina').id,
                  funding_goal: nil,
                  parent_scenario_id: 1,
                  image: nil)

  Scenario.create(verb_id: Verb.find_by(description: 'get').id,
                  noun_id: Noun.find_by(description: 'volunteers').id,
                  requester_id: User.find_by(email: 'test@example.com').id,
                  doer_id: nil,
                  event_id: Event.find_by(description: 'Hurricane Katrina').id,
                  funding_goal: nil,
                  parent_scenario_id: 1,
                  image: nil)

  puts 'proofs'

  Proof.create([{ scenario_id: 4, verifier_id: 1, image: File.open(Rails.root.join('vendor', 'wetperson.jpg')) },
                { scenario_id: 6, verifier_id: 2, image: File.open(Rails.root.join('vendor', 'personeating.jpg')) }])

  puts 'ad user interactions'
  UserAdInteraction.create([{ user_id: 1, interaction_type_id: 1, ad_type_id: 1, scenario_id: 4 },
                            { user_id: 2, interaction_type_id: 2, ad_type_id: 2, scenario_id: 4 },
                            { user_id: 3, interaction_type_id: 1, ad_type_id: 3, scenario_id: 4 }])

end

# user.avatar = File.open(Dir['app/assets/images/*.jpg'].sample)
