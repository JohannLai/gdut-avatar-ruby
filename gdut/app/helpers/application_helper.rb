module ApplicationHelper

  def self.is_vaild_sno sno

    return false unless sno.length == 10
    sex = sno[0..1]
    return false unless (sex == '31' or sex == '32')
    year = sno[2..3].to_i
    return false unless year.between?(10, 15)
    order_pre = sno[4..5]
    return false unless (order_pre == '00' or order_pre == '01')
    order = sno[6..-1].to_i
    return false unless order.between?(0, 10000)

    return true
  end
  
  def self.has_avatar sno
    path = Rails.application.config.abs_avatar_path + "/#{sno}.jpg"
    return File.exist?(path)
  end
end
