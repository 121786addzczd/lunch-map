# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(name: "Aya",
  profile: "都内OLです。",
  email: "aya@aya.com",
  password: "aaaaaa")
user.image.attach(io: File.open(Rails.root.join('public/images/cat.jpg')),
  filename: 'cat.jpg')

user = User.create(name: "Akira",
  profile: "趣味で筋トレしています！",
  email: "akira@akira.com",
  password: "aaaaaa")
user.image.attach(io: File.open(Rails.root.join('public/images/kintore.jpg')),
  filename: 'kintore.jpg')

user = User.create(name: "健太",
  profile: "大学4年",
  email: "kenta@kenta.com",
  password: "aaaaaa")
user.image.attach(io: File.open(Rails.root.join('public/images/dog.jpg')),
  filename: 'dog.jpg')

user = User.create(name: "NEXT",
  profile: "次にむけて",
  email: "next@next.com",
  password: "aaaaaa")
user.image.attach(io: File.open(Rails.root.join('public/images/food.jpeg')),
  filename: 'food.jpeg')