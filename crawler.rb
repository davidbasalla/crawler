require 'rubygems'
require 'spidr'
require 'robots'
require 'pry'

# FROM: http://ruby.bastardsbook.com/chapters/web-crawling/#h-2-2
# 1.) Crawl link to link
# 2.) Crawl by using search

class Crawler
  IGNORED_EXTENSIONS = ['js', 'css', 'pdf', 'png', 'ico', 'doc', 'docx', 'ppt']

  def initialize(root_url)
    @root_url = root_url
    @urls = []
    puts "Crawling #{root_url}"
  end

  def call
    Spidr.site(@root_url, 
               robots: true,
               ignore_exts: IGNORED_EXTENSIONS
      ) do |spider|
      spider.every_url do |url| 
        puts url
        @urls << url
      end
    end

    puts
    puts "URLs:"
    puts @urls
  end
end

COUNCIL_PAGES = [
  "https://www.islington.gov.uk",
  "http://www.camden.gov.uk",
  "https://www.lambeth.gov.uk",
  "https://www.westminster.gov.uk",
  "http://www.basildon.gov.uk/",
]

Crawler.new(COUNCIL_PAGES.sample).call
