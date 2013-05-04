require 'thor'

module TorrentRSS
  class CLI < Thor
    include Thor::Actions

    desc 'fetch', 'parses RSS feeds and downloads any new torrent files'
    method_option :feeds, aliases: '-f', type: :array, desc: 'Array of Feed URLs to parse and download from'
    method_option :directory, aliases: '-d', desc: 'Directory to download torrent files from'
    method_option :config, aliases: '-c', desc: 'Specify the configuration file.', default: '~/.torrent_rss'
    def fetch
      Config.config_file = options[:config]
      feed_urls = options[:feeds] || Config.feeds || []
      directory = options[:directory] || Config.directory || '.'

      feed_urls.each do |url|
        feed = Feed.new url
        feed.fetch! directory: directory
      end
    end

    desc 'monitor', 'continually monitors RSS feeds for changes to downloads'
    method_option :daemonize, aliases: '-d', type: :boolean, default: false, banner: 'Daemonize the monitoring process'
    def monitor
      Signal.trap('INT') { puts 'shutting down' ; exit }

      if options[:daemonize]
        pid = fork do
          looped_fetch 
        end

        Process.detach pid
      else
        looped_fetch
      end
    end

    private
    def looped_fetch
      loop do
        invoke :fetch
        sleep 60
      end
    end
  end
end
