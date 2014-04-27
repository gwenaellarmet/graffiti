#!/usr/bin/env ruby
class Point
  attr_accessor :x
  attr_accessor :y

  def initialize(x_p=0,y_p=0)
    @x = x_p
    @y = y_p
  end

  def to_s
    "[#{x},#{y}]"
  end

  def distPoints(p)
  	res = Math.sqrt(((p.x-x)*(p.x-x))+((p.y-y)*(p.y-y)))
  	res
  end

  def to_hash
  {
    x: x,
    y: y
  }
  end

  def equals(p)
  	if @x >= p.x-10 and @x <= p.x+10 and @y >= p.y-10 and @y <= p.y+10
  		true
  	else
  		false
  	end
  end

  def self.from_json string
    puts 'tP'
    data = JSON.load string
    self.new data['x'], data['y']
  end
end