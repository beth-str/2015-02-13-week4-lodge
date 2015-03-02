#-------------RESERVATIONS-------------
get '/admin/reservation/add' do
  erb :"admin/reservation/add", :layout => :layout_back
end

post '/admin/reservation/add_confirm' do
  # before this, test the fields for ' and replace with space
  params[:name] = check_for_apostrophes(params[:name])
  params[:comments] = check_for_apostrophes(params[:comments])
  x = Reservation.new(params)
  x.insert
  redirect '/admin/reservation/show'
end

get '/admin/reservation/edit' do
  @reservations = Reservation.all
  erb :"admin/reservation/edit", :layout => :layout_back
end

get '/admin/reservation/edit_form' do
  @form_values = Reservation.where_email_is(params[:email])
  erb :"admin/reservation/edit_form", :layout => :layout_back
end

post '/admin/reservation/edit_confirm' do
  # before this, test the fields for ' and replace with space
  params[:name] = check_for_apostrophes(params[:name])
  params[:comments] = check_for_apostrophes(params[:comments])
  x = Reservation.new(params)
  x.save(params)
  redirect '/admin/reservation/show'
end

get '/admin/reservation/status' do
  erb :"admin/reservation/status", :layout => :layout_back
end

get '/admin/reservation/edit_status' do
  @form_values = Reservation.where_email_is(params[:email])
  erb :"admin/reservation/status_edit", :layout => :layout_back
end

get '/admin/reservation/delete' do
  erb :"admin/reservation/delete", :layout => :layout_back
end

get '/admin/reservation/cancel' do
  erb :"admin/reservation/cancel", :layout => :layout_back
end

get '/admin/reservation/show' do
  @reservations = Reservation.all
  erb :"admin/reservation/show", :layout => :layout_back
end

