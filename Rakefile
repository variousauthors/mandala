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
        seed = process(file)
        seeds.write(seed)

      end
    end
  end

  def process(file_name)
    puts "processing #{file_name}"
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

    puts "finished processing #{file_name}"
    return result
  end

  def process_line(line)
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
<<-EOS
- title: "#{title.strip}"
  phrases_attributes:
EOS
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
<<-EOS
  - content: "#{content.strip}"
    hit_points: #{hp}
    #{detail_string.to_s}
EOS
  end

  def process_as_detail(line)
    keyword, content = line.split(':')

# this indentation is important!
<<-EOS
    - keyword: "#{keyword.strip}"
      content: "#{content.strip}"
EOS
  end

  def titles_to_html(line)
    text, href = line.scan(/\[(.*?)\|(.*?)\]/).flatten
    return line unless href && text

    line.gsub(/\[.*?\|.*?\]/, "<a class='title' href='#{href.strip}'>#{text.strip}</a>")
  end

  def keywords_to_html(line)
    keyword = line.scan(/{(.*?)}/).flatten[0]
    return line unless keyword

    line.gsub(/{(.*?)}/, "<a class='keyword' href='#{keyword.strip}'>#{keyword.strip}</a>")
  end
end
