class PinsController < ApplicationController
  def index
  end

  def create
  	@pin = Pin.new(super_params)
  	if @pin.save
  		redirect_to :back
  	else
  		redirect_to root_path
  	end 
  end

  def destroy
    @pin = Pin.find(params[:id])
    if @pin.destroy
      redirect_to :back
    else
      redirect_to career_path
    end 
  end

  def new
  end

  private

  def super_params

  	params.require(:pin).permit(:author_image, :link, :provider, :image, :author_name, :message, :creation_time, :social_user_id, :company_id, :company_name)
  	
  end
end
