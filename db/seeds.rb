# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development? || Rails.env.test?
  Verb.create([{ description: 'get' },
               { description: 'give' },
               { description: 'find' },
               { description: 'throw' },
               { description: 'fix' }])

  Noun.create([{ description: 'water' },
               { description: 'food' },
               { description: 'gold' },
               { description: 'child' },
               { description: 'roof' },
               { description: 'nails'}])

  Event.create([{ description: 'Kaikora Earthquake' },
                { description: 'Hurricane Katrina' }])

  User.create([{ email: 'admin@example.com', firstname: 'john',    lastname: 'johnson', latitude: -41.2855188, longitude: 174.7952354, password: 'password', password_confirmation: 'password', admin: true },
               { email: 'test@example.com',  firstname: 'jack',    lastname: 'jackson', latitude: -41.2718598, longitude: 174.7818482, password: 'password', password_confirmation: 'password' },
               { email: 'test2@example.com', firstname: 'jean',    lastname: 'jeanson', latitude: -41.2718598, longitude: 174.7818482, password: 'password', password_confirmation: 'password' },
               { email: 'test3@example.com', firstname: 'jacinda', lastname: 'jacindason', latitude: -41.2718598, longitude: 174.7818482, password: 'password', password_confirmation: 'password' }])

#    User.all.each { |user| user.avatar = File.open(Dir.glob(File.join(Rails.root, 'sampleimages', '*')).sample); user.save! }

  Scenario.create([{ verb_id: 1, noun_id: 4, requester_id: 1, doer_id: 2, event_id: 1, funding_goal: '1212.34', parent_scenario_id: nil, image: File.open(Rails.root.join('vendor', 'child.jpg')) },
                   { verb_id: 2, noun_id: 3, requester_id: 2, doer_id: 3, event_id: 1, funding_goal: '3334.43', parent_scenario_id: 1,   image: File.open(Rails.root.join('vendor', 'gold.jpg'))  },
                   { verb_id: 3, noun_id: 2, requester_id: 3, doer_id: 1, event_id: 1, funding_goal: '1111.22', parent_scenario_id: 1,   image: File.open(Rails.root.join('vendor', 'food.jpg'))  },
                   { verb_id: 4, noun_id: 1, requester_id: 1, doer_id: 2, event_id: 1, funding_goal: '1111.22', parent_scenario_id: 1,   image: File.open(Rails.root.join('vendor', 'water.jpg')) },
                   { verb_id: 1, noun_id: 1, requester_id: 2, doer_id: 3, event_id: 2, funding_goal: '1111.22', parent_scenario_id: 1,   image: File.open(Rails.root.join('vendor', 'water.jpg')) },
                   { verb_id: 2, noun_id: 2, requester_id: 3, doer_id: 1, event_id: 2, funding_goal: '1111.22', parent_scenario_id: 1,   image: File.open(Rails.root.join('vendor', 'food.jpg'))  },
                   { verb_id: 3, noun_id: 3, requester_id: 1, doer_id: 2, event_id: 2, funding_goal: '1111.22', parent_scenario_id: nil, image: File.open(Rails.root.join('vendor', 'gold.jpg'))  },
                   { verb_id: 4, noun_id: 4, requester_id: 2, doer_id: 3, event_id: 2, funding_goal: '1111.22', parent_scenario_id: 7,   image: File.open(Rails.root.join('vendor', 'child.jpg')) },
                   { verb_id: 5, noun_id: 5, requester_id: 2, doer_id: 3, event_id: 2, funding_goal: '1161.22', parent_scenario_id: nil, image: File.open(Rails.root.join('vendor', 'roof.jpg'))  },
                   { verb_id: 3, noun_id: 6, requester_id: 3, doer_id: 2, event_id: 2, funding_goal: '0',       parent_scenario_id: 9,   image: File.open(Rails.root.join('vendor', 'nails.jpg')) }])

  Proof.create([{ scenario_id: 4, image: File.open(Rails.root.join('vendor', 'wetperson.jpg')) },
                { scenario_id: 6, image: File.open(Rails.root.join('vendor', 'personeating.jpg')) }])
end




# user.avatar = File.open(Dir['app/assets/images/*.jpg'].sample)
