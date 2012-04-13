Gem::Specification.new do |s|
  s.name    = 'etagger'
  s.version = '1.0.0'
  s.author  = '37signals'
  s.email   = 'jeremy@37signals.com'
  s.summary = 'Declare what goes in to your ETags: asset versions, account ID, etc.'

  s.required_ruby_version = '>= 1.9'

  s.add_dependency 'actionpack', '>= 3.2'
  s.add_dependency 'activesupport', '>= 3.2'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'

  s.files = Dir["#{File.dirname(__FILE__)}/**/*"]
end
