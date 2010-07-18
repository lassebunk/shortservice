require 'rubygems'
require 'simplehttp'
require 'rexml/document'

module ShortService
  API_URL = "http://shortservice.lassebunk.dk/api"
  
  class Service
    attr_accessor :key, :name
    
    # Get a list of all services
    def self.all
      @@services ||= begin
        xml = SimpleHttp.get("#{API_URL}/services?format=xml")
        doc = REXML::Document.new(xml)

        services = []

        doc.elements.each("services/service") do |service|
          key, name = service.elements["key"].text, service.elements["name"].text
          services << Service.new(key, name)
        end

        services
      end
    end
    
    # Find a service by key, e.g. "bitly"
    def self.find_by_key(key)
      all.find { |s| s.key == key }
    end
    
    def initialize(key, name)
      self.key, self.name = key, name
    end
    
    # Shorten the given URL
    def shorten(url)
      xml = SimpleHttp.get("#{API_URL}/shorten?url=#{CGI::escape(url)}&service=#{key}&format=xml")
      doc = REXML::Document.new(xml)

      result = doc.elements["result"]

      if result.elements["status"].text == "ok"
        result.elements["url"].text
      else
        raise result.elements["description"].text
      end
    end
  end
end
