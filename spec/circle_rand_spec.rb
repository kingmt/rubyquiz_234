require 'circle_rand'
require 'ruby-standard-deviation'

describe CircleRand do
  describe '#random_point' do
    context 'when no radius specified' do
      let(:result) { CircleRand.random_point }
      subject { result }

      it { should be_nil }
      it 'returns 0,0'
    end

    context 'when given a radius of 10' do
      let(:result) { CircleRand.random_point 10 }
      subject { result }

      context 'the result' do
        it { should be_kind_of Array }
        its(:size) { should == 2 }

        context 'distance' do
          subject { result.first }
          it { should >= 0 }
          it { should <= 10 }
        end

        context 'radian' do
          subject { result.last }
          it { should >= 0 }
          it { should <= 2*Math::PI }
        end
      end

      context 'the statistical analysis' do
        let(:iterations) { 1_000_000 }
        let(:arc) { Math::PI / 50.0 }
        let(:radius) { 10.0 }
        let(:ring_slice) { radius/100 }
        let(:area_of_each_ring) { (1..100).collect do |outer|
                                    Math::PI * (
                                      (outer)**2 -
                                      ((outer-1))**2
                                      #(ring_slice*outer)**2 -
                                      #(ring_slice*(outer-1))**2
                                    )
                                  end
                                }

        context 'over iteration number of points' do
          let(:points) { points = []
                         iterations.times do |num|
                           points.push CircleRand.random_point(radius)
                         end
                         points
                       }
            let(:all_distances) { points.collect(&:first) }
            let(:all_radians) { points.collect(&:last) }

          context 'the density accross 100 sectors' do
            let(:buckets) { buckets = Array.new 100, 0
                            points.each do |dist,rad|
                                          # radians / arc
                                          # round down for zero based index
                                          index = (rad/arc).floor
                                          buckets[index] += 1
                                        end
                            buckets
                          }

            it 'normalized standard deviation be within 0.2 of 1' do
              norm_stdev = buckets.stdev / Math.sqrt(iterations/100)
              norm_stdev.should be_within(0.2).of(1)
            end
          end

          context 'the density accross 100 rings' do
            let(:buckets) { buckets = Array.new 100, 0
                            points.each do |dist,rad|
                                          # round down for zero based index
                                          index = (dist*(100/radius)).floor
                                          buckets[index] += 1
                                        end
                            buckets
                          }
            let(:points_per_area) { (0...100).collect do |index|
                                       buckets[index]/area_of_each_ring[index]
                                    end
            }

            it 'standard deviation be within 0.2 of 1' do
              buckets.stdev.should be_within(0.2).of(1)
            end
          end
        end
      end
    end
  end
end
