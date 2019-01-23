require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'tty-prompt'

require 'pry'



prompt = TTY::Prompt.new
user_name = prompt.ask('What is your name?')
if User.all.find {|users| users.name == user_name}
  puts "Welcome, back #{user_name}!"
else
  puts "Welcome"
  User.create(first_name: user_name)
end

#list out a menu 
#




binding.pry

puts "HELLO WORLD"
