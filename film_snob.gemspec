# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "film_snob/version"

Gem::Specification.new do |spec|
  spec.name = "film_snob"
  spec.version = FilmSnob::VERSION
  spec.authors = ["Max Jacobson"]
  spec.email = ["max@hardscrabble.net"]
  spec.summary = "Fetch data from oEmbed APIs"
  spec.description = "Lookup things like titles and HTML embed codes for web " \
                     "media like videos, pictures, and songs."
  spec.homepage = "https://github.com/maxjacobson/film_snob"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.required_ruby_version = ">= 2.0.0"
end
