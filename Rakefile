require "spec/rake/spectask"

Spec::Rake::SpecTask.new do |t|
    t.libs << 'lib'
    t.spec_files = FileList['spec/*_spec.rb']
    t.rcov = true
    t.rcov_opts = %w{--exclude spec,rcov}
    t.fail_on_error = false
end

task :default => [:spec]
