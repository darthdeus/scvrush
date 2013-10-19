s3 = RockConfig.for("s3")

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => "AWS",
    :aws_access_key_id      => s3.access,
    :aws_secret_access_key  => s3.secret,
    # :host                   => "s3.amazonaws.com",
    # :region                 => 'eu-west-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'scvrush'
  config.fog_public     = true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end
