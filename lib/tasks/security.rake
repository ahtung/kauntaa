desc 'security test'
task security: :environment do
  Rake::Task['brakeman:run'].invoke
end
