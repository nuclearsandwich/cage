Cage
====

*A Faraday Cage for your HTTP Interactions.*

What Is It?
-----------

One of my favorite utilities for testing my APIs is [Rack::Test][2]. It gets
really offended if you try to use it in an interactive session. I ended up using
[Faraday][3] and hacked together a set of scripts that made interacting with my
APIs easy and fun. I've re-written, cleaned up, and expanded upon these scripts
and the result is Cage. If you don't like the name, I'm open to suggestions. :D

Getting It
----------

Once Cage hits 0.1.0, it will be released as a gem. Then you can install it
globally with `gem install cage`. Better still, add it to the `Gemfile` of your
project.

```ruby
group :development do
  gem "cage"
end
```

Using It
--------

Running `cage` will begin a console session. Cage is like a specialized IRB, but
for HTTP interactions. Imagine that you are working on an API. [Rack::Test][rt]
is an awesome tool but when you try to use it interactively you get an
interesting display of fireworks(read: stacktraces). Cage is based on a utility
script I wrote while working on a REST API. Some days, you just want to monkey
around with your work.

When you run Cage, you're dropped into a special Pry terminal with HTTP related
commands available.

```
└─> bundle exec cage
[1] pry(#<Cage::Console>)> set :scheme, :http
=> :http
[2] pry(#<Cage::Console>)> set :domain, "rubygems.org"
=> "rubygems.org"
[3] pry(#<Cage::Console>)> set :prefix, "api/v1/gems/"
=> "api/v1/gems/"
[4] pry(#<Cage::Console>)> get "rails.json
[4] pry(#<Cage::Console>)* !
Input buffer cleared!
[5] pry(#<Cage::Console>)> get "rails.json"
=>
Status: 200

Headers:
  date: Fri, 27 Jan 2012 08:18:39 GMT
  server: Apache/2.2.3 (Red Hat) mod_ssl/2.2.3 OpenSSL/0.9.8e-fips-rhel5 Phusion_Passenger/3.0.11
  x-powered-by: Phusion Passenger (mod_rails/mod_rack) 3.0.11
  etag: "80b55645852de87d6343e314998b5df7"
  cache-control: max-age=0, private, must-revalidate
  x-ua-compatible: IE=Edge,chrome=1
  x-runtime: 0.020594
  status: 200
  content-length: 1096
  connection: close
  content-type: application/json; charset=utf-8

Body:
  {"name"=>"rails", "downloads"=>7403026, "version"=>"3.2.1", "version_downloads"=>2598, "authors"=>"David Heinemeier Hansson", "info"=>"Ruby on Rails is a full-stack web framework optimized for programmer happiness and sustainable productivity. It encourages beautiful code by favoring convention over configuration.", "project_uri"=>"http://rubygems.org/gems/rails", "gem_uri"=>"http://rubygems.org/gems/rails-3.2.1.gem", "homepage_uri"=>"http://www.rubyonrails.org", "wiki_uri"=>"http://wiki.rubyonrails.org", "documentation_uri"=>"http://api.rubyonrails.org", "mailing_list_uri"=>"http://groups.google.com/group/rubyonrails-talk", "source_code_uri"=>"http://github.com/rails/rails", "bug_tracker_uri"=>"http://github.com/rails/rails/issues", "dependencies"=>{"development"=>[], "runtime"=>[{"name"=>"actionmailer", "requirements"=>"= 3.2.1"}, {"name"=>"actionpack", "requirements"=>"= 3.2.1"}, {"name"=>"activerecord", "requirements"=>"= 3.2.1"}, {"name"=>"activeresource", "requirements"=>"= 3.2.1"}, {"name"=>"activesupport", "requirements"=>"= 3.2.1"}, {"name"=>"bundler", "requirements"=>"~> 1.0"}, {"name"=>"railties", "requirements"=>"= 3.2.1"}]}}

#<Cage::Response>

[6] pry(#<Cage::Console>)>
```

Configuring It
--------------

***NOTE*** you can't yet. See Roadmap.

Cage will look first for a global `~/.cagerc.rb` file, then for a localr
`./cagerc.rb` in the working directory. Both are essentially instance_eval'd
into your new Cage console so anything that works in Cage will work in a config.
The global one is run first, so you can overload it with a local config. The
local config is for setting up project defaults, you can even automate your
initial authentication if you want.

Roadmap
-------

- 0.0.1 Have a working, if ugly and hacky console. DONE

- 0.0.2 Get XML -> Nokogiri and JSON to Ruby hashes working for [@mcnalu's
friends][1] DONE

- 0.0.3 Write tests for whatever I can. WIP

- 0.1.0 Clean up the prompt and solidify the command set. Support .cagerc files.

- 0.2.0 Use decorators to pretty print responses.

- 0.3.0 Auto detect and parse incoming body types like XML, JSON, wwwurlencode.

- 0.4.0 Make it easier to send XML, YAML, and JSON formatted bodies.

- 0.5.0 ???

[1]: http://identi.ca/notice/89369056
[2]: https://github.com/brynary/rack-test
[3]: https://github.com/technoweenie/faraday

