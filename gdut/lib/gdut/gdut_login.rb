require 'mechanize'
require 'logger'

class GdutLogin
  attr_accessor :result, :agent

  def initialize username, password
    @agent = Mechanize.new do |agent|
      #agent.log = Logger.new(STDOUT)
    end
    @username = username
    @password = password
    @login_url = "http://gdut.eswis.cn/default.aspx"
    @result = login
  end

  def login 
    begin
      login_page = @agent.get @login_url
      login_page.encoding = "utf-8"
      form = login_page.form
      form.field_with(:name => "ctl00$dft_page$log_username").value = @username
      form.field_with(:name => "ctl00$dft_page$log_password").value = @password
      form.add_field!("ctl00$dft_page$logon", value=nil)
      result = form.submit
    rescue Errno::ETIMEDOUT
      return false
    else
      return result.body
    end
  end
end
