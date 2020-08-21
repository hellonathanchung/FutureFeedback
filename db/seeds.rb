# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Scorched earth campaign prior to seeding, buckle up:
PostTag.destroy_all
Tag.destroy_all
Comment.destroy_all
Post.destroy_all
User.destroy_all

#Users/:moderator
3.times do
 User.create(email: Faker::Internet.email, password: "tested", password_confirmation: "tested", role: 1)
end

#Users/:user
20.times do
 User.create(email: Faker::Internet.email, password: "tested", password_confirmation: "tested")
end

#posts
20.times do
 Post.create(title: Faker::Lorem.words(number: 6, supplemental: true).join(' ').titleize, content: Faker::Hipster.paragraph(sentence_count: 8), user_id: User.all.sample.id)
 Post.create(title: Faker::Lorem.words(number: 6, supplemental: true).join(' ').titleize, content: Faker::Hipster.paragraph(sentence_count: 8), user_id: User.all.sample.id, status: "closed")
 Post.create(title: Faker::Lorem.words(number: 6, supplemental: true).join(' ').titleize, content: Faker::Hipster.paragraph(sentence_count: 8), user_id: User.all.sample.id, status: "pending")
 Post.create(title: Faker::Lorem.words(number: 6, supplemental: true).join(' ').titleize, content: Faker::Hipster.paragraph(sentence_count: 8), user_id: User.all.sample.id, status: "resolved")

end

#comments
100.times do
 Comment.create(user_id: User.all.sample.id, body: Faker::Lorem.paragraph, commentable_id: Comment.all.sample.id, commentable_type: "Comment")
 Comment.create(user_id: User.all.sample.id, body: Faker::Lorem.paragraph, commentable_id: Post.all.sample.id, commentable_type: "Post")
end

# Tags
10.times do 
 Tag.create(name: Faker::Lorem.word)
end

#PostTag
10.times do  
 PostTag.create(post_id: Post.all.sample.id, tag_id: Tag.all.sample.id)
end

# Users/:admin
User.create(email: "chung.nathanh@gmail.com", password: "12345!", password_confirmation: "12345!", role: 2)
User.create(email: "after.alec@gmail.com", password: "tested", password_confirmation: "tested", role: 2)
  