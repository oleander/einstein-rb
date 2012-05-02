# -*- encoding : utf-8 -*-

describe Einstein::Menu do
  use_vcr_cassette "request"

  before(:all) do
    @days = [:monday, :tuesday, :wednesday, :thursday, :friday]
    @api_key = "6576aa9fa3fc3e18aca8da9914a166b3"
    @monday = [
      "Fiskgraténg med potatismos", 
      "lsterband med persiljestuvad potatis", 
      "Réksallad"
    ]
    
    @today = [
      "Gremolatabakadlax med paprikakrém & kokt potatis", 
      "Helstekt ﬂéskytterﬁle med chevre-sparrisrisotto & sky", 
      "Tonﬁsksallad"
    ]
  end
  
  context "#meny_for" do
    it "should be able to return menu for monday" do
      Einstein::Menu.new(:monday).dishes.should include(*@monday)
      @days.each do |day|
        Einstein::Menu.new(day).dishes.count.should eq(3)
      end
    end
    
    it "should return an empty list for " do
      [:saturday, :sunday].each do |closed|
        Einstein::Menu.new(closed).dishes.should be_empty
      end
    end
    
    it "should be possible to pass 'today'" do
      Einstein::Menu.new(:today).dishes.should include(*@today)
    end
  end
  
  describe "#push_to" do
    it "should be able to push" do
      Prowl.should_receive(:add).with({
        apikey:       @api_key,
        application:  "Einstein ",
        event:        " Monday's menu",
        description:  @monday.join(", ")
      })
      
      Einstein::Menu.new(:monday).dishes.push_to(@api_key)
    end
    
    it "should not push if #menu_for is empty" do
      Prowl.should_not_receive(:add)
      Einstein::Menu.new(:sunday).dishes.push_to(@api_key)
    end
  end
end