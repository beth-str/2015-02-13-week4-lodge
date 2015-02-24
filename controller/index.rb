#-------------------PUBLIC LODGE HOMEPAGE--------------------

get "/" do
  erb :"lodge/homepage"
end


#---------------PRIVATE LODGE ADMIN HOMEPAGE-----------------

get '/admin' do
  erb :"admin/login", :layout => :layout_back
end


#--------------UTILITY-------------

not_found do
  erb :not_found
end

get "/error" do
  erb :error
end