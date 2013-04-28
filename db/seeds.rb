# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' , blank: false }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
# Passage.create(title: "", damage:0, population:0).phrases.create([
#   { content:"", hit_points:0 , blank: false },
#   { content:"", hit_points:0 , blank: false },
#   { content:"", hit_points:0 , blank: false }
# ])

params =  { :passage =>
  {
    :title => 'room with details',
    :phrases_attributes => [
      {
        :content => 'A <a class="keyword" href="fancy">fancy</a> room full of <a class="keyword" href="life">life</a>.',
        :hit_points => 10,
        :details_attributes => [
          {
            :keyword => 'life',
            :content => 'that stuff that crawls around the earth'
          },
          {
            :keyword => 'fancy',
            :content => 'But not... too fancy'
          }]
      },
      {
        :content => 'There is a table in the center of the room.',
        :hit_points => 10,
      },
      {
        :content => 'On the table, rests a <a class="keyword" href="knife">knife</a>',
        :hit_points => 10,
        :details_attributes => [
          {
            :keyword => 'knife',
            :content => 'rhymes with life...'
          }]
      }]
  }
}

Passage.create!(params[:passage])

Passage.create(title: "cherry", damage:0, population:0).phrases.create([
  { content:"The room smells like old tatami.", hit_points:10 , blank: false },
  { content:"Testing <a class='title' href='room with details'>testing</a>", hit_points:10 , blank: false },
  { content:"A shoji screen of plain white rice paper has been left open to the <a class='title' href='peach'>east</a>.", hit_points:5 , blank: false },
  { content:"The north wall is open to the sun, and a garden lies <a class='title' href='the end'>beyond a short bordwalk</a>", hit_points:30 , blank: false }
])

Passage.create(title: "peach", damage:0, population:0).phrases.create([
  { content:"A musical instrument sits in the north east corner of the room.", hit_points:10 , blank: false },
  { content:"It looks to have been played recently.", hit_points:5 , blank: false },
  { content:"Some strings are damaged, frayed, or severed.", hit_points:20 , blank: false }
])

Passage.create(title: "the end", damage:0, population:0).phrases.create([
  { content:"The room is dark, so you can't see much.", hit_points:10 , blank: false },
  { content:"You can barely make out what looks like a figure.", hit_points:10 , blank: false },
  { content:"Something tells you, this might be the end...", hit_points:5 , blank: false }
])
