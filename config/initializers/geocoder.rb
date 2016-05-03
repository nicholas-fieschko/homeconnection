# config/initializers/geocoder.rb
Geocoder.configure(
  # geocoding service (see below for supported options):
  :lookup => :google,

  # to use an API key:
  :api_key => "AIzaSyA-J3rZC37WAHy2FPXx9cOwWqiMMvuk8o0",

  # set default units to miles:
  :units => :mi,

  # Cache results with Redis
  :cache => Redis.new(:host => 'localhost', :port => 6379)
)