require 'rubygems'
require 'sinatra'
<<<<<<< HEAD
=======
require 'sinatra/reloader'
require 'sqlite3'
>>>>>>> ba70153b52706a29056ef80a238c60faf91d0f77


get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end

get '/aircount' do

		
	erb :visit

end

get '/aircount/round/' do

  erb :round

end


post '/aircount/round' do

	@round = params[:round]
	@speed = params[:speed]
	@object = params[:object]
	@room = params[:room]
	@spot = params[:spot]

	x = 3.14*(((@round.to_f/2)*0.001)*((@round.to_f/2)*0.001))*@speed.to_f*3600

	@volume = x.to_i



	db = SQLite3::Database.new 'public/Data.sqlite'

	db.execute "CREATE TABLE IF NOT EXISTS #{@object} (id INTEGER PRIMARY KEY AUTOINCREMENT, room TEXT, spot TEXT, volume TEXT);"

	db.execute "INSERT INTO #{@object} (room, spot, volume ) values  (?,?,?)", [@room, @spot, @volume]

    db.close

  erb :round
end

get '/aircount/square' do
 
 erb :square


end





post '/aircount/square' do
	
	@side1 = params[:side1]
	@side2 = params[:side2]
	@speed = params[:speed]

	@object = params[:object]
	@room = params[:room]
	@spot = params[:spot]

	x = (@side1.to_f*0.001)*(@side2.to_f*0.001)*@speed.to_f*3600

	@volume = x.to_i

	
	db = SQLite3::Database.new 'public/Data.sqlite'

	db.execute "CREATE TABLE IF NOT EXISTS #{@object} (id INTEGER PRIMARY KEY AUTOINCREMENT, room TEXT, spot TEXT, volume TEXT);"

	db.execute "INSERT INTO #{@object} (room, spot, volume ) values  (?,?,?)", [@room, @spot, @volume]

    db.close


	erb :square

end




get "/pict" do
	erb :pict
	end


post "/visittime"  do 

		@username = params[:username]
		@phone = params[:phone]
		@datetime = params[:datetime]



		@title = "Dear #{@username}! welcome"

		@message = "We are waiting for you at #{@datetime}. If there are changes we`ll call you at #{@phone}"



		erb :visittime


end


get '/showbase' do
@hh = {}


  erb :showbase

end



post '/showbase' do

	@object = params[:object]

 	@hh = {}



	db = SQLite3::Database.new 'public/Data.sqlite'

	db.results_as_hash = true
	
	@n=1


	db.execute "select id, room, spot, volume from #{@object}" do |key, value|
		
		@hh[@n] = key

		
		@n=@n+1
		
	end

    db.close

  erb :showbase

end