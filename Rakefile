require "spec/rake/spectask"
require "rake/gempackagetask"

spec = Gem::Specification.new do |s|
  s.name = %q{demeter}
  s.version = "1.0.2"
  s.authors = ['Emerson Macedo']
  s.email = ['emerleite@gmail.com']
  s.date = %q{2009-11-11}
  s.homepage = 'http://github.com/emerleite/demeter'
 
  s.summary = %q{An easy way to apply law of demeter to your objects}
  s.description = %q{An easy way to apply law of demeter to your objects}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
 
  s.files = ['Rakefile',
             'README',
             'LICENSE.txt',
             'lib/demeter.rb',
            ]
end

Rake::GemPackageTask.new(spec) do |pkg|
    pkg.need_zip = true
    pkg.need_tar = true
end

Spec::Rake::SpecTask.new do |t|
    t.libs << 'lib'
    t.spec_files = FileList['spec/*_spec.rb']
    t.rcov = true
    t.rcov_opts = %w{--exclude spec,rcov}
    t.fail_on_error = false
end

task :default => [:spec]
