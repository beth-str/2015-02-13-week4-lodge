cal = Google::Calendar.new(:client_id => '212643930905-2g9plm4m8kk8fk2prqs4ojf51p16ke7v.apps.googleusercontent.com', :client_secret => 'iTLIjzSm5cNzVwuH8FCPnhTD', :calendar => 'ld27870tkt6dmn85ksm6kibrrg@group.calendar.google.com', :redirect_url  => 'http://127.0.0.1:4567/', :refresh_token => '1/CadlbSaaYaNX-ftCafL69qHH9jsX_vL95fPNCZtOCQIMEudVrK5jSpoR30zcRFq6')


#-------------CALENDAR-------------

get '/admin/calendar/add' do
  @reservations = Reservation.all
  erb :"admin/calendar/add", :layout => :layout_back
end

get '/admin/calendar/add_form' do
  @event = Reservation.where_id_is(params[:id])
  erb :"admin/calendar/add_form", :layout => :layout_back
end

get '/admin/calendar/add_confirm' do
  create_google_calendar_event(params)
  erb :"admin/calendar/confirm", :layout => :layout_back
end

get '/admin/calendar/edit' do
  @reservations = Reservation.all
  erb :"admin/calendar/edit", :layout => :layout_back
end

get '/admin/calendar/delete' do
  erb :"admin/calendar/delete", :layout => :layout_back
end

get '/admin/calendar/show' do
  @events = cal.events
  erb :"admin/calendar/show", :layout => :layout_back
end
