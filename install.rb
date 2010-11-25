require 'fileutils'

RAILS_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '/../../../')) unless defined? RAILS_ROOT

public_dir = File.expand_path(File.join(RAILS_ROOT, 'public'))

puts 'Publishing web assets to public folder'
FileUtils.cp_r(
  File.join(File.dirname(__FILE__), 'public'),\
  File.join(public_dir, 'mediabrowser')
)

upload_dir = File.join(public_dir, 'uploads')
unless File.exists?(upload_dir)
  puts 'Creating uploads directory at "%s"' % upload_dir
  FileUtils.mkdir(upload_dir)
end

puts 'chmod 777 on uploads directory "%s"' % upload_dir
FileUtils.chmod_R(0777, upload_dir)
