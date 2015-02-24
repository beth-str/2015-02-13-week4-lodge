
#------------ACTIVITIES------------

get '/admin/activity/add' do
  erb :"admin/activity/add", :layout => :layout_back
end

get '/admin/activity/add_confirm' do
  x = Activity.new(params)
  x.insert
  erb :"admin/activity/add_confirm", :layout => :layout_back
end

get '/admin/activity/edit' do
  @activities = Activity.all
  erb :"admin/activity/edit", :layout => :layout_back
end

get '/admin/activity/edit_form' do
  @form_values = Activity.where_id_is(params[:id])
  erb :"admin/activity/edit_form", :layout => :layout_back
end

get '/admin/activity/edit_confirm' do
  x = Activity.new(params)
  x.save(params)
  erb :"admin/activity/edit_confirm", :layout => :layout_back
end

get '/admin/activity/list' do
  @activities = Activity.all
  erb :"admin/activity/list", :layout => :layout_back
end

get '/admin/activity/assign' do
  erb :"admin/activity/assign", :layout => :layout_back
end

get '/admin/activity/assign_confirm' do
  populate_join(params)
  erb :"admin/activity/assign_confirm", :layout => :layout_back
end