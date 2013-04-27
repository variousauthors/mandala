# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

Passage.create(title: "first", damage:0, population:0).phrases.create([
  { content:"The room is dark, so you can't see much.", hit_points:10 },
  { content:"You can barely make out what looks like a figure.", hit_points:20 },
  { content:"Something tells you, this might be the end...", hit_points:5 }
])
