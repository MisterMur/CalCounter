require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'tty-prompt'

require 'pry'


f1 = Food.new(name: 'pizza')
f1_ndbno = f1.ndbno

f2 = Food.new(name: 'apple')

binding.pry

puts 'DONE'
