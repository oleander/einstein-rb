require "rest-client"
require "nokogiri"
require "prowl"
require "einstein/container"
require "date"
require "rtesseract"
require "nokogiri"
require "digest/md5"
require "titleize"

module Einstein  
  class Menu
    #
    # @whenever Symbol Day of the week
    #
    def initialize(whenever)
      @whenever = whenever
    end
    
    #
    # @return Einstein::Container
    #
    def dishes
      cached_dishes
    end
    
    private
      def cached_dishes
        @_cached_dishes ||= lambda {
          return nil unless image

          if @whenever == :today
            @whenever = Date.today.strftime("%A")
          end

          url = File.join("http://www.butlercatering.se", image.attr("src"))
          tmpfile = File.join(Dir.mktmpdir, Digest::MD5.hexdigest(Time.now.to_f.to_s))
          File.open(tmpfile, 'w') {|f| f.write(RestClient.get(url)) }
          text = RTesseract.new(tmpfile).to_s

          text.split("\n").
            select{ |row| row.match(/^- /) }.
            map { |row| row.gsub(/^- /, "") }.
            each_slice(3).each_with_index do |dishes, i|
              if days[i].match(/#{@whenever.to_s}/i)
                return Einstein::Container.new(dishes, days[i])
              end
            end

          return Einstein::Container.new([], @whenever)
        }.call
      end

      def image
        @_image ||= lambda {
          raw = RestClient.get("http://www.butlercatering.se/Lunchmeny")
          image = Nokogiri::HTML(raw).
            css("span img").select{ |img| img.attr("src").match(/uploads/) }.first
        }.call
      end
      
      def days
        %w{
          Monday
          Tuesday
          Wednesday
          Thursday
          Friday
          Saturday
          Sunday
        }
      end
  end
end