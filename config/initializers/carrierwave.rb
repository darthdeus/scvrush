CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAJH576AGO6YYVUH4Q',       # required
    :aws_secret_access_key  => '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',       # required
    # :region                 => 'eu-west-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'scvrush'                     # required
  config.fog_host       = 'https://s3.amazonaws.com/scvrush'            # optional, defaults to nil
  config.fog_public     = true                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end

