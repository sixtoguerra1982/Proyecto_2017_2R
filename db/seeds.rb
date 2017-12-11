# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Menu.destroy_all
Cook.destroy_all
User.destroy_all

10.times do |i|
    if i + 1 < 6
      User.create(
      name: "usuario00#{i + 1}",
      email: "usuario01#{i + 1}@gmail.com",
      password: 'hola1234',
      password_confirmation: 'hola1234',
      phone: '+56 9 12345678',
      picture: 'default_user.png',
      cook: true,
      role: "cook"
      )
    else
      User.create(
      name: "usuario00#{i + 1}",
      email: "usuario01#{i + 1}@gmail.com",
      password: 'hola1234',
      password_confirmation: 'hola1234',
      phone: '+56 9 12345678',
      picture: 'default_user.png',
      role: "visit"
      )
    end
end

##USUARIO ADMINISTRADOR##
User.create(
  name: "Administrador La Tia.cl",
  email: "administrador@latia.cl",
  password: 'admin1234',
  password_confirmation: 'admin1234',
  phone: '+56 9 12345678',
  picture: 'default_user.png',
  role: "admin"
  )
###


cont = 1
2.times do |x|
  3.times do |i|
    Cook.create(
      name: Faker::Name.name_with_middle,
      email: 'cook01@gmail.com',
      phone: "56 9 8978675#{i + 1}",
      address: Faker::Address.street_address + " " + Faker::Address.secondary_address,
      address_region: Faker::Address.state,
      address_commune: Faker::Address.community,
      address_city: Faker::Address.city,
      picture: "cook_default.jpg",
      biography: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
      vedent, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      ##referencia con el usuario#
      user_id: cont
    )
    cont = cont + 1
  end
end


3.times do |x|
  10.times do |i|
    Menu.create(
      name:Faker::Food.dish,
      description: Faker::Food.ingredient,
      price:Faker::Commerce.price.to_i * 100,
      # picture: "http://lorempixel.com/400/200/food/#{i + 1}/",
      picture: "default_menu.png",
      cook_id: x + 1,
      date: Time.now
    )
  end
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
