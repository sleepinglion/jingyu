if defined?(AssetSync)
  AssetSync.configure do |config|
    config.fog_provider = 'fog/oracle'  # Oracle Cloud용 fog provider 설정

    config.fog_credentials = {
      provider:              'Oracle',  # Oracle Cloud 사용
      oracle_storage_namespace: ENV['ORACLE_STORAGE_NAMESPACE'],  # 네임스페이스
      oracle_access_key:    ENV['ORACLE_ACCESS_KEY'],  # API Access Key
      oracle_secret_key:    ENV['ORACLE_SECRET_KEY'],  # API Secret Key
      region:                ENV['ORACLE_REGION'],  # 리전
    }

    config.fog_directory = ENV['ORACLE_BUCKET']  # 버킷 이름
    config.asset_host = "https://#{ENV['ORACLE_NAMESPACE']}.compat.objectstorage.#{ENV['ORACLE_REGION']}.oraclecloud.com/#{ENV['ORACLE_BUCKET']}"

    config.existing_remote_files = "keep"  # 기존 파일 처리 방식

    # 옵션: gzip 설정
    config.gzip_compression = true
    config.manifest = true

    # Caching 설정 (옵션)
    config.custom_headers = { 'Cache-Control' => 'max-age=315576000, public' }

    # 기존 파일 덮어쓰기 방지 (옵션)
    config.always_upload = false
    config.existing_remote_files = 'delete' # or keep or ignore

    config.add_local_file_paths do
    #  # Add files to be uploaded
      Dir.chdir(Rails.root.join('public')) do
        Dir[File.join('packs', '**', '**')]
      end
    end
  end
end