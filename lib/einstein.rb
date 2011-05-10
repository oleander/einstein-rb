# -*- encoding : utf-8 -*-
require "rest-client"
require "nokogiri"
require "prowl"
require "einstein/container"
require "titleize"

class Einstein
  include EinsteinContainer
  
  def self.method_missing(meth, *args, &blk)
    Einstein.new.send(meth, *args, &blk)
  end
  
  def menu_for(whenever)
    data = content.css("td.bg_lunchmeny p").to_a[1..-2].map do |p| 
      list = p.content.split("\r\n")
      {list[0].gsub(/"|:|\s+/, "") => list[1..-1].map { |item| item.gsub(/• /, "").strip }}
    end.inject({}) { |a, b| a.merge(b)}
    
    if whenever == :today
      data = data[days[days.keys[Date.today.wday]]] || []
    else
      data = data[days[whenever]] || []
    end
    
    Container.new(data, whenever)
  end
  
  private
    def content
      @_content ||= Nokogiri::HTML(download)
    end
    
    def download
      @_download ||= RestClient.get("http://www.butlercatering.se/einstein.html", timeout: 10)
    end
    
    def days
      @_days ||= {
        sunday:    "Sön",
        monday:    "Mån",
        tuesday:   "Tis",
        wednesday: "Ons",
        thursday:  "Tors",
        friday:    "Fre",
        saturday:  "Lör"
      }
    end
end
