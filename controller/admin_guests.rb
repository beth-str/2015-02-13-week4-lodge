#-------------GUESTS-------------

get '/admin/add_guest' do
  erb :ad_guest_add, :layout => :layout_back
end

get '/admin/add_guest_confirm' do
  @x = Guest.new(params)
  @x.insert
  erb :ad_guest_add_confirm, :layout => :layout_back
end

get '/admin/edit_guest' do
  @guests = Guest.all
  erb :ad_guest_edit, :layout => :layout_back
end

get '/admin/edit_guest_form' do
  @form_values = Guest.where_id_is(params[:id])
  erb :ad_guest_edit_form, :layout => :layout_back
end

get '/admin/edit_guest_confirm' do
  x = Guest.new(params)
  x.save(params)
  @x = x
  erb :ad_guest_edit_confirm, :layout => :layout_back
end

get "/admin/show_guest" do
  @results_as_objects = Reservation.all
  @guests = Guest.all 
  erb :ad_guest_show, :layout => :layout_back
end

get '/admin/show_activities' do
  @reservations = Reservation.all
  @guest_activity = GuestActivity.show_guests_activities
  @activities = Activity.all
  erb :ad_activity_show, :layout => :layout_back
end
