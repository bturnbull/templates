## Haml, jQuery, RSpec

## clean up
run 'rm README'
run 'rm public/index.html'
run 'rm public/favicon.ico'
run 'rm -f public/images/*'

## robots.txt
run 'rm public/robots.txt'
file 'public/robots.txt', <<-END
User-agent: *
Disallow:
END

## gems
gem 'haml'
gem 'sqlite3-ruby',  :lib => 'sqlite3'
gem 'rspec',         :lib => false
gem 'rspec-rails',   :lib => false
gem 'factory_girl'
rake 'gems:install'
run "haml --rails #{@root}"

## rspec
generate 'rspec'

## jquery 
run 'rm -f public/javascripts/*'
run "curl --location --output public/javascripts/jquery.js http://code.jquery.com/jquery-1.4.min.js"

## stylesheets
run "curl --location --output public/stylesheets/reset.css http://meyerweb.com/eric/tools/css/reset/reset.css"
run 'touch public/stylesheets/site.css'
run 'touch public/stylesheets/site-print.css'

## application.haml
file 'app/views/layouts/application.haml', <<-END
!!!
%html
  %head
    %meta{'http-equiv' => 'Content-Type, :content => 'text/html;charset=UTF-8'}/
    %title= @title
    = stylesheet_link_tag 'reset', :media => 'all'
    = stylesheet_link_tag 'site'
    = stylesheet_link_tag 'site-print', :media => 'print'
    = javascript_include_tag 'jquery.js'
  %body
    #content= yield
END

## database
rake 'db:migrate'

## git
file '.gitignore', <<-END
.DS_Store
*.swp
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
END
git 'init'
