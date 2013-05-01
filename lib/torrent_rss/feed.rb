module TorrentRSS
  class Feed
    attr_reader :url
    def initialize url
      @url = url
    end

    def fetch! options = {}
      @directory = options[:directory]
      parsed_feed.entries.each do |entry|
        if new_entry? entry
          torrent = Torrent.from_entry entry
          torrent.download @directory
          EntryLog.add entry.entry_id
        end
      end
    end

    def new_entry? entry
      !EntryLog.has? entry.entry_id
    end

    def parsed_feed
      @feed ||= Feedzirra::Feed.fetch_and_parse @url
    end
  end
end
