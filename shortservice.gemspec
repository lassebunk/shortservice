Gem::Specification.new do |s|
  s.name = "shortservice"
  s.version = "0.0.4"

  s.author = "Lasse Bunk"
  s.email = "lassebunk@gmail.com"
  s.description = "The ShortService gem is a layer for talking to the ShortService API."
  s.summary = "Layer for talking to the ShortService API."
  s.homepage = "http://github.com/lassebunk/shortservice"
  s.files = ["lib/shortservice.rb"]
  s.require_paths = ["lib"]

  s.add_dependency("simplehttp", ">= 0.1.3")
end