require 'rake'
require 'spec/rake/spectask'
require File.dirname(__FILE__) + '/lib/demeter/version'
require 'jeweler'

desc 'Default: run specs.'
task :default => :spec

desc 'Run the specs'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--colour --format specdoc --loadby mtime --reverse']
  t.spec_files = FileList['spec/**/*_spec.rb']

  t.rcov = true
  t.rcov_opts = %w{--exclude spec,rcov,activerecord,active_support,activesupport,builder,sqlite,json}
end

JEWEL = Jeweler::Tasks.new do |gem|
  gem.name = "demeter"
  gem.version = Demeter::Version::STRING
  gem.summary = "A simple way to apply the Law of Demeter to your Ruby objects."
  gem.description = "A simple way to apply the Law of Demeter to your Ruby objects."

  gem.authors = ["Emerson Macedo"]
  gem.email = "emerleite@gmail.com"
  gem.homepage = "http://github.com/emerleite/demeter"

  gem.has_rdoc = false
  gem.files = %w(Rakefile demeter.gemspec VERSION README.markdown) + Dir["{lib,spec}/**/*"]
end

desc "Generate gemspec and build gem"
task :build_gem do
  File.open("VERSION", "w+") {|f| f << Demeter::Version::STRING }

  Rake::Task["gemspec"].invoke
  Rake::Task["build"].invoke
end
