# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
MattsChickens::Application.config.secret_token =
  if Rails.env.production?
    ENV['CHICKENS_SESSION_TOKEN']
  else
    'c446f92486996ab56d02139febe13a78205d04a2afd8bab4620ce312fe9e06a1d09f77d5f4e67dbdad09e85628ed4b13cd07c2fd686f333d66b841bbf053e5ab'
  end
