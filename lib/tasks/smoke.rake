namespace :smoke do
  desc 'Smoke test test'
  task test: :environment do
    `RACK_ENV=test bundle exec cucumber --format json --out $CIRCLE_TEST_REPORTS/cucumber/tests.cucumber`
  end

  desc 'Smoke test staging'
  task staging: :environment do
    `RACK_ENV=staging bundle exec cucumber --format json --out $CIRCLE_TEST_REPORTS/cucumber/tests.cucumber`
  end

  desc 'Smoke test production'
  task production: :environment do
    `RACK_ENV=production bundle exec cucumber --format json --out $CIRCLE_TEST_REPORTS/cucumber/tests.cucumber`
  end
end
