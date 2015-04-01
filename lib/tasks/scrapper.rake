namespace :scrapper do
  desc "Fetch craigslist data from 3taps"
  task scrape: :environment do

  	require 'open-uri'
	require 'json'

	# Set API token and URL
	auth_token = "ca9d1ebd6d17828c658f0ef293e6a474"
	polling_url = "http://polling.3taps.com/poll"


	# Specify request parameters
	params = {
	  auth_token: auth_token,
	  anchor:1974910963,
	  source: "CRAIG",
	  category_group: "VVVV",
	  category: "VAUT",
	  'location.state' => "USA-CA",
	  retvals: "id,account_id,source,category,category_group,location,external_id,external_url,heading,body,timestamp,timestamp_deleted,expires,language,price,currency,images,annotations,status,state,immortal,deleted,flagged_status"
	}

	# Prepare API request
	uri = URI.parse(polling_url)
	uri.query = URI.encode_www_form(params)

	# Submit request
	result = JSON.parse(open(uri).read)

	# Display results to screen
	# this displays ll data in terminal
	# puts results
	# puts JSON.pretty_generate result
	# puts JSON.pretty_generate result["postings"]
	# puts JSON.pretty_generate result["postings"].first
	# puts JSON.pretty_generate result["postings"].first["heading"] --> this will give error cos output need to be displayed in string

	# puts result["postings"].first["heading"] # dis output as string
	# puts result["postings"].first["body"] # dis
	# puts result["postings"].second["location"]["locality"] # dis
	
	# Saving outpout to file
	# output = File.open( "outputfile.json","w" )
	# output << result
	# output.close

	  result["postings"].each do |posting|

	  # Create new Post
	  	@post = Post.new
		#@post.id = posting["id"]
		#@post.account_id = posting["account_id"]

		# @post = Post.new
      @post.heading = posting["heading"]
      @post.body = posting["body"]
      @post.price = posting["price"]
      @post.neighborhood = posting["location"]["locality"]
      @post.external_url = posting["external_url"]
      @post.timestamp = posting["timestamp"]

		# @post.source = posting["source"]
		# @post.category = posting["category"]
		# @post.category_group = posting["category_group"]
		# @post.location_state = posting["location"]["state"]
		# @post.location_city = posting["location"]["city"]
		# @post.external_id = posting["external_id"]
		# @post.external_url = posting["external_url"]
		# @post.heading = posting["heading"]
		# @post.body = posting["body"]
		# @post.timestamp = posting["timestamp"]
		# @post.timestamp_deleted = posting["timestamp_deleted"]
		# @post.expires = posting["expires"]
		# @post.language = posting["language"]
		# @post.price = posting["price"]
		# @post.currency = posting["currency"]
		# @post.status = posting["status"]
		# @post.state = posting["state"]
		# @post.immortal = posting["immortal"]
		# @post.deleted = posting["deleted"]
		# @post.flagged_status= posting["flagged_status"]


	  # Save Post
	  @post.save

	end

  end

  desc "TODO"
  task destroy_all_posts: :environment do
  end

end

#rails generate scaffold Advertise id account_id source category category_group location_state location_city external_id external_url heading body timestamp timestamp_deleted expires language price currency status state immortal deleted flagged_status

