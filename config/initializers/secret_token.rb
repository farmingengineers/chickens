# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
MattsChickens::Application.config.secret_key_base =
  if Rails.env.production?
    ENV['CHICKENS_SECRET_KEY_BASE']
  else
    '63efac3772a4d1581455a16f9cbb580f4eafbe6d1476f4d72a8a1836f3f9f96fafd1c955d2ce5cc66e1e6316d3358beef8c47f0f64176b180fcb1f2c14deb325'
  end

# Set the old secret so that existing cookies will be upgraded transparently.
# I don't need this in prod, but would like it for dev.
MattsChickens::Application.config.secret_token =
  if Rails.env.production?
    ENV['CHICKENS_SESSION_TOKEN']
  else
    'c446f92486996ab56d02139febe13a78205d04a2afd8bab4620ce312fe9e06a1d09f77d5f4e67dbdad09e85628ed4b13cd07c2fd686f333d66b841bbf053e5ab'
  end
