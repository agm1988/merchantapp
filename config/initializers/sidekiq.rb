Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] || 'redis://0.0.0.0:6379' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] || 'redis://0.0.0.0:6379' }
end

Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path('../../sidekiq_scheduler.yml', __FILE__))
    Sidekiq::Scheduler.reload_schedule!
  end
end
