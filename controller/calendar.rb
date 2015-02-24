#-------------CALENDAR-------------

get '/admin/calendar_add' do
  @reservations = Reservation.all
  erb :ad_calendar_add, :layout => :layout_back
end

get '/admin/calendar_add_form' do
  @event = Reservation.where_id_is(params[:id])
  erb :ad_calendar_add_form, :layout => :layout_back
end

get '/admin/calendar_add_confirm' do
  create_google_calendar_event(params)
  erb :ad_calendar_confirm, :layout => :layout_back
end

get '/admin/calendar_edit' do
  @reservations = Reservation.all
  erb :ad_calendar_edit, :layout => :layout_back
end

get '/admin/calendar_delete' do
  erb :ad_calendar_delete, :layout => :layout_back
end

get '/admin/calendar_show' do
  cal = Google::Calendar.new(:client_id => '212643930905-2g9plm4m8kk8fk2prqs4ojf51p16ke7v.apps.googleusercontent.com', :client_secret => 'iTLIjzSm5cNzVwuH8FCPnhTD', :calendar => 'ld27870tkt6dmn85ksm6kibrrg@group.calendar.google.com', :redirect_url  => 'http://127.0.0.1:4567/', :refresh_token => '1/CadlbSaaYaNX-ftCafL69qHH9jsX_vL95fPNCZtOCQIMEudVrK5jSpoR30zcRFq6')
  @events = cal.events
  erb :ad_calendar_show, :layout => :layout_back
end
