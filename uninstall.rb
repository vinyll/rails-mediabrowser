require 'fileutils'

RAILS_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '/../../../')) unless defined? RAILS_ROOT


puts 'Removing mediabrowser web assets from public folder'


FileUtils.rm_r(File.expand_path(File.join(RAILS_ROOT, 'public', 'mediabrowser')))

puts 'the uploads folder was not removed. Delete it manually if you do not need it nomore.'
