module EinsteinContainer
  class Container < Array
    def initialize(*values, whenever)
      @whenever = whenever
      super(*values)
    end
    
    def push_to(api_key)
      Prowl.add({
        apikey:       api_key,
        application:  "Einstein ",
        event:        " #{@whenever.to_s.titleize}'s menu",
        description:  self.join(", ")
      })
    end
  end
end