Cage
====

*A Faraday Cage for your HTTP Interactions.*


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
[
    [0] 200,
    [1] {
                   "server" => "nginx",
                     "date" => "Thu, 26 Jan 2012 19:56:30 GMT",
             "content-type" => "application/x-javascript; charset=UTF-8",
        "transfer-encoding" => "chunked",
               "connection" => "close",
                  "expires" => "Thu, 26 Jan 2012 19:56:31 GMT",
            "cache-control" => "max-age=1"
    },
    [2] "{\"Definition\":\"Hackers do *not* generally use this to mean FUBAR..."
]
```

Configuring It
--------------

Cage will look first for a global `~/.cagerc.rb` file, then for a localr
`./cagerc.rb` in the working directory. Both are essentially instance_eval'd
into your new Cage console so anything that works in Cage will work in a config.
The global one is run first, so you can overload it with a local config. The
local config is for setting up project defaults, you can even automate your
initial authentication if you want.

Roadmap
-------

- 0.0.1 Have a working, if ugly and hacky console.

- 0.0.2 Get XML -> Nokogiri and JSON to Ruby hashes working for [@mcnalu's
friends][1]

- 0.0.3 Write tests for whatever I can.

- 0.1.0 Clean up the prompt and solidify the command set. Support .cagerc files.

- 0.2.0 Use decorators to pretty print responses.

- 0.3.0 Auto detect and parse incoming body types like XML, JSON, wwwurlencode.

- 0.4.0 Make it easier to send XML, YAML, and JSON formatted bodies.

- 0.5.0 ???

[1]: http://identi.ca/notice/89369056

