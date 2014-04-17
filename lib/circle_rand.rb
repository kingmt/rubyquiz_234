module CircleRand
  extend self

  def random_point radius=nil
    if radius
      [5,Kernel.rand*2*Math::PI]
    end
  end
end
