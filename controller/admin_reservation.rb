#-------------RESERVATIONS-------------

get '/admin' do
  erb :"admin/ad_login", :layout => :layout_back
end

get '/admin/reservation/add' do
  erb :"admin/reservation/add", :layout => :layout_back
end

get '/admin/reservation/add_confirm' do
  x = Reservation.new(params)
  x.insert
  erb :"admin/reservation/add_confirm", :layout => :layout_back
end

get '/admin/reservation/edit' do
  @reservations = Reservation.all
  erb :"admin/reservation/edit", :layout => :layout_back
end

get '/admin/reservation/edit_form' do
  @form_values = Reservation.where_email_is(params[:email])
  erb :"admin/reservation/edit_form", :layout => :layout_back
end

get '/admin/reservation/edit_confirm' do
  x = Reservation.new(params)
  x.save(params)
  erb :"admin/reservation/edit_confirm", :layout => :layout_back
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

