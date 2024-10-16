CarrierWave.configure do |config|
  config.fog_provider = 'fog/oracle'  # fog-oracle 사용
  config.fog_credentials = {
    provider:              'Oracle',  # Oracle Cloud 사용
    oracle_storage_namespace: ENV['ORACLE_NAMESPACE'],  # 네임스페이스
    oracle_region:        ENV['ORACLE_REGION'],  # 리전 (예: us-ashburn-1)
    oracle_access_key:    ENV['ORACLE_ACCESS_KEY'],  # Oracle API 키 (Access Key)
    oracle_secret_key:    ENV['ORACLE_SECRET_KEY'],  # Oracle API 키 (Secret Key)
  }
  config.fog_directory  = ENV['ORACLE_BUCKET']  # Object Storage 버킷 이름
  config.asset_host     = "https://#{ENV['ORACLE_NAMESPACE']}.compat.objectstorage.#{ENV['ORACLE_REGION']}.oraclecloud.com/#{ENV['ORACLE_BUCKET']}"

  config.fog_attributes = { cache_control: "public, max-age=86400" }  # 캐시 설정

  config.cache_dir = File.join(Rails.root, 'tmp', 'uploads', Rails.env)
end
