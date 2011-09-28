namespace :survey do
  desc 'Setup survey app in development'
  task :setup => ['db:drop', 'db:create', 'db:migrate', 'db:populate', 'environment'] 
  
end