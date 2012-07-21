if Rails::VERSION::MAJOR < 3
  ActionController::Routing::Routes.draw do |map|
    map.connect 'issues/known_tags/:project_id',
                :controller => 'auto_completes',
                :action => 'issue_tags'
  end
else
  match 'issues/known_tags/:project_id',
        :controller => 'auto_completes',
        :action => 'issue_tags'
end
