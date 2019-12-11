# frozen_string_literal: true

require 'csv'

desc 'Import merchants (path=path/to/file)'
task import_merchants: :environment do
  puts ENV['path']
  merchants = CSV.parse(File.read(ENV['path']), headers: true, col_sep: ';')

  merchants.each do |merchant|
    begin
      # merchant.to_hash can fail if inconsistent csv file
      m = Merchant.new(merchant.to_hash)

      if m.save!
        puts "Merchant #{m.inspect} saved!!!"
      else
        puts "Merchant not saved: #{m.inspect}"
        puts m.errors.full_messages
      end
    rescue => e
      puts e.message
    end
  end

rescue => e
  puts e.message
end
