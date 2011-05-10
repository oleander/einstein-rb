# -*- encoding : utf-8 -*-
require "spec_helper"

describe Einstein do
  use_vcr_cassette "index"
  before(:all) do
    @days = [:monday, :tuesday, :wednesday, :thursday, :friday]
  end
  
  describe "#meny_for" do
    it "should be able to return menu for monday" do
      Einstein.menu_for(:monday).should include("Ristad rostbiff med champinjoner, lök och örtsky", "Kabanoss med Gött mos, rostad lök och barbecuekräm", "Räksallad med tillbehör")
      @days.each do |day|
        Einstein.menu_for(day).count.should eq(3)
      end
      
      a_request(:get, "http://www.butlercatering.se/einstein.html").should have_been_made.times(6)
    end
    
    it "should return an empty list for " do
      [:saturday, :sunday].each do |closed|
        Einstein.menu_for(closed).should be_empty
      end
    end
    
    it "should not contain bad data" do
      @days.each do |day|
        Einstein.menu_for(day).each do |dish|
          dish.strip.should eq(dish)
          dish.should_not be_empty
          dish.should_not match(/<|>/)
        end
      end
    end
  end
  
  describe "#push_to" do
    it "should not push if #menu_for is empty" do
      
    end
  end
end