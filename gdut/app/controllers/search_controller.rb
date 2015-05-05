# -*- encoding : utf-8 -*-
class SearchController < ApplicationController
  layout "search"

  def index
  end

  def search
    render json: {"message" => "查不到相关信息", "status" => "error"}
  end
end

