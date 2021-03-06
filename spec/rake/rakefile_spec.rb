# encoding: utf-8

require 'spec_helper'
require 'rake'

load File.join(Rails.root, 'Rakefile')

describe "content rake tasks" do

  describe "content:prepare" do
    after do
      `git checkout db/seeds.yaml`
    end

    it "creates a file seeds.yaml that is consumable by db:seeds" do
      `rm db/seeds.yaml`
      Rake::Task['content:prepare'].invoke

      File.exists?('db/seeds.yaml').should eq true
      expect { Rake::Task['db:seed'].invoke }.to_not raise_error(Psych::SyntaxError)
    end

    describe "content#process" do
      it "processes the example file exactly as expected" do
        process('db/content/example.md').should eq processed_example
      end
    end

    describe "content#process_as_detail" do
      it "returns yaml with the keyword and content extracted" do
        process_as_detail(detail).should eq detail_yaml
      end
    end

    describe "content#process_as_phrase" do
      it "converts the phrase content to HTML and extracts hit_points" do
        process_as_phrase(phrase).should eq phrase_yaml
      end

      it "processes a phrase with no hitpoints" do
        process_as_phrase(phrase_without_hit_points).should eq phrase_without_hit_points_yaml
      end

      it "has four spaces on a new line when there are not details" do
        process_as_phrase(phrase_without_detail).should eq phrase_without_detail_yaml
      end
    end

    describe "content#process_as_title" do
      it "creates the title in yaml and opens the phrases_attributes" do
        process_as_title(title).should eq title_yaml
      end
    end

    describe "content#titles_to_html" do
      it "converts words in square braces to HTML anchors" do
        titles_to_html(phrase).should eq line_with_titles
      end

      it "converts one word in square braces to HTML anchors" do
        titles_to_html(phrase_with_one_title).should eq line_with_one_title
      end
    end

    describe "content#keywords_to_html" do
      it "converts one word in curly braces into HTML anchors" do
        keywords_to_html(phrase_with_one_detail).should eq line_with_one_keyword
      end

      it "converts two words in curly braces into HTML anchors" do
        keywords_to_html(phrase).should eq line_with_keywords
      end
    end

    describe "content#codes_to_html" do
      it "converts words in angle braces to HTML anchors" do
        codes_to_html(phrase_with_codes).should eq line_with_codes
      end

      it "converts one word in square braces to HTML anchors" do
        codes_to_html(phrase_with_one_code).should eq line_with_one_code
      end
    end
  end

  def processed_example
<<-YAML
- title: "south shoji"
  phrases_attributes:
  - content: "One long hall, with a high ceiling of plain wood planks, is separated into four rooms by sliding shoji."
    hit_points: 250
    
  - content: "The floor in each room is tiled by <a class='keyword' href='eight'>eight</a> tatami. The whole hall has a slight odor of dry grass."
    hit_points: 100
    details_attributes:
    - keyword: "eight"
      content: "Two tatami run lengthwise in the center of the room. They are capped by a tatami on either end. Four tatami flank the space."
  - content: "Standing in the southern room and looking north feels like being in a ribbed train <a class='keyword' href='tunnel'>tunnel</a>."
    hit_points: 50
    details_attributes:
    - keyword: "tunnel"
      content: "the rooms in the center of the hall are intentionally darker than those at the end, so no matter where you stand you have the impression of being deep inside, looking out."
  - content: "Bright light from the deck falls in harsh shafts through the <a class='title' href='long hall deck south'>south-east door</a>."
    hit_points: 250
    
  - content: "A softer light filters though the square rice paper panels of the east wall."
    hit_points: 30
    
  - content: "The room is dominated by the view <a class='title' href='middle shoji'>north</a>, room after room of sliding panels capped by an unassuming low table."
    hit_points: 100
    
  - content: "However, the opaque pale beige <a class='keyword' href='screens'>screens</a> that separate each room, and adorn the west wall, also tug at your attention."
    hit_points: 20
    details_attributes:
    - keyword: "screens"
      content: "Each screen was delicately painted with some natural seen; some of the paintings are hundreds of years old and are faded beyond recognition."
- title: "middle shoji"
  phrases_attributes:
  - content: "One long hall, with a high ceiling of plain wood planks, is separated into four rooms by sliding shoji."
    hit_points: 100
    
  - content: "The floor in each room is tiled by <a class='keyword' href='eight'>eight</a> tatami. The whole hall has a slight odor of dry grass."
    hit_points: 50
    details_attributes:
    - keyword: "eight"
      content: "Two tatami run lengthwise in the center of the room. They are capped by a tatami on either end. Four tatami flank the space."
  - content: "The light here is exclusively that which <a class='keyword' href='filters'>filters</a> through the square rice paper panels on the east wall."
    hit_points: 50
    details_attributes:
    - keyword: "filters"
      content: "There is no artificial light, and at night the hall is pitch black. Few people know this, because no one really uses the hall."
  - content: "<a href='Looking' class='action'>Looking</a> <a class='title' href='tokonoma shoji'>north</a> or <a class='title' href='south shoji'>south</a> you <a href='feel' class='action'>feel</a> as though you are <a class='keyword' href='peering'>peering</a> out from the ribs of a well preserved <a class='keyword' href='fossil'>fossil</a>."
    hit_points: 30
    details_attributes:
    - keyword: "peering"
      content: "Here, near the middle of the long hall, the light is very dim. The bright lights at either end play tricks on your night-vision."
    - keyword: "fossil"
      content: "Even the plants are dead, in a sense: the gardens have not changed in decades, and every flower is exactly where is was last spring."
  - content: "At the <a class='title' href='tokonoma shoji'>north</a> end of the hall, past two more sliding screens, there is a small table set against glowing rice paper panels."
    hit_points: 40
    
  - content: "Painted on the opaque beige shoji making up the western wall is a seen of a whether worn <a class='keyword' href='coast'>coast</a>."
    hit_points: 20
    details_attributes:
    - keyword: "coast"
      content: "You can barely make out the outline of a boat, sailing away."
- title: "second garden"
  phrases_attributes:
  - content: "The air here is cold, there is a <a class='keyword' href='breeze'>breeze</a>. It was much warmer <a class='title' href='north garden view'>inside</a>."
    hit_points: 15
    details_attributes:
    - keyword: "breeze"
      content: "Maybe you should move back inside?"
  - content: "The second garden is more of a back yard. It is more a thing of accidental beauty than the garden guests are shown."
    hit_points: 10
    
  - content: "The little girl looks up at you as you approach. She considers you gravely."
    hit_points: 6
    
  - content: "\\"てんぐ、ね？\\" she says sympathetically, pointing at her nose."
    hit_points: 4
    
  - content: "\\"はい\\", the girl mumbles as she reaches into her sode and produces a tiny <a class='keyword' href='candy'>candy</a>, wrapped in colorful foil. \\"これ、あげるから\\" she smiles, handing you the candy."
    hit_points: 2
    details_attributes:
    - keyword: "candy"
      content: "It is orange flavor."
YAML
  end

  def phrase
    "<<action \"Looking\">> [[north|tokonoma shoji]] or [[south|south shoji]] you feel as though you are { peering } out from the ribs of a well preserved { fossil }.|30|"
  end

  def phrase_with_one_title
    "<<action \"Looking\">> north or [[south|south shoji]] you feel as though you are { peering } out from the ribs of a well preserved { fossil }.|30|"
  end

  def phrase_with_codes
    "<<action \"Looking\">> [[north|tokonoma shoji]] or [[south|south shoji]] you <<action \"feel\">> as though you are { peering } out from the ribs of a well preserved { fossil }.|30|"
  end

  def phrase_with_one_code
    "<<action \"Looking\">> [[north|tokonoma shoji]] or [[south|south shoji]] you feel as though you are { peering } out from the ribs of a well preserved { fossil }.|30|"
  end

  def phrase_yaml
<<-YAML
  - content: "<a href='Looking' class='action'>Looking</a> <a class='title' href='tokonoma shoji'>north</a> or <a class='title' href='south shoji'>south</a> you feel as though you are <a class='keyword' href='peering'>peering</a> out from the ribs of a well preserved <a class='keyword' href='fossil'>fossil</a>."
    hit_points: 30
    details_attributes:
YAML
  end

  def phrase_with_one_detail
    "<<action \"Looking\">> [[north|tokonoma shoji]] or [[south|south shoji]] you feel as though you are peering out from the ribs of a well preserved { fossil }.|30|"
  end

  def phrase_without_detail
    "One long hall, with a heigh ceiling of plane wood planks, is separated into four rooms by sliding shoji.|250|"
  end

  def phrase_without_detail_yaml
<<-YAML
  - content: "One long hall, with a heigh ceiling of plane wood planks, is separated into four rooms by sliding shoji."
    hit_points: 250
    
YAML
  end

  def phrase_without_hit_points
    "One long hall, with a heigh ceiling of plane wood planks, is separated into four rooms by sliding shoji."
  end

  def phrase_without_hit_points_yaml
<<-YAML
  - content: "One long hall, with a heigh ceiling of plane wood planks, is separated into four rooms by sliding shoji."
    hit_points: 
    
YAML
  end
  def detail
    "peering: Here, near the middle of the long hall, the light is very dim. The bright lights at either end play tricks on your night-vision."
  end

  def detail_yaml
<<-YAML
    - keyword: "peering"
      content: "Here, near the middle of the long hall, the light is very dim. The bright lights at either end play tricks on your night-vision."
YAML
  end

  def title
    "#tokonoma shoji"
  end

  def title_yaml
<<-YAML
- title: "tokonoma shoji"
  phrases_attributes:
YAML
  end

  def line_with_keywords
    "<<action \"Looking\">> [[north|tokonoma shoji]] or [[south|south shoji]] you feel as though you are <a class='keyword' href='peering'>peering</a> out from the ribs of a well preserved <a class='keyword' href='fossil'>fossil</a>.|30|"
  end

  def line_with_one_keyword
    "<<action \"Looking\">> [[north|tokonoma shoji]] or [[south|south shoji]] you feel as though you are peering out from the ribs of a well preserved <a class='keyword' href='fossil'>fossil</a>.|30|"
  end

  def line_with_titles
    "<<action \"Looking\">> <a class='title' href='tokonoma shoji'>north</a> or <a class='title' href='south shoji'>south</a> you feel as though you are { peering } out from the ribs of a well preserved { fossil }.|30|"
  end

  def line_with_one_title
    "<<action \"Looking\">> north or <a class='title' href='south shoji'>south</a> you feel as though you are { peering } out from the ribs of a well preserved { fossil }.|30|"
  end

  def line_with_codes
    "<a href='Looking' class='action'>Looking</a> [[north|tokonoma shoji]] or [[south|south shoji]] you <a href='feel' class='action'>feel</a> as though you are { peering } out from the ribs of a well preserved { fossil }.|30|"
  end

  def line_with_one_code
    "<a href='Looking' class='action'>Looking</a> [[north|tokonoma shoji]] or [[south|south shoji]] you feel as though you are { peering } out from the ribs of a well preserved { fossil }.|30|"
  end
end
