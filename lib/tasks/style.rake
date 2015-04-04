desc 'Run rubocop'
task style: :environment do
  sh 'bundle exec rubocop'
end
