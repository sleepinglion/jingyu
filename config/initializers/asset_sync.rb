if defined?(AssetSync)
  AssetSync.configure do |config|
    config.fog_provider = 'oracle'  # Oracle Cloud용 fog provider 설정
    config.fog_directory = ENV['ORACLE_BUCKET']  # 버킷 이름

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