#-------------RESERVATIONS-------------

get '/admin' do
  erb :ad_login, :layout => :layout_back
end

get '/admin/home' do
  erb :ad_admin_menu, :layout => :layout_back
end

get '/admin/add_reservation' do
  erb :ad_reservation_add, :layout => :layout_back
end

get '/admin/add_reservation_confirm' do
  x = Reservation.new(params)
  x.insert
  erb :ad_reservation_add_confirm, :layout => :layout_back
end

get '/admin/edit_reservation' do
  @reservations = Reservation.all
  erb :ad_reservation_edit, :layout => :layout_back
end

get '/admin/edit_reservation_form' do
  @form_values = Reservation.where_email_is(params[:email])
  erb :ad_reservation_edit_form, :layout => :layout_back
end

get '/admin/edit_reservation_confirm' do
  x = Reservation.new(params)
  x.save(params)
  erb :ad_reservation_edit_confirm, :layout => :layout_back
end

get '/admin/reservation_status' do
  erb :ad_reservation_status, :layout => :layout_back
end

get '/admin/edit_reservation_status' do
  @form_values = Reservation.where_email_is(params[:email])
  erb :ad_reservation_status_edit, :layout => :layout_back
end

get '/admin/delete_reservation' do
  erb :ad_reservation_delete, :layout => :layout_back
end

get '/admin/cancel_reservation' do
  erb :ad_reservation_status, :layout => :layout_back
end

get '/admin/show_reservation' do
  @reservations = Reservation.all
  erb :ad_reservation_show, :layout => :layout_back
end

