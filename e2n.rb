#!/usr/bin/env ruby

require 'optparse'
require 'ruby-pinyin'


Version = 'Version:20141226, Copyright by Yulu Ma. All Rights Reserved.'

options = {}

lines = []
shoupinarray = []
counts = 0

keyCode = {
  "a" => "2",
  "b" => "2",
  "c" => "2",
  "d" => "3",
  "e" => "3",
  "f" => "3",
  "g" => "4",
  "h" => "4",
  "i" => "4",
  "j" => "5",
  "k" => "5",
  "l" => "5",
  "m" => "6",
  "n" => "6",
  "o" => "6",
  "p" => "7",
  "q" => "7",
  "r" => "7",
  "s" => "7",
  "t" => "8",
  "u" => "8",
  "v" => "8",
  "w" => "9",
  "x" => "9",
  "y" => "9",
  "z" => "9"
}


option_parser = OptionParser.new do |opts|

  opts.on('-i INPUTFILE', 'English charachtor string.') do |inputfile|
    options[:input] = inputfile
  end
  
  opts.on('-o OUTPUT', 'Result text file, with each row T9 digis.') do |outputfile|
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
    #PinYin.of_string(line).each do |word|
    line.downcase.chars.each do |achar|
      shoupin << keyCode[achar].to_s
    end
    shoupinarray << shoupin
    counts += 1
  end
  File.open(options[:output], 'w') { |file| file.write(shoupinarray.join("\n")) }
  puts "Success! totally #{counts} records converted.\n"
else
  puts "Usage: e2n -h for help.\n"
end
