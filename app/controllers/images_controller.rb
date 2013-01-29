class ImagesController < ApplicationController
  # TODO - replace this
  before_filter :require_writer

  def create
    @image = Image.new(params[:image])
    if @image.save
      redirect_to edit_post_path(params[:post_id]), notice: "Image successfully uploaded."
    else
      redirect_to edit_post_path(params[:post_id]), error: "Image upload failed."
    end
  end

end
