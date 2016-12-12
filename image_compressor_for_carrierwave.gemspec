Gem::Specification.new do |s|
  s.name        = 'image_compressor_for_carrierwave'
  s.version     = '1.0.8'
  s.date        = '2016-12-12'
  s.summary     = "Image compressor to use with carrierwave uploaders"
  s.description = "A simple image compression gem"
  s.authors     = ["Alejandro Fernandes Antunes"]
  s.email       = 'afernandesantunes@gmail.com'
  s.files       = ["lib/image_compressor_for_carrierwave.rb", "lib/image_compressor_for_carrierwave/carrierwave_extension.rb"]
  s.homepage    =
    'http://rubygems.org/gems/image_compressor_for_carrierwave'
  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
  s.add_dependency "png_quantizator"
  s.add_development_dependency "carrierwave"
  s.add_development_dependency "mini_magick"
  s.add_development_dependency "rmagick"
  s.add_development_dependency "rake"
end
