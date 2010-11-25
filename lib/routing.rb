module Mediabrowser
  module Routing
    module MapperExtensions
      def mediabrowser
        @set.add_route('/mediabrowser', {:controller => 'mediabrowser_controller', :action => 'list', :as => :mediabrowser})
        @set.add_route('/mediabrowser/delete', {:controller => 'mediabrowser_controller', :action => 'delete', :as => :delete_file_mediabrowser})
        @set.add_route('/mediabrowser/dir/create', { :controller => 'mediabrowser', :action => 'create_dir',  :as => :create_dir_mediabrowser})
        @set.add_route('/mediabrowser/file/create', { :controller => 'mediabrowser/file/create', :action => 'create_file',  :as => :create_file_mediabrowser})
      end
    end
  end
end


ActionController::Routing::RouteSet::Mapper.send(:include, Mediabrowser::Routing::MapperExtensions)