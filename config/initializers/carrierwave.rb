CarrierWave.configure do |config|
  config.fog_provider = 'AWS'  # fog-aws 사용
  config.fog_credentials = {
    provider:              'AWS',  # S3 호환 API 사용
    aws_access_key_id:     ENV['ORACLE_ACCESS_KEY'],  # Oracle Cloud Access Key
    aws_secret_access_key: ENV['ORACLE_SECRET_KEY'],  # Oracle Cloud Secret Key
    region:                ENV['ORACLE_REGION'],           # Oracle Cloud 리전 (예: 'us-ashburn-1')
    #   endpoint:              "https://#{ENV['ORACLE_NAMESPACE']}.compat.objectstorage.#{ENV['ORACLE_REGION']}.oraclecloud.com",  # Oracle S3 호환 API 엔드포인트
    path_style:            true  # Oracle Object Storage의 호환성을 위한 설정
  }
  config.fog_directory  = ENV['ORACLE_BUCKET']  # Object Storage 버킷 이름
  config.fog_public     = false  # 파일을 퍼블릭으로 설정할지 여부
  config.fog_attributes = { cache_control: "public, max-age=86400" }  # 캐시 설정

  config.cache_dir = File.join(Rails.root, 'tmp', 'uploads', Rails.env)
end
