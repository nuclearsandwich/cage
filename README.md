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
-> set_hostname! "http://google.com"
=> "http://google.com"
]-> get "q=hello world"

=> [{"locacation"=>"http://www.google.com/?q=foobar",
 "content-type"=>"text/html; charset=UTF-8",
 "date"=>"Thu, 26 Jan 2012 16:19:00 GMT",
 "expires"=>"Sat, 25 Feb 2012 16:19:00 GMT",
 "cache-control"=>"public, max-age=2592000",
 "server"=>"gws",
 "content-length"=>"228",
 "x-xss-protection"=>"1; mode=block",
 "x-frame-options"=>"SAMEORIGIN",
 "connection"=>"close"},
 200,
 "<HTML><HEAD><meta http-equiv=\"content-type\" content=\"text/html;charset=utf-8\">\n<TITLE>301 Moved</TITLE></HEAD><BODY>\n<H1>301 Moved</H1>\nThe document has moved\n<A HREF=\"http://www.google.com/?q=foobar\">here</A>.\r\n</BODY></HTML>\r\n"]
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

- 0.0.2 Write tests for whatever I can.

- 0.1.0 Clean up the prompt and solidify the command set. Support .cagerc files.

- 0.2.0 Use decorators to pretty print responses.

- 0.3.0 Auto detect and parse incoming body types like XML, JSON, wwwurlencode.

- 0.4.0 Make it easier to send XML, YAML, and JSON formatted bodies.

- 0.5.0 ???

