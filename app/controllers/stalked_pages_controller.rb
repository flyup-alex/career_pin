class StalkedPagesController < ApplicationController
  def index
  end

  def create
  	@stalked_page = StalkedPage.new(super_params)
  	if @stalked_page.save 
  		redirect_to :back
  	else
  		redirect_to root_path
  	end
  end

  def destroy
  	@stalked_page = current_company.stalked_pages.find_by(pageid: params[:id])
  	if @stalked_page.destroy
  	 redirect_to :back
  	else
  	 redirect_to :root_path
  	end
  end

  private
  def super_params
  	params.require(:stalked_page).permit(:name, :pageid, :image_url, :company_id, :provider)
  end
  
end
