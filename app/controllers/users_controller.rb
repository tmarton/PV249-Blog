class UsersController < ApplicationController
  load_resource

  # GET /users
  def index
    @users = User.order('updated_at DESC').all
  end
end
