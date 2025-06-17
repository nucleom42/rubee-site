require "bundler/setup"
Bundler.require(:test)

require 'minitest/autorun'
require 'rack/test'
require 'rubee'

Rubee::Autoload.call
