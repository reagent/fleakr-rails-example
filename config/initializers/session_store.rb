# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_fleakr-rails-example_session',
  :secret      => '0d85a881ddc4b8006ee64edbed6a2a0edd166d86001e912bb138451a1dfe5aded363f26700d2d186b7f5f649e6c0788726efb7f18ed7477611e0946509ff5fee'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
