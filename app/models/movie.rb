class Movie 
  attr_accessor :name, :showtimes

  def initialize(attributes = {})
    attributes.each { |k,v| send("#{k}=", v) }
  end

end
