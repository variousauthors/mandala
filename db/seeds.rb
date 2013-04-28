# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
# Passage.create(title: "", damage:0, population:0).phrases.create([
#   { content:"", hit_points:0 },
#   { content:"", hit_points:0 },
#   { content:"", hit_points:0 }
# ])

Passage.create(title: "cherry", damage:0, population:0).phrases.create([
  { content:"The room smells like old tatami.", hit_points:10 },
  { content:"A shoji screen of plain white rice paper has been left open to the <a href='/peach'>east</a>.", hit_points:20 },
  { content:"The north wall is open to the sun, and a garden lies <a href='/the end'>beyond a short bordwalk</a>", hit_points:30 }
])

Passage.create(title: "peach", damage:0, population:0).phrases.create([
  { content:"A musical instrument sits in the north east corner of the room.", hit_points:10 },
  { content:"It looks to have been played recently.", hit_points:20 },
  { content:"Some strings are damaged, frayed, or severed.", hit_points:5 }
])

Passage.create(title: "the end", damage:0, population:0).phrases.create([
  { content:"The room is dark, so you can't see much.", hit_points:10 },
  { content:"You can barely make out what looks like a figure.", hit_points:20 },
  { content:"Something tells you, this might be the end...", hit_points:5 }
])
