# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'costa@vixinet.ch', password: 'Helsinki', password_confirmation:'Helsinki', admin: true) unless User.find_by(email: 'costa@vixinet.ch')
User.create(email: 'sasa.arsic@netplus.ch', password: 'Helsinki', password_confirmation:'Helsinki', admin: true) unless User.find_by(email: 'sasa.arsic@netplus.ch')