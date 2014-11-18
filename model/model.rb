require 'mysql2'
require 'singleton'
require 'active_support/inflector'

# main db connection class
class DBConnect
  include Singleton

  def self.setup(opts = {})
    @@connect = Mysql2::Client.new(opts)
  end
end

# base model class
class CollectionJSON
  @@base_domain = 'http://localhost'

  def initialize(opts = {})
    @collection = {
      collection: {
        version: opts[:version] || '1.0',
        href: "#{@@base_domain}/#{@model_name}"
      }
    }
  end

  def all
    @collection[:collection][:href] = "#{@@base_domain}/#{@model_name}"
    result = @@db.query("SELECT * FROM #{model_name}")
    result.each do |r|
      self.item(format_resource(r))
    end

    @collection
  end

  def item(resource)
    @collection[:collection][:items] = [] unless @collection[:collection].has_key?(:items)
    @collection[:collection][:items] << resource
  end

  # format resource into collection+json format
  def format_resource(resource)
    result = {}
    result[:href] = "#{@@base_domain}/#{model_name}/#{resource['id']}"
    result[:links] = []
    result[:data] = []
    resource.each do |k, v|
      result[:data] << {name: k.to_sym, value: v}
    end

    result
  end

  # setup class db connection
  def self.setup_connection(opts = {})
    @@db = DBConnect.setup(opts)
  end

  def self.base_domain=(domain)
    @@base_domain = domain
  end

  private
  def model_name
    return @model_name if @model_name
    @model_name = self.class.name.pluralize.downcase
  end
end
