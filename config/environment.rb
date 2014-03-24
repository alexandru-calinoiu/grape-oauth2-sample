ENV['RACK_ENV'] ||= 'development'

require File.expand_path('../application', __FILE__)

I18n.enforce_available_locales = false
