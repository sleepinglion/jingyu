CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog

    config.fog_provider = 'fog/oracle'  # Oracle Cloud용 fog provider 설정
    config.fog_directory = ENV['ORACLE_BUCKET']  # 버킷 이름

    # Oracle Cloud 인증 정보를 위한 설정 (환경 변수 사용)
    config.fog_credentials = {
      provider:              'Oracle',
      oracle_storage_namespace: ENV['ORACLE_NAMESPACE'],
      oracle_access_key:    ENV['ORACLE_ACCESS_KEY'],
      oracle_secret_key:    ENV['ORACLE_SECRET_KEY'],
      region:                ENV['ORACLE_REGION'],
    }
    #config.fog_public     = false                                   # optional, defaults to true
    config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' } # optional, defaults to {}
  else
    config.storage = :file
  end

  config.cache_dir = File.join(Rails.root, 'tmp', 'uploads', Rails.env)
end
