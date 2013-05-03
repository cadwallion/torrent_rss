# TorrentRSS

TorrentRSS is a command-line utility for downloading torrent files from an RSS feed, looking 
for new entries by recording the ID of the RSS item in a log file (The entry ID is MD5'd in the event
  that the ID is a URL).

## Installation

Add this line to your application's Gemfile:

    gem 'torrent_rss'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install torrent_rss

## Usage

The primary command is `torrent_rss fetch`.  The command takes an array of RSS feeds and parses them for
new entries to download to a specific folder.  By default, it will look for a configuration file found at
`~/.torrent_rss`.  This configuration file is written using [TOML](https://github.com/mojombo/toml), and
includes the destination directory and the array of RSS feeds to query.

Example:

``` toml
directory = "/opt/torrents"
feeds = [
  "http://example.com/torrent.rss",
  "http://example2.com/doesnt/need/rss/extension"
]
```

TorrentRSS also supports command-line flags that override anything set in its configuration file. By 
default, that file is located at `~/.torrent_rss`, but can be overridden with the `--config` flag.

Options:
  -f, [--feeds=one two three]  # Array of Feed URLs to parse and download from
  -d, [--directory=DIRECTORY]  # Directory to download torrent files from
  -c, [--config=CONFIG]        # Specify the configuration file for TorrentRSS.
                               # Default: ~/.torrent_rss

Downloaded items have their IDs MD5'd and logged in `~/.torrent_rss_log` to prevent redownloading.

Questions? Issues? Want to contribute? Pull requests and issues welcome.
