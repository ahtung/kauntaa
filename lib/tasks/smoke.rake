namespace :smoke do
  desc 'Smoke test test'
  task test: :environment do
    system('RACK_ENV=test bundle exec cucumber') or exit
  end

  desc 'Smoke test staging'
  task staging: :environment do
    system('RACK_ENV=staging bundle exec cucumber') or exit
  end

  desc 'Smoke test production'
  task production: :environment do
    system('RACK_ENV=production bundle exec cucumber') or exit
  end
end
