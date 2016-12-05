require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

# FROM: http://ruby.bastardsbook.com/chapters/web-crawling/#h-2-2

# 1.) Crawl link to link
# 2.) Crawl by using search

# TODO: 
# - make it recursive
#   - base case when no new links were added

class Crawler
  def initialize(root_url)
    @root_url = root_url
    @links = []
    puts "Crawling #{root_url}"
  end

  def call
    get_links_from_url(@root_url)
    binding.pry
  end
  
private 

  def get_links_from_url(url)
    page = Nokogiri::HTML(open(url))
    link_elements = page.css('a')

    links = []
    link_elements.each do |link| 
      link = link.attribute('href').to_s
      if !link.empty? && link.start_with?('/') && !@links.include?(link)
        links << link
      end
    end

    @links.concat(links)
  end
end

COUNCIL_PAGES = [
  "https://www.islington.gov.uk",
  "http://www.camden.gov.uk",
  "https://www.lambeth.gov.uk",
  "https://www.westminster.gov.uk",
]

Crawler.new(COUNCIL_PAGES.sample).call
