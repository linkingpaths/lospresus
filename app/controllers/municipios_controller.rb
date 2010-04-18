class MunicipiosController < ApplicationController
  before_filter :find_muni, :only => [:show, :evolution, :compare]
  before_filter :year_context, :only => [:show, :compare]

  def show
    meta  :title        => "Presupuesto de #{@muni.nombre} en #{@year} - lospresus.de",
          :description  => "El presupuesto de #{@muni.nombre} (#{@muni.province_name}) para el año #{@year}. Fuente oficial Ministerio de Política Territorial.",
          :keywords     => "presupuestos, ayuntamientos, gastos, ingresos, subvenciones, municipios, municipal, dinero público, gasto público, #{@muni.nombre}, #{@muni.province_name}"
    
  end
  
  def search
    q = params[:q]
    @results = Municipio.search(q)

    meta  :title        => "Resultados de la búsqueda '#{q}' - lospresus.de",
          :description  => "Resultados de la búsqueda '#{q}' en lospresus.de",
          :keywords     => "presupuestos, ayuntamientos, gastos, ingresos, subvenciones, municipios, municipal, dinero público, gasto público"

    render :layout => false
  end  
  
  def compare
    @muni_b = Municipio.find(params[:b_id])
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
      @muni = Municipio.find(params[:id])               
      unless @muni 
        redirect_to :controller =>"home" 
      end
    end
    def year_context
      @year = params[:year] || Date.today.year - 1
    end
end