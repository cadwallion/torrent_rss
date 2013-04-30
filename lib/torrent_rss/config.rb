require 'toml'

module TorrentRSS
  class Config
    class << self
      def directory
        config_data['directory']
      end

      def feeds
        config_data['feeds']
      end

      def config_data
        @config_data ||= TOML.load_file File.expand_path "~/.torrent_rss"
      end
    end
  end
end
