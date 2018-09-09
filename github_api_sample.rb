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
access_token = 'settings-devsettings-personalaccesstokens'
me = 'judyj'

# create output files - one for stats and one for specific referrers
statsfile = File.open("#{username}-#{reponame}_stats.csv", 'w')
statsfile.puts 'user, repo, views, stars, watchers'

# i left my try/catch in here in case we have access issues
begin
  # first, a little about me
  # how many followers do i have?
  command = "https://api.github.com/users/#{username}/followers"
  follow_result = JSON.parse(RestClient.get(command))
  num_followers = follow_result.length
  follower_count = 0
  if num_followers > 0
    follow_result.each do |followers|
      follower_count += 1
      follower = followers['login']
      puts "follower #{follower_count} -#{follower}"
    end
  end

# let's find out more specifics about the repo
  # watchers
  command = "https://api.github.com/repos/#{username}/#{reponame}/watchers"
  watch_result = JSON.parse(RestClient.get(command))
  num_watchers = watch_result.length
  watcher_count = 0
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
  if num_issues > 0
    issues_result.each do |issues|
      issue_count += 1
      issue = issues['title']
      puts "issue #{issue_count}-#{issue}"
    end
  end

# hop out here if we had a problem
rescue Exception => e
  puts "[error] API error in repo #{reponame}: #{e}"
end

# well, what do you think?
