class MunicipiosController < ApplicationController
  before_filter :find_muni, :only => [:show]

  def show
    #meta :title => "Lospresus.de"
    
    respond_to do |wants|
      wants.html 
      wants.xml  { render :xml => @muni }
    end
  end
  
  def search
    q = params[:q]
    @results = Municipio.search(q)
    render :layout => false
  end

  private
    def find_muni
      @muni = Municipio.find(params[:id])               
      unless @muni 
        redirect_to :controller =>"home" 
      end
    end
end