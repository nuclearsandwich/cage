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

If you have a `.cagerc.rb` (and I've written the code to support it) it will be
eval'd into your current session.

