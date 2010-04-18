class MunicipiosController < ApplicationController
<<<<<<< HEAD:app/controllers/municipios_controller.rb
  before_filter :find_muni, :only => [:show, :compare]
  before_filter :year_context, :only => [:show, :compare]
=======
  before_filter :find_muni, :only => [:show, :evolution]
>>>>>>> 5bba0b05686ec02bc5ec13bd0f2962d150c9958b:app/controllers/municipios_controller.rb

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
  
  def compare
    @muni_b = Municipio.find(params[:b_id])
  end
  
  def evolution
    
  end

  private
    def find_muni
      @muni = Municipio.find(params[:id])               
      unless @muni 
        redirect_to :controller =>"home" 
      end
    end
    def year_context
      @year = params[:year] || Date.today.year - 1
    end
end