# AwlTagsTwitter

Grab tags from The Awl posts and tweet them out

## Installation

    $ gem install awl_tags_twitter

## Usage

```
$ awl_tags_twitter list [--basic | --complex]
$ awl_tags_twitter cache-all [--dry]
$ awl_tags_twitter tweet --config /path/to/config/file [--dry]
```

### Twitter credentials
1. Create a file to hold your credentials
2. Paste in the following (including your actual credentials

```
{
  "consumer_key":"<CONSUMER KEY>",
  "consumer_secret":"<CONSUMER_SECRET>",
  "access_token":"<ACCESS_TOKEN>",
  "access_token_secret":"<ACCESS_TOKEN_SECRET>"
}
```

### How to retweet a previous Article

1. You should locate the gem installation location
2. Navigate to the tmp directory, and open articles.json
3. Remove the article link which you would like to retweet

## Contributing

1. Fork it ( https://github.com/ellisandy/awl_tags_twitter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

