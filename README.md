# An Example Rails Application

This application is designed to demonstrate how one might use the [Fleakr gem](http://github.com/reagent/fleakr) 
to retrieve data from the Flickr API on behalf of an individual user. This is really just a proof-of-concept of
how you would go about implementing this integration, you wouldn't want to do this on an actual application as 
it's *horribly* slow and would likely get you locked out of the Flickr API with even moderate use.

## Configuration

To get started, you'll need to set up an API key and secret from your Flickr account (see the gem documentation for
full details on how to do this).  When configuring your callback URL, you can use `http://localhost:3000/login` if
you're using `script/server` to run the application.

Steps to run:

1. Rename `initializers/fleakr.rb.example` to `initializers/fleakr.rb` and provide the information from your newly
   created API key
1. Run `script/server` to boot Mongrel
1. Point your browser to http://localhost:3000/

Once you authorize your Flickr account, you can browse the photos and sets that you have available as part of your
account.  

## Credits

Copyright 2009 Patrick Reagan (reaganpr@gmail.com)
