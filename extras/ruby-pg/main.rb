require 'pg'

conn = PG.connect(dbname: 'phone_book')
conn.exec("select name, phone from contacts") do |result|
  result.each do |row|
    puts "#{row["name"]} -> #{row["phone"]}"
  end
end
