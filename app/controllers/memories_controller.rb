class MemoriesController < ApplicationController
  before_action :authenticate_user

  def presigned_url
    Aws.config.update({
      region: 'ap-southeast-2',
      credentials: Aws::Credentials.new('AKIAZPLUNIQPS2V3SGR3', 'u3XVGSrCkJULm4h52eN5LSic7yww0f640Jp9gYIJ')
   })
    signer = Aws::S3::Presigner.new
    url = signer.presigned_url(:put_object, bucket: "family-matters", key: "name")
    puts "URL HERE"
    puts url
  end
  
  private
  def is_image?(filename)
    regex = Regexp.union(/.\.png$/i, /.\.jpg$/i, /.\.jpeg$/i)
    filename.match(regex)
  end
end
