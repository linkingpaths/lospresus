class StaticController < ApplicationController
  def show  
    render :template => "static/#{params[:page]}"
  end
end
