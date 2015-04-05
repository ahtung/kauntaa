desc 'security test'
task security: :environment do
  sh 'brakeman -z'
end
