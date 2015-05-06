require 'mechanize'

class GdutScrapy
  attr_accessor :random

  def scrapy params = {}
    @sno = params[:sno]
    @storage_path = params[:storage_path]
    @random = get_random params[:username], params[:password]
    @agent = Mechanize.new

    return storage_img
  end

  def storage_img
    year = @sno[2..3]
    img_path = "http://gdut.eswis.cn/upfiles/#{@random}/userpic/20#{year}/#{@sno}.jpg"
    begin
      img = @agent.get(img_path)
    rescue Exception
      return false
    else
      img.save @storage_path.to_s + "/#{@sno}.jpg"
    end
  end

  def get_random username, password
    # 登陆
    begin login = GdutLogin.new(username, password) end while not login

    return parse_random login.result
  end

  def parse_random html
    result = /upfiles\/(\d*)/.match(html)
    return result[1]
  end
end
