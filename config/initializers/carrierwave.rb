CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_host = "https://#{ENV['ORACLE_NAMESPACE']}.compat.objectstorage.#{ENV['ORACLE_REGION']}.oraclecloud.com"
  config.fog_directory = ENV['ORACLE_BUCKET']
  config.asset_host = "https://#{ENV['ORACLE_NAMESPACE']}.compat.objectstorage.#{ENV['ORACLE_REGION']}.oraclecloud.com/#{ENV['ORACLE_BUCKET']}"
  config.fog_attributes = { cache_control: "public, max-age=86400" }  # 캐시 설정

  config.cache_dir = File.join(Rails.root, 'tmp', 'uploads', Rails.env)
end
