# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_lospresus_session',
  :secret      => '0510deffe52d02e331d8c3b3b2fe89894170a31c6442bfe58334485d876c96e1afb7f96741cdd065db0fdbc4301093703b77a3ae53c46b5ed7c040389d90305d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
