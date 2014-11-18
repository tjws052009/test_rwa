require 'mysql2'
require 'singleton'

# main db connection class
class DBConnect
  include Singleton

  def self.setup(opts = {})
    @@connect = Mysql2::Client.new(opts)
  end
end

# base model class
class CollectionJSON
  @@db = DBConnect.setup($config['db']['default'])
  def initialize(opts = {})
    @collection = {
      collection: {
        version: opts[:version] || '1.0',
        href: ''
      }
    }
  end

  def item(resource)
    @collection[:items] = [] unless @collection.has_key(:items)
    @collection << resource
  end

  def model_name
    return @model_name if @model_name
    @model_name = self.class.name.downcase
  end
end
