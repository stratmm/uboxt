require 'github/client'

class Api::GithubUsersController < ApplicationController

  respond_to :json

  def show
    client = GitHub::Client.new(params[:id])
    language_count = client.language_count
    respond_with language_count
  end
end
