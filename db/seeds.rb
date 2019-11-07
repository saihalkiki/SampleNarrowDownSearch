# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
  Event.create(title: "イベント#{n+1}",start_datetime: "2019-11-#{n+1} #{n+6}:00:00",end_datetime: "2019-11-#{n+1} #{n+9}:00:00")
end
