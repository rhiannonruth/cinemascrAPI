class Movie

  attr_accessor :title, :length, :rating, :showtimes

  def initialize(attributes = {})
    attributes.each { |k,v| send("#{k}=", v) }
  end

end
