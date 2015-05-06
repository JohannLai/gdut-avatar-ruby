# -*- encoding : utf-8 -*-
class SearchController < ApplicationController
  layout "search"

  def index
    Rails.logger.debug(Rails.application.config.avatar_path)
  end

  def search
    sno = params[:sno]
    if not ApplicationHelper.is_vaild_sno sno
      render json: {"message" => "学号格式不正确", "status" => "error"} and return
    end

    if ApplicationHelper.has_avatar sno
      render json: {"imgUrl" => view_context.image_url("/assets/avatar/#{sno}.jpg"), "status" => "success"} and return
    end

    scrapy = GdutScrapy.new
    status = scrapy.scrapy({
      :sno => sno,
      :storage_path => Rails.application.config.abs_avatar_path,
      :username => Rails.application.config.gd_username,
      :password => Rails.application.config.gd_password
    })

    if not status
      render json: {"message" => "查不到相关信息", "status" => "error"} and return 
    else
      render json: {"imgUrl" => view_context.image_url("/assets/avatar/#{sno}.jpg"), "status" => "success"} and return
    end
  end
end

