git :init

#Generic tidying up
run 'rm public/index.html'
run 'rm public/images/rails.png'
run 'rm README'

#Make sure we have the right gem sources, and install gems
run 'gem sources -a http://gems.github.com', :sudo => true
run 'gem sources -a http://code.whytheluckystiff.net', :sudo => true

gem 'RedCloth'
gem 'hpricot'
gem 'sanitize'
rake "gems:install", :sudo => true

#Plugins
plugin 'resource controller', :git => 'git://github.com/giraffesoft/resource_controller.git'

if yes? "Want newrelic plugin?"
  load_template '/Users/andrew/Ruby/Templates/newrelic.rb'
end

if yes? "Want authentication?"
  load_template '/Users/andrew/Ruby/Templates/authentication.rb'
end

if yes? "Want paperclip?"
  plugin 'paperclip', :git => 'git://github.com/thoughtbot/paperclip.git'
  run 'cp vendor/plugins/paperclip/README.rdoc paperclip_readme'
end

#Handle git ignores
file ".gitignore", <<-END
.DS_STORE
log/*.log
tmp/**/*
config/database.yml
END

#Kill our old, useless database file and make a new, spiffy one!
run 'rm config/database.yml'
file "config/database.template.yml", <<-END
development:
  adapter: mysql
  encoding: utf8
  database: 
  username: root
  password:
END
run 'cp config/database.template.yml config/database.yml'

# Make sure we keep empty folders around
run "touch tmp/.gitignore log/.gitignore"


#All done!  Let's commit
git :add => '.'
git :commit => "-a -m 'Initial commit.'" 
