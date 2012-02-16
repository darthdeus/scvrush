# Be sure to restart your server when you modify this file.

# Scvrush::Application.config.session_store :cookie_store, key: '_scvrush_session'
Scvrush::Application.config.session_store :mem_cache_store

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Scvrush::Application.config.session_store :active_record_store
