# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_infomopticon_session',
  :secret      => '91034d94106868eb87c3af9c3307db84669004a70cf5c65947c89ad2d62b072e37e682681b0e2d3de503a8fd9120b25d35e16b875f78102f62675c0cca6f62b0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
