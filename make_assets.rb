require 'bundler/setup'
require 'digest/md5'
require 'sprockets'
require 'yui/compressor'
require 'yaml'

Bundler.require(:default)

require './webapp'

set :run, false

current_directory = File.expand_path File.dirname(__FILE__)
build_directory = current_directory + "/build/assets/"
build_root = current_directory + "/build/"

config = YAML.load_file("#{current_directory}/config.yml")
application_files = config['content'] + IuguUX.src
application_urls = config['network']

puts "Preparing Environment for Asset Building..."

if config['remove_old_files'] and !build_root.empty?
  puts "... removing old files from build directory"
  remove_older_cmd = "rm -rf #{build_root}*"
  system(remove_older_cmd)
end

def save_asset( build_directory, filename, extension, contents )
  if extension == "js"
    compressor = YUI::JavaScriptCompressor.new
    contents = compressor.compress( contents )
  elsif extension == "css"
    compressor = YUI::CssCompressor.new
    contents = compressor.compress( contents )
  end
  # calc_md5 = Digest::MD5.hexdigest( contents )
  File.open( build_directory + filename, "w" ) do |f|
    f.write( contents )
  end
  filename
end

system("mkdir -p #{build_directory}")

pkg_files = {}

application_files.each do |pkg_file|
  if pkg_file.index '.' and not pkg_file.index '.html'
    pkg_file,ext = pkg_file.split('.')
    puts '... packaging: ' + pkg_file + '.' + ext
    pkg_files[ pkg_file + "." + ext ] = save_asset( build_directory, $environment[pkg_file + '.' + ext].digest_path, ext, $environment[pkg_file + '.' + ext].to_s )
  else
    puts '... packaging directory: ' + pkg_file
    copy_static_cmd = ''
    if pkg_file.index '.'
      copy_static_cmd = "cp -rf #{current_directory}/src/#{pkg_file} #{build_directory}/"
    else
      copy_static_cmd = "cp -rf #{current_directory}/src/#{pkg_file}/* #{build_directory}/"
    end
    system(copy_static_cmd)
  end
end

request = Rack::MockRequest.new(WebApp)
application_urls.each do |pkg_network|
    puts '... packaging: ' + pkg_network
    filename = pkg_network
    filename = 'index.html' if pkg_network == '/'
    save_asset( build_root, filename, nil, request.get( pkg_network ).body )
end

puts '... done'
