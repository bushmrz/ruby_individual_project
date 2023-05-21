Gem::Specification.new do |spec|
  spec.name        = 'shnaider_carproj'
  spec.version     = '0.1.0'
  spec.authors     = ['Shnaider']
  spec.email       = 'shnaideriya@yandex.ru'
  spec.summary     = 'Shnaider carshering app'
  spec.description = 'Description Shnaider carshering app'
  spec.homepage    = 'https://github.com/bushmrz/ruby_individual_project'
  spec.license     = 'MIT'

  spec.files       = Dir.glob("**/*")
  spec.require_paths = ['lib']

  spec.add_dependency 'win32api'
end
