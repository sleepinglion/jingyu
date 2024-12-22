if defined?(AssetSync)
  AssetSync.configure do |config|
    config.fog_provider = ENV['FOG_PROVIDER']
    config.azure_storage_account_name = ENV['AZURE_STORAGE_ACCOUNT_NAME']
    config.azure_storage_access_key = ENV['AZURE_STORAGE_ACCESS_KEY']
    config.fog_directory = ENV['FOG_DIRECTORY']

    # Don't delete files from the store
    config.existing_remote_files = "delete"

    # Automatically replace files with their equivalent gzip compressed version
    config.gzip_compression = true

    # Make sure importmap JavaScript files are included
    config.manifest = 'public/assets/manifest.json'

    # If you're using the asset pipeline and Sprockets for JS files, include the directory
    config.include = ['app/assets/javascripts', 'public/assets']

    config.custom_headers = { '.*' => { cache_control: 'max-age=31536000', expires: 1.year.from_now.httpdate } }
  end
end