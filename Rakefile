require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'github_changelog_generator/task'

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ['--force-exclusion']
end

task default: [:spec, :rubocop]

desc 'Open a RuboCop REPL'
task :repl do
  require 'pry'
  ARGV.clear
  RuboCop.pry
end

namespace :changelog do
  def configure_changelog(c, release: nil)
    c.user = 'mojotech'
    c.project = 'rubocop-privacy'
    c.exclude_labels = %w(discussion duplicate invalid question wontfix)
    c.future_release = "v#{release}" if release
  end

  GitHubChangelogGenerator::RakeTask.new(:unreleased) do |c|
    configure_changelog(c)
  end

  GitHubChangelogGenerator::RakeTask.new(:latest_release) do |c|
    require 'rubocop/privacy/version'
    configure_changelog(c, release: RuboCop::Privacy::Version::STRING)
  end
end

task changelog: 'changelog:unreleased'

Rake::Task['build'].enhance [:spec, 'changelog:latest_release']
