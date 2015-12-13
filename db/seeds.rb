[:admin, :user].each do |role|
  Role.find_or_create_by({ name: role })
end

# TODO change it to find on create
admin = User.create! do |u|
  u.email = 'admin2@test.cz'
  u.password = 'testtest'
  u.password_confirmation = 'testtest'
  u.confirmed_at = Time.now
end

admin.add_role :admin
