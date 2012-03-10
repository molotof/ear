require 'open-uri'
require 'nokogiri'
  
module Ear
module Client
module Twitter

  # This class represents the corpwatch service
  class TwitterMediaScraper

    def initialize
    
    end

    # 
    # Takes: Nothing
    # 
    # Ruturns: An array of corpwatch corps from the search 
    #
    def search_by_user(username, pages=4)
      # Convert to a get-paramenter
      username = CGI.escapeHTML username
      username.gsub!(" ", "&nbsp;")
    
      # initialize an array of corps to return 
      pics = []

      #@task_logger.log "Using Company URI: #{uri}"
      search_uri = "https://twitter.com/#!/#{username}/media/grid"

      #binding.pry

      # Open page & parse
      doc = Nokogiri::HTML(open(search_uri, {"User-Agent" => EAR::USER_AGENT_STRING})) do |config|
        config.noblanks
      end
    
      binding.pry

      # for each thumbnail
      doc.xpath("/html/body/div/div[3]/div/div[2]/div").each do |path|

        puts path
        binding.pry
        
        # grab the full pic - TODO - is this necessary?
        image_link = "http://pic.twitter.com/#{path}"

        # grab the page
        doc = Nokogiri::HTML(open(image_link, {"User-Agent" => EAR::USER_AGENT_STRING})) do |config|
           config.noblanks
        end

        # open up each image's page & create a new twitpic. don't download by default
        #p = TwitterMedia.new(doc.xpath("//*[@id=\"media\"]/img/@src").to_s)

        pics << p if p

      end
    pics
    end

  end

  # This class represents a corporation as returned by the Corpwatch service. 
  class TwitterMedia
    attr_accessor :remote_path
    attr_accessor :local_path

    def initialize(link, do_download=true)
          # grab the image & store locally
          @remote_path = link
          @local_path = "/tmp/twitter_media_file_#{rand(1000000)}"
          download_remote_file if do_download
    end

    def download_remote_file
      begin
        open(@local_path, "wb") do |file|
          file.write open(@remote_path).read
        end
      rescue Exception => e
        puts "#{e}"
        return false
      end
      true
    end

    def to_S
      "Twitpic #{@local_path} #{@remote_path}"
    end

  end
end
end
end
