# Magic-of-APIs
Demo repo for my upcoming blog..

Blog link is here:  https://www.onyxpoint.com/blog/magic-of-apis/

This repo will show you how to use the api via command line and ruby code to get information on the repo itself.
Slightly recursive and maybe fun!

For example, here you will find JSON for all the attributes of this repo:
https://api.github.com/repos/judyj/Magic-of-APIs

You can also call it with a curl command:
`$ curl https://api.github.com/repos/judyj/Magic-of-APIs > my_stats_file`

...or use the sample ruby code in this repo to see how to get and translate json

In order to run the ruby code, you must install two gems:<br>
`$ gem install rest-client  # allows it to use the rest calls properly`<br>
`$ gem install json         # allows it to decode the json`


...Now, run the code<br>
`$ ruby github_api_sample.rb`

and see what happens!
