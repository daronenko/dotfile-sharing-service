# frozen_string_literal: true

# Controller for user profile page
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
end
