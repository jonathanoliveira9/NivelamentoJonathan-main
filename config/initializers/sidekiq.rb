schedule_file = 'config/schedule.yml'

hash_params = {
  url: 'redis://localhost:6379/0'
}

Sidekiq.configure_server do |config|
  config.redis = hash_params
end

Sidekiq.configure_client do |config|
  config.redis = hash_params
end

Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file) && Sidekiq.server?
