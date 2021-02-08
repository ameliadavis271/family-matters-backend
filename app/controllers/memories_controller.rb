class MemoriesController < ApplicationController
  before_action :authenticate_user
  before_action :set_credentials

  def index
    @memories_links = []
    @memories = current_user.family.memories
    @memories.each do |memory|
      puts memory.name
      link = get_object_url(memory.name)
      @memories_links << { 
        name: memory.name,
        description: memory.description,
        id: memory.id,
        url: link
       }
    end
    render json: @memories_links
  end

  def create
    @memory = current_user.family.memories.create(image_params)
    if @memory.save
      render json: { message: "Success" }, status: 200
    else
      render json: { message: "Failed" }, status: 400
    end
  end

  def destroy
    @memory = Memory.find(params[:id])
    bucket = Aws::S3::Bucket.new("family-matters")
    obj = bucket.object("#{current_user.family.family_id}/#{@memory.name}")
    obj.delete
    @memory.destroy
  end

  def presigned_url
    signer = Aws::S3::Presigner.new
    url = signer.presigned_url(:put_object, bucket: "family-matters", key: "#{current_user.family.family_id}/#{image_params[:name]}")
    response = {
      url: url
    }
    render json: response
  end

  def get_object_url(key)
    signer = Aws::S3::Presigner.new
    url = signer.presigned_url(:get_object, bucket: "family-matters", key: "#{current_user.family.family_id}/#{key}")
    return url
  end
  
  private
  def set_credentials
    Aws.config.update({
      region: 'ap-southeast-2',
      credentials: Aws::Credentials.new(Rails.application.credentials.dig(:aws, :access_key_id), Rails.application.credentials.dig(:aws, :secret_access_key))
   })
  end

  def image_params
    params.require(:image).permit(:name, :description)
  end
end
