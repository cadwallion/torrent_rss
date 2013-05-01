module TorrentRSS
  class EntryLog
    class << self
      def has? entry_id
        entries.include? entry_id
      end

      def entries
        @entries ||= read
      end

      def read
        if File.exists? file_path
          File.read(file_path).split("\n")
        else
          []
        end
      end

      def add entry_id
        entries << entry_id
        save
      end

      def save
        File.write file_path, entries.join("\n")
      end

      def file_path
        File.expand_path("~/.torrent_rss_log")
      end
    end
  end
end
