module CircleRand
  extend self

  def generate_random_vector_length_v1 radius
    Math.sqrt(Kernel.rand)*radius
  end

  def generate_random_vector_length_v2 radius
    u = (rand + rand) * radius
    if u > radius
      2.0 * radius - u
    else
      u
    end
  end

  def random_point radius=nil
    if radius
      # distance
      [generate_random_vector_length_v2(radius),
       # radians
       Kernel.rand*2*Math::PI]
    end
  end
end
