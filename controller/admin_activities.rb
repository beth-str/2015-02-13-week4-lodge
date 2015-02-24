
#------------ACTIVITIES------------

get '/admin/activity_add' do
  erb :ad_activity_add, :layout => :layout_back
end

get '/admin/activity_add_confirm' do
  x = Activity.new(params)
  x.insert
  erb :ad_activity_add_confirm, :layout => :layout_back
end

get '/admin/activity_edit' do
  @activities = Activity.all
  erb :ad_activity_edit, :layout => :layout_back
end

get '/admin/activity_edit_form' do
  @form_values = Activity.where_id_is(params[:id])
  erb :ad_activity_edit_form, :layout => :layout_back
end

get '/admin/activity_edit_confirm' do
  x = Activity.new(params)
  x.save(params)
  erb :ad_activity_edit_confirm, :layout => :layout_back
end

get '/admin/activity_list' do
  @activities = Activity.all
  erb :ad_activity_list, :layout => :layout_back
end

get '/admin/activity_assign' do
  erb :ad_activity_assign, :layout => :layout_back
end

get '/admin/activity_assign_confirm' do
  populate_join(params)
  erb :ad_activity_assign_confirm, :layout => :layout_back
end


