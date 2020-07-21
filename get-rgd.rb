require 'open-uri'
url = 'https://cirno.blog/archives/290'
puts "fetching #{url} ..."
html = URI.open(url) { |f| f.read }
zip = 'https:' + html.match(%r{Download Link:.+?href="(.+?)"})[1]
puts "downloading #{zip} ..."
file = File.basename(zip)
File.open(file, 'wb') { |g|
  URI.open(zip) { |f| IO.copy_stream f, g }
}
system "7z x #{file}"
File.delete file, 'Readme.txt'
