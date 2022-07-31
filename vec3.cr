struct Vec3
  getter x, y, z

  def initialize(@x : Float64, @y : Float64, @z : Float64)
  end

  def -
    Vec3.new(-x, -y, -z)
  end

  def -(other : Vec3)
    Vec3.new(x - other.x, y - other.y, z - other.z)
  end

  def +(other : Vec3)
    Vec3.new(x + other.x, y + other.y, z + other.z)
  end

  def *(t : Float64)
    Vec3.new(x * t, y * t, z * t)
  end

  def /(t : Float64)
    self * (1/t)
  end

  def dot(other : Vec3) : Float64
    x*other.x + y*other.y + z*other.z
  end

  def length_squared
    x*x + y*y + z*z
  end

  def length
    Math.sqrt(length_squared)
  end

  def unit_vector
    self / length
  end

  def to_s(io)
    io << x.to_i << ' ' << y.to_i << ' ' << z.to_i
  end
end

alias Point3 = Vec3
alias Color = Vec3
