#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Mandala::Application.load_tasks

namespace :content do
  desc "Processes the .md files in db/content/ starting with perimeter. The output is db/seeds.yaml"
  task "prepare" do

    # open the seeds.yaml file for writing
    File.open('db/seeds.yaml', 'w') do |seeds|

      perimeter = "db/content/perimeter.md"
      contents_files = Dir.glob('db/content/*') - [ perimeter ]

      # process perimeter
      seed = process(perimeter)
      seeds.write(seed)

      # process contents
      contents_files.each do |file|
        unless file == 'db/content/example.md' then
          seed = process(file)
          seeds.write(seed)
        end
      end
    end
  end

  def process(file_name)
    result = ""

    File.open(file_name) do |file|
      file.each_with_index do |line, number|

        begin
          result << process_line(line) unless line.blank?
        rescue Exception => e
          puts "while processing #{ file_name } line ##{ number + 1 }: "
          puts e.message
          puts "\n  #{ number + 1 }: #{ line }\n"
          raise
        end
      end
    end

    return result
  end

  def process_line(line)
    # escape quotes
    line.gsub!('"', '\"')
    case line[0]
      when "#"
        process_as_title(line)
      when " "
        process_as_detail(line)
      else
        process_as_phrase(line)
    end
  end

  def process_as_title(title)
    title[0] = ''

# this indentation is important!
<<-YAML
- title: "#{title.strip}"
  phrases_attributes:
YAML
  end

  def process_as_phrase(line)
    # replace keywords and titles with html
    line = keywords_to_html(line)
    line = titles_to_html(line)

    if line.include?("class='keyword'") then
      detail_string = "details_attributes:"
    end

    # get the hp from the back of the string
    hp = line.match(/\|(\d*?)\|$/)
    content = line.tr(hp[0], '')
    hp = hp[1]

# this indentation is important!
<<-YAML
  - content: "#{content.strip}"
    hit_points: #{hp}
    #{detail_string.to_s}
YAML
  end

  def process_as_detail(line)
    parts = line.split(":")
    keyword = parts.shift
    content = parts.join(":")

# this indentation is important!
<<-YAML
    - keyword: "#{keyword.strip}"
      content: "#{content.strip}"
YAML
  end

  def titles_to_html(line)
    # instead of [ text | href ]
    # we will do [[text|href]]
    links = line.scan(/\[\[(.*?)\|(.*?)\]\]/)
    return line unless links

    links.each do |link|
      text, href = link
      line.gsub!(/\[\[#{text}\|#{href}\]\]/, "<a class='title' href='#{href.strip}'>#{text.strip}</a>")
    end

    line
  end

  def keywords_to_html(line)
    keywords = line.scan(/{(.*?)}/).flatten
    return line unless keywords

    keywords.each do |keyword|
      line.gsub!(/{#{keyword}}/, "<a class='keyword' href='#{keyword.strip}'>#{keyword.strip}</a>")
    end

    line
  end
end
