# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: 'Daniel Costa', email: 'daniel@miam.ch', phone: '0793111856', password: 'uU39248204', password_confirmation:'uU39248204', admin: true) unless User.find_by(email: 'daniel@miam.ch')
User.create(name: 'Sasa Arsic', email: 'sasa@miam.ch', phone: '0786597787', password: 'Hels!nk!.3976', password_confirmation:'Hels!nk!.3976', admin: true) unless User.find_by(email: 'sasa@miam.ch')
# Merchant.create(business_name: 'Vixinet', business_id: '2767495-3', vat: 'FI27674953', address: 'Plantassage 4', city: 'Noës', zip_code: '3976', contact_person: 'Daniel Costa', phone: '+41 79 3111856', email: 'costa@vixinet.ch') unless Merchant.find_by(business_name: 'Vixinet')
# m = Merchant.create(business_name: 'Le Capri', business_id: '', vat: '', address: 'Route de Sion 5', city: 'Sierre', zip_code: '3960', contact_person: '', phone: '', email: '') unless Merchant.find_by(business_name: 'Le Capri')
# Venue.create(status: 0, name: 'Le Capri', title: 'Restaurant Pizzeria', phone: '+41 27 4557412', website: 'http://www.lecapri.ch', merchant_id: m.id) unless Venue.find_by(name: 'Le Capri')