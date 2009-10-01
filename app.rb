#!/usr/bin/ruby

require 'date'
require 'net/http'
require 'uri'

url = URI.parse("http://live.scpr.org/")
request = Net::HTTP::Get.new(url.path)
request.add_field("User-Agent", "Mozilla/4.0 (Shoutcast Tracker/1.0)") 
#need recognizable UA string since stream is on port 80

response = Net::HTTP.new(url.host, url.port).start do |http|
  http.request(request)
end

txt = response.body

re='with <B>?([0-9]*) of'

m=Regexp.new(re,Regexp::IGNORECASE);
if m.match(txt)
    file = File.new("stats.csv", "a")
    file.puts("#{m.match(txt)[1]}, #{DateTime.now.strftime("%m/%d/%Y %H:%M:%S")}")
    file.close
end
