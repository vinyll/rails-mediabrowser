require 'fileutils'

RAILS_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '/../../../')) unless defined? RAILS_ROOT


puts 'Removind mediabrowser web assets from public folder'


FileUtils.rm_r(File.expand_path(File.join(RAILS_ROOT, 'public', 'mediabrowser')))
