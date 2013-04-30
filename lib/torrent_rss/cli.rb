require 'thor'

module TorrentRSS
  class CLI < Thor
    include Thor::Actions

    desc 'fetch', 'parses RSS feeds and downloads any new torrent files'
    method_option :feeds, aliases: '-f', type: :array, desc: 'Array of Feed URLs to parse and download from'
    method_option :directory, aliases: '-d', desc: 'Directory to download torrent files from'
    def fetch
      feed_urls = options[:feeds] || Config.feeds || []
      directory = options[:directory] || Config.directory || '.'

      feed_urls.each do |url|
        feed = Feed.new url
        feed.fetch! directory: directory
      end
    end
  end
end
