# TODO change it to find on create
User.create! :email => 'admin@test.cz', :password => 'testtest', :password_confirmation => 'testtest', :confirmed_at => Time.now


admin = User.find(1)
admin.add_role :admin
