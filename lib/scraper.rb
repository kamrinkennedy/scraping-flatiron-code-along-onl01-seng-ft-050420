require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative './course.rb'

class Scraper
  
  def get_page
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    
    # doc.css(".post").each do |post|
    #   course = Course.new
    #   course.title = doc.css(".post").first.css("h2").text
    #   course.schedule = doc.css(".post").first.css(".date").text
    #   course.description = doc.css(".post").first.css("p").text
    # end
    # doc.css(".post") << collection of courses
    # doc.css(".post").first.css("h2").text << title
    # doc.css(".post").first.css(".date").text << schedule
    # doc.css(".post").first.css("p").text << description
    # binding.pry
  end 
  
  def get_courses
    self.get_page.css(".post")
  end 
  
  def make_courses 
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css(".post").first.css("h2").text
      course.schedule = post.css(".post").first.css(".date").text
      course.description = post.css(".post").first.css("p").text
    end
  end
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end

Scraper.new.get_page

