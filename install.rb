require 'fileutils'

RAILS_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '/../../../')) unless defined? RAILS_ROOT


puts 'Publishing web assets to public folder'

FileUtils.cp_r(
  File.expand_path(File.join(__FILE__, '..', 'public')),\
  File.expand_path(File.join(RAILS_ROOT, 'public', 'mediabrowser'))
)
