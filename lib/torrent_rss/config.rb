require 'toml'

module TorrentRSS
  class Config
    class << self
      attr_accessor :config_file
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
        if File.exists? config_file
          TOML.load_file  config_file
        else
          {}
        end
      end
    end
  end
end
