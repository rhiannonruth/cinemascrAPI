class Movie

  attr_accessor :title, :showtimes

  def initialize(attributes = {})
    attributes.each { |k,v| send("#{k}=", v) }
  end

end
