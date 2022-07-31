require "./vec3"

struct Float64
  def *(other : Vec3)
    other * self
  end
end
