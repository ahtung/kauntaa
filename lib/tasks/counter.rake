namespace :counter do
  desc 'Colorizes all counters'
  task colorize: :environment do
    Counter.all.map do |c|
      c.palette = Palette.where.not(id: c.palette.id).sample
      c.save
    end
  end
end
