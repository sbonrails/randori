# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_card_counting_session',
  :secret      => '2a6a14646a503cc65bba5ce2548a4a24ce87ec8086220c1d23342eaa1209b7611682aaccf6dbf579a58f454a7767ef078093601cdf246911fef9263881c25bb4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
