module CircleRand
  extend self

  def random_point radius=nil
    if radius
      # distance
      [Math.sqrt(Kernel.rand)*radius,
       # radians
       Kernel.rand*2*Math::PI]
    end
  end
end
