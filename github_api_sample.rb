# make sure to:
# gem install rest-client
# gem install json
require 'rest-client'
require 'json'

# fetch user information
username = 'judyj'
reponame = 'Magic-of-APIs'

# for private info (such as referrers, etc) you can add your personal token.
# a call will look like this:
#  repo_result = JSON.parse(RestClient.get("#{command}",
#                           {:params => {:oauth_token => access_token}}))
#
#   Authenticated requests get a higher rate limit.
#   Check out the documentation for more details.)
#   "documentation_url": "https://developer.github.com/v3/#rate-limiting"
# access_token = 'settings-devsettings-personalaccesstokens'
# me = 'judyj'

# create output files - one for stats and one for specific referrers
issuesfile = File.open("#{username}-#{reponame}_issues.csv", 'w')
issuesfile.puts 'user, repo, number, issue'

# i left my try/catch in here in case we have access issues
begin

 # let's find out more specifics about the repo
  command = "https://api.github.com/repos/#{username}/#{reponame}"
  call_result = JSON.parse(RestClient.get(command))
  repo_name = call_result['name']
  full_name = call_result['full_name']
  puts "\nRepo name: #{repo_name}, Full name: #{full_name}"

  # first, a little about me
  # how many followers do i have?
  command = "https://api.github.com/users/#{username}/followers"
  follow_result = JSON.parse(RestClient.get(command))
  num_followers = follow_result.length
  follower_count = 0
  puts "\nHere are #{username}'s followers:"
  if num_followers > 0
    follow_result.each do |followers|
      follower_count += 1
      follower = followers['login']
      puts "follower #{follower_count} -#{follower}"
    end
  end

  # watchers
  command = "https://api.github.com/repos/#{username}/#{reponame}/watchers"
  watch_result = JSON.parse(RestClient.get(command))
  num_watchers = watch_result.length
  watcher_count = 0
  puts "\nHere are the watchers for #{username}'s repo, #{reponame}:"
  if num_watchers > 0
    watch_result.each do |watchers|
      watcher_count += 1
      watcher = watchers['login']
      puts "watcher #{watcher_count} -#{watcher}"
    end
  end

  # issues
  command = "https://api.github.com/repos/#{username}/#{reponame}/issues"
  issues_result = JSON.parse(RestClient.get(command))
  num_issues = issues_result.length
  issue_count = 0
  puts "\nDang - shes got issues:"
  if num_issues > 0
    issues_result.each do |issues|
      issue_count += 1
      issue = issues['title']
      puts "issue #{issue_count}-#{issue}"
      issuesfile.puts "#{username}, #{reponame}, #{issue_count}, #{issue}"
    end
  end

# hop out here if we had a problem
rescue Exception => e
  puts "[error] API error in repo #{reponame}: #{e}"
end

# well, what do you think? That was not that hard!
# Don't forget to check out the issues csv file you created, 
