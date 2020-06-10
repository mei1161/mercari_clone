# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
User.create!(email: 'mei@gmail.com', name: 'mei', password: 'password', password_confirmation: 'password',confirmed_at: DateTime.now)
PointMaster.create!(amount: 100, price: 120, started_at: DateTime.now, ended_at: '2025-12-31')
PointMaster.create!(amount: 500, price: 520, started_at: DateTime.now, ended_at: '2025-12-31')
PointMaster.create!(amount: 1000, price: 1020, started_at: DateTime.now, ended_at: '2025-12-31')