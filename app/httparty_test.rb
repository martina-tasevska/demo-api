require 'rubygems'
require 'httparty'

response = HTTParty.get("https://www.youtube.com/watch?v=vDbBv3k6Fzs&t=94s")
puts response.headers
