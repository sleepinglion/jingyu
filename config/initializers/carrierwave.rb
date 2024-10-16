CarrierWave.configure do |config|
  config.fog_provider = 'Oracle'  # 사용할 fog provider
  config.fog_credentials = {
    provider: 'Oracle',               # Oracle Cloud를 사용함을 명시
    oracle_username: ENV['ORACLE_USERNAME'], # Oracle Cloud 계정 정보
    oracle_password: ENV['ORACLE_PASSWORD'], # Oracle Cloud 계정 비밀번호
    oracle_domain: ENV['ORACLE_DOMAIN'],     # Oracle Cloud 도메인
    oracle_object_storage_namespace: ENV['ORACLE_NAMESPACE'], # 스토리지 네임스페이스
    oracle_tenancy: ENV['ORACLE_TENANCY'],   # Tenancy 정보
    oracle_region: ENV['ORACLE_REGION'],     # 사용할 리전
    oracle_fingerprint: ENV['ORACLE_FINGERPRINT'], # API Key의 Fingerprint
    oracle_private_key_path: ENV['ORACLE_PRIVATE_KEY_PATH'], # API Key의 프라이빗 키 파일 경로
    oracle_bucket: ENV['ORACLE_BUCKET'], # 사용할 버킷 이름
  }

  config.fog_directory  = ENV['ORACLE_BUCKET']   # 업로드할 버킷 이름
  config.fog_public     = true                       # 파일이 공개인지 여부
  config.fog_attributes = { cache_control: "public, max-age=86400" } # 캐싱 옵션

  config.cache_dir = File.join(Rails.root, 'tmp', 'uploads', Rails.env)
end
