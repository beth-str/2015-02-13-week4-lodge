#-------------GUESTS-------------

get '/admin/guest/add' do
  erb :"admin/guest/add", :layout => :layout_back
end

post '/admin/guest/add_confirm' do
  @x = Guest.new(params)
  @x.insert
  redirect "admin/guest/show"
end

get '/admin/guest/edit' do
  @guests = Guest.all
  erb :"admin/guest/edit", :layout => :layout_back
end

get '/admin/guest/edit_form' do
  @form_values = Guest.where_id_is(params[:id])
  erb :"admin/guest/edit_form", :layout => :layout_back
end

post '/admin/guest/edit_confirm' do
  x = Guest.new(params)
  x.save(params)
  @x = x
  redirect "admin/guest/show"
end

get "/admin/guest/show" do
  @results_as_objects = Reservation.all
  @guests = Guest.all 
  erb :"admin/guest/show", :layout => :layout_back
end

get '/admin/guest/show_activities' do
  @reservations = Reservation.all
  @guest_activity = GuestActivity.show_guests_activities
  @activities = Activity.all
  erb :"admin/guest/show_activity", :layout => :layout_back
end
