require 'bundler'
Bundler.require

def git(*args)
  system('git', *args)
  raise "git failed with #{$?}" unless $?.success?
end

list_account          = ENV['GITHUB_ORGANIZATION'] || ENV['GITHUB_USERNAME']
list_account_type     = ENV['GITHUB_ORGANIZATION'].nil? ? 'User' : 'Organization'
list_repository_type  = ENV['GITHUB_REPOSITORY_TYPE'] || 'all'
backup_path           = ENV['GITHUB_BACKUP_PATH'] || 'repositories'

connection = OctocatHerder::Connection.new :user_name => ENV['GITHUB_USERNAME'], :password => ENV['GITHUB_PASSWORD']
repositories = OctocatHerder::Repository.list list_account, list_account_type, list_repository_type, connection

FileUtils.mkdir_p 'repositories'

repositories.each do |repo|
  url = repo.ssh_url
  name = url[%r[/([^/]+)$], 1]
  path = File.join backup_path, name
  if Dir.exists? path
    puts "Fetching #{name}"
    git "--git-dir=#{path}", 'fetch'
  else
    git 'clone', '--bare', url, path
  end
end
