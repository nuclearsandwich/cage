Cage
====

*A Faraday Cage for your HTTP Interactions.*

What Is It?
-----------

One of my favorite utilities for testing my APIs is [Rack::Test][2]. However, it
gets really offended if you try to use it in an interactive session. I ended up
using [Faraday][3] and hacked together a set of scripts that made interacting
with my APIs easy and fun. I've re-written, cleaned up, and expanded upon these
scripts and the result is Cage, a Pry-based console which implements a
Rack::Test-like internal Ruby DSL. If you don't like the name, I'm open to
suggestions. :D

What Can It Do?
---------------

**Short Answer**: Anything [Faraday][3] can do, Cage can do. However, I am
attempting to make it natural and easy to use in an interactive manner.

By default, the four HTTP verbs, `get`, `post`, `put`, and `delete`, are
available and if you prefer you can use them in SHOUTCASE in order to feel
special about it. Each of these will return a Cage::Response, which is a thin
wrapper around a Faraday::Response that facilitates prettier printing and at the
moment, the type detection and auto-parsing of JSON and XML.

Cage will also keep track of where you're at so you don't have to keep entering
the fully-qualified domain name or any prefixes common to all your requests.

For example, if you want to hit version one of the
[Rubygems.org](http://rubygems.org) API just set the domain and prefix.

```
└─> bundle exec cage
[rubygems.org:]-> set :scheme, :http
=> :http
[rubygems.org:]-> set :domain, "rubygems.org"
=> "rubygems.org"
[rubygems.org:]-> set :prefix, "api/v1/gems"
=> "api/v1/gems"
[rubygems.org:]-> get "rails.json"
=>
Status: 200

Headers:
  date: Sat, 28 Jan 2012 06:57:49 GMT
  server: Apache/2.2.3 (Red Hat) mod_ssl/2.2.3 OpenSSL/0.9.8e-fips-rhel5 Phusion_Passenger/3.0.11
  x-powered-by: Phusion Passenger (mod_rails/mod_rack) 3.0.11
  etag: "6bc2525a176ae07870d12b35d6c78dcf"
  cache-control: max-age=0, private, must-revalidate
  x-ua-compatible: IE=Edge,chrome=1
  x-runtime: 0.025598
  status: 200
  content-length: 1096
  connection: close
  content-type: application/json; charset=utf-8

Body:
  {"name"=>"rails", "downloads"=>7422057, "version"=>"3.2.1", .... }

#<Cage::Response:(http://rubygems.org/api/v1/gems/rails.json)>

[rubygems.org:200]-> get "rails.xml"
=>
Status: 200

Headers:
  date: Sat, 28 Jan 2012 06:57:53 GMT
  server: Apache/2.2.3 (Red Hat) mod_ssl/2.2.3 OpenSSL/0.9.8e-fips-rhel5 Phusion_Passenger/3.0.11
  x-powered-by: Phusion Passenger (mod_rails/mod_rack) 3.0.11
  etag: "fd13fd2f31fa180391b2e9a9b3c08b79"
  cache-control: max-age=0, private, must-revalidate
  x-ua-compatible: IE=Edge,chrome=1
  x-runtime: 0.034550
  status: 200
  content-length: 1915
  connection: close
  content-type: application/xml; charset=utf-8

Body:
  {"rubygem"=>{"name"=>"rails", "downloads"=>7422057, "version"=>"3.2.1", ... }

#<Cage::Response:(http://rubygems.org/api/v1/gems/rails.xml)>

[rubygems.org:200]-> get "wontbethere"
=>
Status: 404

Headers:
  date: Sat, 28 Jan 2012 07:43:53 GMT
  server: Apache/2.2.3 (Red Hat) mod_ssl/2.2.3 OpenSSL/0.9.8e-fips-rhel5 Phus
  x-powered-by: Phusion Passenger (mod_rails/mod_rack) 3.0.11
  cache-control: no-cache
  x-ua-compatible: IE=Edge,chrome=1
  x-runtime: 0.011617
  status: 404
  vary: Accept-Encoding
  content-length: 1053
  connection: close
  content-type: text/html; charset=utf-8

Body:
  <!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

```

Currently, Cage is attempting to remain feature reduced and free of opinions.
I have attempted to include  of all elements of the Rack::Test DSL that I wish
I'd had when hand-testing my APIs or investigating new ones. If there's
something you wish Cage did that is not currently available. Please do [File an
issue](https://github.com/nuclearsandwich/cage/issues/new) and I will do my best
to accomodate your request.

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

### Available Commands ###

- HTTP Methods:
  - `GET`/`get`: url, params, headers
  - `HEAD`/`head`: url, params, headers
  - `DELETE`/`delete`: url, params, headers
  - `POST`/`post`: url, body, headers
  - `PUT`/`put`: url, body, headers
  - `PATCH`/`patch`: url, body, headers

- Cage Methods for Requests
  - `basic_auth`: login, pass
  - `token_auth`: token, options
  - `add_middleware`: middleware_builder_block

- Anything else Ruby can do...

Configuring It
--------------

***NOTE*** Global Configs aren't supported yet. Local configs and specified
configs are working.

Cage will look first for a global `~/.cagerc.rb` file, then for a localr
`./cagerc.rb` in the working directory. Both are essentially instance_eval'd
into your new Cage console so anything that works in Cage will work in a config.
The global one is run first, so you can overload it with a local config. The
local config is for setting up project defaults, you can even automate your
initial authentication if you want.

Changelog / Roadmap
-------------------

- 0.0.1 Have a working, if ugly and hacky console. DONE

- 0.0.2 Get XML -> Nokogiri and JSON to Ruby hashes working for [@mcnalu's
friends][1] DONE

- 0.0.3 Write tests for whatever I can. WIP Study Pry's tests and read up on
  testing apps like this in [Build Awesome Command-Line Applicationss in
  Ruby][5]

- 0.1.0 Switch to using [Faraday Middleware][4] for parsing instead mf my hack
  solutions. Both XML and JSON now return Hash bodies, all other formats will
  have string bodies.

- 0.1.1
  - Provide a Cage prompt string.
  - Solidify and document the command set, which now includes HEAD, OPTIONS, and
    PATCH.
  - Support `./.cagerc.rb` configuration files and the `-c PATH_TO_CONFIG` flag.
  - Provide documented interface to allow users to add their own Faraday
    middleware.

- 0.2.0 Use decorators to pretty print responses. PARTWAY DONE

- 0.3.0 Auto detect and parse incoming body types like XML, JSON, wwwurlencode.
  DONE

- 0.4.0 Make it easier to send XML, YAML, and JSON formatted bodies.

- 0.5.0 Make some decisions about Auth.

[1]: http://identi.ca/notice/89369056
[2]: https://github.com/brynary/rack-test
[3]: https://github.com/technoweenie/faraday
[4]: https://github.com/pengwynn/faraday_middleware
[5]: http://pragprog.com/book/dccar/build-awesome-command-line-applications-in-ruby

