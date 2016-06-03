class StatisticsController < ApplicationController
  


  def index
  end

  def county_anual

  	
  	@states = State.fill_states

  	@counties_of_state = [1234, 3456, "sdsds"]
  	@years = [2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013,
             2014, 2015, 2016]

  	titulo = "Preço do combustivel no decorrer dos anos"

  	@chart = LazyHighCharts::HighChart.new('graph') do |f|
	  f.title(text:  titulo)
	  f.xAxis(categories: ["2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016"])
	  f.series(name: "Preço Da Gasolina", yAxis: 0, data: [14119, 5068, 4985, 3339, 2656, 14119, 5068, 4985, 3339, 2656, 14119, 5068, 4985, 3339])
	  

	  f.yAxis [
	    {title: {text: "Preço Da Gasolina", margin: 70} },
	
	  ]

	  f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
	  f.chart({defaultSeriesType: "line"})
	end

	
  	
 end

end
