require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'tty-prompt'

require 'pry'


prompt = TTY::Prompt.new
user_first_name = prompt.ask('What is your name?')


binding.pry

puts "HELLO WORLD"
