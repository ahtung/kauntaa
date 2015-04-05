namespace :counter do
  desc 'Colorizes all counters'
  task colorize: :environment do
    Counter.all.map do |c|
      c.palette = Palette.all.sample
      c.save
    end
  end
end
