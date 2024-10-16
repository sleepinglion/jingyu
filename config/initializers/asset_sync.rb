if defined?(AssetSync)
  AssetSync.configure do |config|
    # Set this to true to enable assets sync
    config.enabled = true

    # AWS S3 호환 API 사용
    config.aws_access_key_id = ENV['ORACLE_ACCESS_KEY']
    config.aws_secret_access_key = ENV['ORACLE_SECRET_KEY']

    # Oracle Object Storage의 S3 호환 API 엔드포인트
    config.fog_provider = 'fog/aws'
    config.fog_directory = ENV['ORACLE_BUCKET']
    config.fog_region = ENV['ORACLE_REGION']
    #config.fog_host = ENV['ORACLE_ENDPOINT'] # Oracle Object Storage S3 호환 API 엔드포인트

    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['ORACLE_ACCESS_KEY'],
      aws_secret_access_key: ENV['ORACLE_SECRET_KEY'],
      region: ENV['ORACLE_REGION'],
      endpoint: "https://#{ENV['ORACLE_NAMESPACE']}.compat.objectstorage.#{ENV['ORACLE_REGION']}.oraclecloud.com"
    }

    # 해당 리소스에 대한 public-read 권한 부여 (필요시 설정)
    config.aws_acl = 'public-read'

    # 옵션: gzip 설정
    config.gzip_compression = true
    config.manifest = true

    # Caching 설정 (옵션)
    config.custom_headers = { 'Cache-Control' => 'max-age=315576000, public' }

    # Invalidations for CDN (선택 사항)
    config.invalidate = true

    # 기존 파일 덮어쓰기 방지 (옵션)
    config.always_upload = false
    config.existing_remote_files = 'delete' # or keep or ignore

    #config.add_local_file_paths do
    #  # Add files to be uploaded
    #  Dir.chdir(Rails.root.join('public')) do
    #    Dir[File.join('packs', '**', '**')]
    #  end
    #end
  end
end