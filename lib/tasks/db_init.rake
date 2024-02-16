namespace :db do
  desc 'Initialize database. Create, migrate and populate database if it doesnt exist.'
  task :init do
    begin
      ActiveRecord::Base.connection
    rescue
      `bin/rails db:create db:migrate db:seed`
    end
  end
end
