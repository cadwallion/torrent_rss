module TorrentRSS
  class Feed
    attr_reader :url
    def initialize url
      @url = url
    end

    def fetch! options = {}
      @directory = options[:directory]
      parsed_feed.entries.each do |entry|
        puts "Parsing #{entry.entry_id}" if options[:verbose]
        if new_entry? entry
          puts "Entry #{entry.entry_id} is new! Downloading..." if options[:verbose]
          torrent = Torrent.from_entry entry
          if torrent.download @directory
            puts "Entry #{entry.entry_id} downloaded to #{@directory}!" if options[:verbose]
            EntryLog.add entry.entry_id
          else
            puts "Entry #{entry.entry_id} could not be downloaded" if options[:verbose]
          end
        end
      end
    end

    def new_entry? entry
      !EntryLog.has? entry.entry_id
    end

    def parsed_feed
      @feed ||= Feedzirra::Feed.fetch_and_parse @url
    end

    def verbose message
      puts message if options[:verbose] 
    end
  end
end
