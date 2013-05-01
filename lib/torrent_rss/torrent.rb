require 'faraday'
module TorrentRSS
  class Torrent
    attr_accessor :id, :url, :title, :summary
    def self.from_entry entry
      torrent = new      

      [:id, :url, :title, :summary].each do |attr|
        torrent.send "#{attr}=", entry.send("#{attr}")
      end

      torrent
    end

    def initialize
      @connection = Faraday.new do |builder|
        builder.adapter Faraday.default_adapter
      end
    end

    def download directory
      response = @connection.get @url
      if response.success?
        filename = response.headers['content-disposition'].match(/filename=\"(.+)\"/)[1]
        File.write "#{directory}/#{filename}", response.body
      end
      response.success?
    end
  end
end
