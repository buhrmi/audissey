# == Schema Information
#
# Table name: uploads
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  file_name  :string
#  file_uid   :string
#  mime_type  :string
#  through    :string
#  bytes      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UploadsController < ApplicationController
  before_filter :authenticate_user!
  include ActionView::Helpers::NumberHelper # ugly. use jsonbuilder

  def index
    if params[:type] == 'image'
      files = current_user.uploads.images.limit(10).order('created_at DESC')
      json = files.map do |upload|
        {
          :thumb => upload.file.thumb('100x100#').url,
          :image => upload.file.url,
          :title => upload.file_name
        }
      end
    else
      files = current_user.uploads.not_images.limit(10).order('created_at DESC')
      json = files.map do |upload|
        {
          :size => number_to_human_size(upload.bytes),
          :name => '',
          :link => upload.file.url,
          :title => upload.file_name
        }
      end
    end

    render :json => json
  end

  def new
    render layout: false
  end

  def create
    file_param = params[:image] || params[:file]
    return unless file_param.present?

    upload = Upload.create :file => file_param, :bytes => File.size(file_param.tempfile), :user_id => current_user.id, :mime_type => file_param.content_type, :through => params[:through]


    if params[:through] == 'redactor'
      render :json => {'filelink' => upload.file.url}
    else
      if file_param.content_type.include?('image')
        @image = upload.file
        @retained_image = Dragonfly::Serializer.json_b64_encode(uid: upload.file_uid)
      end
      render action: 'new', layout: false
    end
  end

end
