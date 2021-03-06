class MunicipiosController < ApplicationController
  before_filter :find_muni, :only => [:show, :evolution, :compare, :search_for_compare, :cities_to_compare_by_query]
  before_filter :year_context, :only => [:show, :compare]

  def show
    meta  :title        => "Presupuesto de #{@muni.nombre} en #{@year} - lospresus.de",
          :description  => "El presupuesto de #{@muni.nombre} (#{@muni.province_name}) para el año #{@year}. Fuente oficial Ministerio de Política Territorial.",
          :keywords     => "presupuestos, ayuntamientos, gastos, ingresos, subvenciones, municipios, municipal, dinero público, gasto público, #{@muni.nombre}, #{@muni.province_name}"
    
  end
  
  def cities_by_query
    search_by_query
  end
  
  def search
    search_by_query(:limit => 10)
    render :layout => false
  end  
  
  def cities_to_compare_by_query
    search_by_query
  end  
  
  def search_for_compare
    search_by_query(:limit => 10)
    render :layout => false
  end  
  
  def compare
    @muni_b = Municipio.find_by_slug(params[:b_id])
    meta  :title        => "Comparativa de los municipios de #{@muni.nombre} y #{@muni_b.nombre} - lospresus.de",
          :description  => "Presupuesto comparado de #{@muni.nombre} (#{@muni.province_name}) y #{@muni_b.nombre} (#{@muni_b.province_name}) en #{@year}. Fuente oficial Ministerio de Política Territorial.",
          :keywords     => "presupuestos, ayuntamientos, gastos, ingresos, subvenciones, municipios, municipal, dinero público, gasto público, #{@muni.nombre}, #{@muni.province_name}, #{@muni_b.nombre}, #{@muni_b.province_name}"

  end
  
  def evolution
    meta  :title        => "Evolución de los presupuestos de #{@muni.nombre} - lospresus.de",
          :description  => "Evolución presupuestaria de #{@muni.nombre} (#{@muni.province_name}) a lo largo de los años asi como la evolución del número de sus habitantes. Fuente oficial Ministerio de Política Territorial e INE.",
          :keywords     => "presupuestos, ayuntamientos, gastos, ingresos, subvenciones, municipios, municipal, dinero público, gasto público, evolución,evolución presupuestaria, población, #{@muni.nombre}, #{@muni.province_name}"
  end

  private
    def find_muni
      @muni = Municipio.find_by_slug(params[:id])               
      unless @muni 
        redirect_to :controller =>"home" 
      end
    end
    def year_context
      @year = params[:year] || Date.today.year - 1
    end
    def search_by_query(options={})
      @q = params[:q]

      @results = Municipio.search(@q, options)

      meta  :title        => "Resultados de la búsqueda '#{@q}' - lospresus.de",
            :description  => "Resultados de la búsqueda '#{@q}' en lospresus.de",
            :keywords     => "presupuestos, ayuntamientos, gastos, ingresos, subvenciones, municipios, municipal, dinero público, gasto público"
      
    end
end