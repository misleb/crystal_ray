require "./overloads"
require "./vec3"
require "./ray"

def ray_color(r : Ray) : Color
  t = hit_sphere(Point3.new(0,0,-1), 0.5, r);

  if t > 0
    n = (r.at(t) - Vec3.new(0,0,-1)).unit_vector
    return 0.5*Color.new(n.x+1, n.y+1, n.z+1)
  end

  unit_direction = r.direction.unit_vector
  t = 0.5 * (unit_direction.y + 1.0)
  (1.0-t)*Color.new(1.0, 1.0, 1.0) + t*Color.new(0.5, 0.7, 1.0)
end

def hit_sphere(center : Point3, radius : Float64, r : Ray) : Float64
  oc = r.origin - center
  a = r.direction.length_squared
  half_b = oc.dot(r.direction)
  c = oc.length_squared - radius*radius
  discriminant = half_b*half_b - a*c

  discriminant < 0 ? -1.0 : (-half_b - Math.sqrt(discriminant) ) / a
end

# Image
aspect_ratio = 16.0 / 9.0;
image_width = 400;
image_height = (image_width / aspect_ratio).to_i

# Camera
viewport_height = 2.0
viewport_width = aspect_ratio * viewport_height
focal_length = 1.0

origin = Point3.new(0, 0, 0)
horizontal = Vec3.new(viewport_width, 0, 0)
vertical = Vec3.new(0, viewport_height, 0)
lower_left_corner = origin - horizontal/2.0 - vertical/2.0 - Vec3.new(0, 0, focal_length)

puts "P3\n#{image_width} #{image_height}\n255\n"

(0..image_height-1).reverse_each do |j|
  STDERR.print "Scanlines remaining: #{j}   \r"
  image_width.times do |i|
    u = i.to_f / (image_width-1)
    v = j.to_f / (image_height-1)
    r = Ray.new(origin, lower_left_corner + u*horizontal + v*vertical - origin)

    puts ray_color(r) * 255.999
  end
end

STDERR.puts "\nDone!"
