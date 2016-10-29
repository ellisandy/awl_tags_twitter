# AwlTagsTwitter

Grab tags from The Awl posts and tweet them out

## Installation

    $ gem install awl_tags_twitter

## Usage

```
$ awl_tags_twitter --config /path/to/config/file post
$ awl_tags_twitter --config /path/to/config/file list
$ awl_tags_twitter --config /path/to/config/file help
```

## Contributing

1. Fork it ( https://github.com/ellisandy/awl_tags_twitter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Archecture
1. Scraper returns a list of URLs
  * These URLs tie to a specific Article
  * When the article is initialized it should only have the URL
  * You can then call Builder which will poll the webservice and grab all the tags
2. Article
  * has a URL
  * has a list of tags
  * utilizes builder to actually poll teh article and return the tags
3. Builder
  * accepts a url
  * returns an array of tags
