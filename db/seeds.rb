require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Users
Post.create(title:Faker::Lorem.sentence(word_count: 7), content: Faker::Lorem.paragraph, user_id: User.all.sample.id)

Comment.create(user_id: User.all.sample.id, body: Faker::Lorem.paragraph, commentable_id: rand(10))

# Tags
Tag.create(name: :feature)
Tag.create(name: :bug)


