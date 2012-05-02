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
      Einstein::Menu.menu_for(:monday).should include(*@monday)
      @days.each do |day|
        Einstein::Menu.menu_for(day).count.should eq(3)
      end
    end
    
    it "should return an empty list for " do
      [:saturday, :sunday].each do |closed|
        Einstein::Menu.menu_for(closed).should be_empty
      end
    end

    it "should not contain bad data" do
      @days.each do |day|
        Einstein::Menu.menu_for(day).each do |dish|
          dish.strip.should eq(dish)
          dish.should_not be_empty
          dish.should_not match(/<|>/)
        end
      end
    end
    
    it "should be possible to pass 'today'" do
      Einstein::Menu.menu_for(:today).should include(*@today)
    end
    
    it "should only contain plain text" do
      @days.each do |day|
        Einstein::Menu.menu_for(day).each do |dish|
          dish.should_not match(/•/)
        end
      end
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
      
      Einstein::Menu.menu_for(:monday).push_to(@api_key)
    end
    
    it "should not push if #menu_for is empty" do
      Prowl.should_not_receive(:add)
      Einstein::Menu.menu_for(:sunday).push_to(@api_key)
    end
  end
end