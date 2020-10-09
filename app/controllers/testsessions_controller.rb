class TestsessionsController < ApplicationController
  def create
    user = User.find_by(email: 'test_user@test.com')
    sign_in user
    redirect_to root_path
  end
end
