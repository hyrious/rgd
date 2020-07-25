require 'zlib'
require 'fileutils'
include FileUtils

mkdir_p %w(Data System)

def file name, text
  unless File.exist? name
    IO.binwrite name, text
    puts "create #{name}"
  end
end

def copy_from_everything search, name
  unless File.exist? name
    src = `es -n 1 #{search}`.strip
    copy_file src, name, preserve: true
    puts "create #{name}"
  end
end

file 'Game.ini', <<~INI
  [Game]
  RTP=RPGVXAce
  Title=Project1
  Description=Lorem ipsum dolor sit amet.
  Library=System\\RGSS301.dll
  Scripts=Data\\Scripts.rvdata2
  ScreenWidth=240
  ScreenHeight=135
INI

scripts = [[rand(32767), 'Main', Zlib.deflate('load "main.rb"')]]
data = Marshal.dump scripts
file 'Data\Scripts.rvdata2', data

copy_from_everything 'RGSS301.dll', 'System\RGSS301.dll'
copy_from_everything '"RPGVXAce\" "Succubus.png"', 'Succubus.png'

file 'main.rb', <<~RUBY
  rgss_stop
RUBY
