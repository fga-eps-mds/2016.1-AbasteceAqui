class StatisticsController < ApplicationController
  

  def index
  end

  def prices_by_year
  	
  	@researches_of_county = County.search__all_county_researches(@county_searched)


  	@years_of_researches = 


  	@years.each do |year|

  	end

  end


def county_anual

	
	@states = State.fill_states

	@state_searched = params[:state_searched]

	@SearchController = SearchController.new

	if @state_searched != nil
		@counties_of_state = @SearchController.find_counties_of_state(@state_searched)
	else
		@state_searched = 'ACRE' 
		@counties_of_state = @SearchController.find_counties_of_state(@state_searched)
	end

	@county_searched = 'XAPURI'
	@years = [2013, 2014, 2015]

	titulo = "Preço do combustivel no decorrer dos anos"

	@chart = LazyHighCharts::HighChart.new('graph') do |f|
  f.title(text:  titulo)
  f.xAxis(categories: @years)
  f.series(name: "Preço Da Gasolina", yAxis: 0, data: [14119, 5068, 4985, 3339, 2656, 14119, 5068, 4985, 3339, 2656, 14119, 5068, 4985, 3339])
  

  f.yAxis [
    {title: {text: "Preço Da Gasolina", margin: 70} },
    {title: {text: "Preço Da Etanol", margin: 70} },

  ]

  f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
  f.chart({defaultSeriesType: "line"})
  end
	
end

def fuels_of_year
  	
  	@researches_of_county = County.search_all_county_researches(@county_searched)

  	@years_of_researches = Hash.new 


  	@years.each do |year|
  		@years_of_researches[year] = Hash.new
  		@researches_of_year = [] 

  		@researches_of_county.each do |research|
  		
	  		if research.date.strftime("%Y").to_i == year
	  			@researches_of_year << research.fuels
	  		end

  		end

			@years_of_researches[year] = @researches_of_year
  	
  	end

  end




end
