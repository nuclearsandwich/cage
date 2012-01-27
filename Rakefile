require "rake/testtask"
require "bundler/gem_tasks"
require "mustache"
require "cage/version"

task :default => :test

task :build => :gemspec

desc "Compile gemspec from the mustache template."
task :gemspec do
  File.open "cage.gemspec", "w" do |gs|
    gs.puts Mustache.render File.read("cage.gemspec.mustache"),
      :version => %Q<"#{Cage::VERSION}">,
      :files => "%w[#{Dir["lib/**/*.rb"].join " "}]",
      :test_files => "%w[#{Dir["test/**/*"].join " "}]",
      :bin_files => "%w[cage]"
  end
end

Rake::TestTask.new do |t|
  t.test_files = FileList["test/**/*.rb"]
end
