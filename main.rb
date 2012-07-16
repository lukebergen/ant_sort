
require 'yaml'

$config = YAML::load(File.read("./config.yml"))

require './window.rb'
require './ant_world.rb'

ant_world = AntWorld.new
win = Window.new(ant_world)
win.show
