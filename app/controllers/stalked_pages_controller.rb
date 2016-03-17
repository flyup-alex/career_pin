class StalkedPagesController < ApplicationController

before_action :authenticate_company!
  def index
  	@observed_pages = current_company.stalked_pages.all
  end

  def create
  	@stalked_page = StalkedPage.new(super_params)
  	if @stalked_page.save 
  		redirect_to :back
  	else
  		redirect_to root_path
  	end

    flash[:success] = "You are following this page"
    flash[:notice] = "You can now easy-access to this page in your bookmarks!"
  end

  def destroy
  	@stalked_page = current_company.stalked_pages.find_by(pageid: params[:id])
  	if @stalked_page.destroy
  	 redirect_to :back
  	else
  	 redirect_to :root_path
  	end
  
  flash[:success] = "You have unfollowed this page"
  flash[:notice] = "This page has been removed from your bookmarks"

  end

  private
  def super_params
  	params.require(:stalked_page).permit(:name, :pageid, :image_url, :company_id, :provider)
  end
  
end
