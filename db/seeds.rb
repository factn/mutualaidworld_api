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
               { description: 'throw' }])

  Noun.create([{ description: 'water' },
               { description: 'food' },
               { description: 'gold' },
               { description: 'child' }])

  User.create([{ email: 'test@example.com', password: 'password', password_confirmation: 'password' },
               { email: 'test2@example.com', password: 'password', password_confirmation: 'password' },
               { email: 'test3@example.com', password: 'password', password_confirmation: 'password' }])

  Scenario.create([{verb_id: 1, noun_id: 4, requestor_id: 1, doer_id: 2},
                   {verb_id: 2, noun_id: 3, requestor_id: 2, doer_id: 3},
                   {verb_id: 3, noun_id: 2, requestor_id: 3, doer_id: 1},
                   {verb_id: 4, noun_id: 1, requestor_id: 1, doer_id: 2},
                   {verb_id: 4, noun_id: 1, requestor_id: 2, doer_id: 3},
                   {verb_id: 3, noun_id: 2, requestor_id: 3, doer_id: 1},
                   {verb_id: 2, noun_id: 3, requestor_id: 1, doer_id: 2},
                   {verb_id: 1, noun_id: 4, requestor_id: 2, doer_id: 3}])

end
