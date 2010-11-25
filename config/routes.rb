Rails::Application.routes.draw do
  match '/mediabrowser' => 'mediabrowser#list', :as => :mediabrowser
  match '/mediabrowser/delete' => 'mediabrowser#delete', :as => :delete_file_mediabrowser
  match '/mediabrowser/dir/create'  => 'mediabrowser#create_dir',  :as => :create_dir_mediabrowser
  match '/mediabrowser/file/create'  => 'mediabrowser#create_file',  :as => :create_file_mediabrowser
end
