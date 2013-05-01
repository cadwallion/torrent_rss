require 'digest'

module TorrentRSS
  class EntryLog
    class << self
      def has? entry_id
        entries.include? encode_entry(entry_id)
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

      def encode_entry entry_id
        Digest::MD5.hexdigest entry_id
      end

      def add entry_id
        entries << encode_entry(entry_id)
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
