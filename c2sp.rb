#!/usr/bin/env ruby

require 'optparse'
require 'ruby-pinyin'

Version = 'Version:20141226, Copyright by Yulu Ma. All Rights Reserved.'

options = {}

lines = []
shoupinarray = []
counts = 0

option_parser = OptionParser.new do |opts|

  opts.on('-i INPUTFILE', 'UTF-8 encodeing text file, with each row is a chinese string.') do |inputfile|
    options[:input] = inputfile
  end
  
  opts.on('-o OUTPUT', 'Result text file, with each row composed from each first char of pinyin word strings.') do |outputfile|
    options[:output] = outputfile
  end
  
  opts.on('-v','Show current verion.') do
    puts Version.to_s
  end
end

option_parser.parse!

def read_file(io, lines)
  io.readlines.each do |line|
     lines << line.chomp
   end
end

if options[:input] && options[:output]
  read_file(File.open(options[:input]), lines)
  puts "Converting... wait a minute...\n"
  lines.each do |line|
    shoupin = String.new()
    PinYin.of_string(line).each do |word|
      shoupin << word[0].to_s
    end
    shoupinarray << shoupin
    counts += 1
  end
  File.open(options[:output], 'w') { |file| file.write(shoupinarray.join("\n")) }
  puts "Success! totally #{counts} records converted.\n"
else
  puts "Usage: c2sp -h for help.\n"
end
