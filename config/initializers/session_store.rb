# Be sure to restart your server when you modify this file.

require "action_dispatch/middleware/session/dalli_store"
Scvrush::Application.config.session_store :dalli_store, key: "_scvrush_session", expire_after: 1.week

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Scvrush::Application.config.session_store :active_record_store
