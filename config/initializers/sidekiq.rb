Sidekiq.configure_server do |config|
  config.redis = { url: "rediss://#{Equisettle::Application.credentials.redis_username}:#{Equisettle::Application.credentials.redis_password}@#{Equisettle::Application.credentials.redis_url}:#{Equisettle::Application.credentials.redis_port}"}  if Rails.env.production?
  config.redis = { url: "rediss://#{Equisettle::Application.credentials.redis_username}:#{Equisettle::Application.credentials.redis_password}@#{Equisettle::Application.credentials.redis_url}:#{Equisettle::Application.credentials.redis_port}"}  if Rails.env.staging?
  config.redis = { url: 'redis://localhost:6379/0' }  if Rails.env.development?
end

Sidekiq.configure_client do |config|
  config.redis = { url: "rediss://#{Equisettle::Application.credentials.redis_username}:#{Equisettle::Application.credentials.redis_password}@#{Equisettle::Application.credentials.redis_url}:#{Equisettle::Application.credentials.redis_port}"}  if Rails.env.production?
  config.redis = { url: "rediss://#{Equisettle::Application.credentials.redis_username}:#{Equisettle::Application.credentials.redis_password}@#{Equisettle::Application.credentials.redis_url}:#{Equisettle::Application.credentials.redis_port}"}  if Rails.env.staging?
  config.redis = { url: 'redis://localhost:6379/0' }  if Rails.env.development?
end
