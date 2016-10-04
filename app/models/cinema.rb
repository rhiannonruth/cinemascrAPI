class Cinema

  attr_accessor :name, :address, :telephone, :movies

  def initialize(attributes = {})
    attributes.each { |k,v| send("#{k}=", v) }
  end


end
