require "./vec3"

struct Ray
  getter origin, direction

  def initialize(@origin : Point3, @direction : Point3)
  end

  def at(t : Float64) : Vec3
    origin + t * direction
  end
end
