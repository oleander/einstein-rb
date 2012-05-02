module Einstein
  class Container < Array
    #
    # @values Array<?> A list of items
    # @whenever Symbol Any day of the week
    #
    def initialize(*values, whenever)
      @whenever = whenever
      super(*values)
    end
    
    #
    # @api_key String API key for Prowl
    #
    def push_to(api_key)
      Prowl.add({
        apikey:       api_key,
        application:  "Einstein ",
        event:        " #{@whenever.to_s.titleize}'s menu",
        description:  self.join(", ")
      }) unless self.empty?
    end
  end
end