module TorrentRSS
  class Feed
    attr_reader :url
    def initialize url
      @url = url
    end

    def fetch! options = {}
      @directory = options[:directory]
      parsed_feed.entries.each do |entry|
        puts entry.url 
      end
    end

    def parsed_feed
      @feed ||= Feedzirra::Feed.fetch_and_parse @url
    end
  end
end
