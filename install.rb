puts 'Publishing web assets to public folder'

FileUtils.ln_s(
  File.expand(File.join(__FILE__,'..', 'public')),\
  File.expand(File.join(RAILS_ROOT, 'public', 'mediabrowser'))
)
