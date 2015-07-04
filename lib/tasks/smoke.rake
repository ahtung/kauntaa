namespace :smoke do
  desc 'Smoke test staging'
  task staging: :environment do
    system("RACK_ENV=staging bundle exec rake cucumber --format json --out $CIRCLE_TEST_REPORTS/cucumber/tests.cucumber")
  end

  desc 'Smoke test production'
  task production: :environment do
    system("RACK_ENV=production bundle exec rake cucumber --format json --out $CIRCLE_TEST_REPORTS/cucumber/tests.cucumber")
  end
end
