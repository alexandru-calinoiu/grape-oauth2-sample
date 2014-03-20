$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app', 'api'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'

Bundler.require :default, ENV['RACK_ENV']

include_dirs = %w(models)

include_dirs.each do |dir|
  Dir[File.expand_path(File.join('../../app', dir, '*.rb'), __FILE__)].each do |f|
    require f
  end
end

require File.expand_path('../../app/sample_app.rb', __FILE__)
