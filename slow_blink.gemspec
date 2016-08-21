require File.expand_path("../lib/slow_blink/version", __FILE__)

Gem::Specification.new do |s|
    s.name    = "slow_blink"
    s.version = SlowBlink::VERSION
    s.date = Date.today.to_s
    s.summary = "Blink Protocol in Ruby (placeholder)"
    s.author  = "Cameron Harper"
    s.email = "contact@cjh.id.au"
    s.homepage = "https://github.com/cjhdev/slow_blink"
    s.files = Dir.glob("ext/slow_blink/ext_schema_parser/**/*.{c,h,y,l,rb}") + Dir.glob("lib/**/*.rb") + Dir.glob("test/**/*.rb") + ["rakefile"]
    s.extensions = "ext/slow_blink/ext_schema_parser/extconf.rb"
    s.license = 'MIT'
    s.test_files = Dir.glob("test/**/*.rb")
    s.has_rdoc = 'yard'
    s.add_development_dependency 'rake-compiler'
    s.add_development_dependency 'rake'
    s.add_development_dependency 'test-unit'
    s.required_ruby_version = '>= 2.0'
end
