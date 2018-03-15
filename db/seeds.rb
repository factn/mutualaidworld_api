# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Verb.create([{ description: 'get' },
             { description: 'give' },
             { description: 'find' },
             { description: 'throw' }])

Noun.create([{ description: 'water' },
             { description: 'food' },
             { description: 'gold' },
             { description: 'child' }])

if Rails.env.development?
  User.create([{ email: 'test@example.com', password: 'password', password_confirmation: 'password' },
               { email: 'test2@example.com', password: 'password', password_confirmation: 'password' },
               { email: 'test3@example.com', password: 'password', password_confirmation: 'password' }])
end
