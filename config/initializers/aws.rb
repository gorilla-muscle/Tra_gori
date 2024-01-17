require 'aws-sdk-s3'

if Rails.application.credentials.aws
  Aws.config.update({
    region: Rails.application.credentials.aws[:region],
    credentials: Aws::Credentials.new(
      Rails.application.credentials.aws[:access_key_id],
      Rails.application.credentials.aws[:secret_access_key]
    )
  })
end
