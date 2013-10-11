# encoding:utf-8

require 'rubygems' 
require 'active_record' 
require 'nokogiri'
require 'date'
require 'open-uri'
require 'pp'

class Catalog < ActiveRecord::Base ; end 
class Vegetable < ActiveRecord::Base ; end 
class VegetableLog < ActiveRecord::Base ; end

module Robot
 # change the password with your own password for root
  DB_CONNECTION_SETTING = {
    adapter: "mysql2",
	  encoding: "utf8",
	  database: "project_development",
	  pool: 5,
	  username: "root",
	  password: '***',
		socket: "/var/run/mysqld/mysqld.sock"
	}
  def self.initialize
    ActiveRecord::Base.establish_connection(DB_CONNECTION_SETTING)
  def self.go! 
    initialize()
    vegetable()
  end
  def self.vegetable
      last_item = VegetableLog.order('log_date DESC').first
      start_at = last_item ? last_item.log_date : Date.parse("2002-1-1")
      end_at = Date.today

      @@all_vegetable_set = {}
      Vegetable.select('id , serial').each do |v|
         @@all_vegetable_set[v.serial.strip] = v.id
      end


    while start_at < end_at do
        start_at = start_at.next_day
        vegetable_filter(start_at)
        sleep(0.1)  
    end
    #sleep 0.1 sec between 2 times reading the  target website 
  end
	def self.get_vegetable_id(serial , name , r_name)
	  serial = serial.strip
	  if @@all_vegetable_set[serial]
		  return @@all_vegetable_set[serial]
		else
		  v = Vegetable.new
			v.serial = serial
			v.name = name
			v.r_name = r_name
			v.save
			@@all_vegetable_set[serial] = v.id
			return v.id
	  end
	end
  def self.vegetable_filter(date)
    year = (date.strftime('%Y').to_i - 1911).to_s.rjust(3 , '0')
    puts "http://www.tapmc.com.tw/tapmc_new16/price1.asp?YEARS=#{year}&MONTHS=#{date.strftime('%m')}&DAYS=#{date.strftime('%d')}&FV_CODE=A&MARKET=1&temp=Z"
    body = open("http://www.tapmc.com.tw/tapmc_new16/price1.asp?YEARS=#{year}&MONTHS=#{date.strftime('%m')}&DAYS=#{date.strftime('%d')}&FV_CODE=A&MARKET=1&temp=Z")
    doc = Nokogiri::HTML(body)
    target = doc.css('form table')[1]
    if(target)
      tr = target.css('tr')[2..-1]
      ans = []
      tr.each do |i|
        temp = []
        i.css('td font').each do |j|
          temp << j.text
        end
        ans << temp
      end

      count = ans.length

      ans = ans.map{|temp| "(#{get_vegetable_id(temp[0] , temp[1] , temp[2])},#{temp[4].to_i},#{temp[5].to_i},#{temp[6].to_i},'#{date.strftime('%Y-%m-%d')}')"}.join(',') 

      ActiveRecord::Base.connection.execute("INSERT INTO vegetable_logs (vegetable_id,price1,price2,price3,log_date) VALUES #{ans}")
    
      puts "go!! => #{date.strftime('%Y-%m-%d')} : count => #{count}"
    else
      puts "skip => #{date.strftime('%Y-%m-%d')}"
    end
  end
end

Robot.go!
