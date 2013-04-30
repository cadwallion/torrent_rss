# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'torrent_rss/version'

Gem::Specification.new do |spec|
  spec.name          = "torrent_rss"
  spec.version       = TorrentRss::VERSION
  spec.authors       = ["Andrew Nordman"]
  spec.email         = ["cadwallion@gmail.com"]
  spec.description   = %q{Manage parsing RSS files for torrents and downloading them}
  spec.summary       = %q{Torrent RSS manager.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'toml'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
