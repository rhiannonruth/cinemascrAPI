class Cinema

  attr_accessor :name, :movies

  def initialize(attributes = {})
    attributes.each { |k,v| send("#{k}=", v) }
  end


end
