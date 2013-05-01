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
        @config_data ||= read_config
      end

      def read_config
        if File.exists? config_path
          TOML.load_file  config_path
        else
          {}
        end
      end

      def config_path
        File.expand_path "~/.torrent_rss"
      end
    end
  end
end
