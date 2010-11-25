class MediabrowserController < ApplicationController
  layout 'admin'
  
  before_filter :define_path
  
  
  def define_path
    @public_path = File.join(RAILS_ROOT, 'public')
    @uploads_url = '/uploads'
    @upload_path = File.join(@public_path, @uploads_url)
    @current_url = params[:dir] || @uploads_url
    @current_path = File.join(@public_path, @current_url)+ '/*'
  end
  
  
  def list
    
    @dirs = []
    @files = []
    Dir.glob(@current_path).sort.each do |file|
      file_obj = {
          :url => file.gsub(@public_path, ''),
          :name => File.basename(file),
        }
      if File.directory?(file)
        @dirs << file_obj
      else
        file_obj.merge!({
          :type => ['gif','jpg','jpeg','png'].index(File.extname(file)[1..-1]) ? :image : :file,
          :icon => '/mediabrowser/images/file.png',
        })
        puts file_obj[:type]
        if file_obj[:type] == :image
          file_obj[:icon] = file_obj[:url]
        end
        @files << file_obj
      end
    end
    
    @breadcrumb = []
    curr_crumb = ''
    @current_url.each(File::SEPARATOR) do |crumb|
      crumb.gsub!('/', '')
      if crumb != ''
        curr_crumb += File::SEPARATOR + crumb
        puts curr_crumb
        @breadcrumb << {
          :name => crumb,
          :url => curr_crumb,
        }
      end
    end
  end
  
  
  def create_dir
    slugged_name = slugify(params[:new_dir][:name])
    path = File.join(@public_path, params[:new_dir][:path])
    create_path = File.join(path, slugged_name)
    
    if secured_path?(path) && !File.exist?(create_path) && FileUtils.mkdir(create_path)
      notice = 'Directory "%s" was successfully created' % slugged_name
    else
      notice = 'Directory "%s" could not be created' % slugged_name
    end
    redirect_to request.referer, :notice => notice
  end
  
  
  def create_file
    data = params[:new_file][:file]
    filename = data.original_filename
    target_name = slugify(filename)

    if filename_ext = File.extname(filename)
      target_name = slugify(filename[0..-(filename_ext.length+1)]) + filename_ext
    end
    target = File.join(@public_path, params[:new_file][:path], target_name)
    File.open(target, 'w+') do |file|
      file.write(data.read)
    end
    notice = File.exist?(target) \
          ? 'File "%s" was successfully added' % File.basename(target_name)\
          : 'File "%s" could not be uploaded' % File.basename(target_name)
    redirect_to request.referer, :notice => notice
  end
  
  
  def delete
    file_path = File.join(@public_path, params[:file])
    if secured_path?(file_path) && FileUtils.rm_r(file_path)
      notice = '"%s" was successfully deleted' % File.basename(params[:file])
    else
      notice = '"%s" could not be deleted' % File.basename(params[:file])
    end
    redirect_to request.referer, :notice => notice
  end
  

protected
  
  def secured_path?(file_path)
    return File.exist?(file_path) && ! File.dirname(file_path).index(@public_path).nil?
  end
  
  
  
  def slugify(value)
    return value.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s\
          .downcase\
          .gsub(/[']+/, '')\
          .gsub(/\W+/, ' ')\
          .strip\
          .gsub(' ', '-')
  end
  
end
