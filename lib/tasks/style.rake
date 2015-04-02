desc 'Run rubocop'
task style: :environment do
  sh 'rubocop'
end
