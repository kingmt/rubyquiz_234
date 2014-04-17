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
        let(:arc) { Math::PI / 50.0 }

        context 'over 100 points' do
          let(:points) { points = []
                         100.times {|num| points.push CircleRand.random_point(10)}
                         points
                       }
            let(:all_distances) { points.collect(&:first) }
            let(:distance_average) { all_distances.inject(:+) / all_distances.size }
            let(:all_radians) { points.collect(&:last) }
            let(:randian_average) { all_radians.inject(:+) / all_radians.size }

          context 'the distance' do

            it 'should average 5' do
              average.should be_within(0.5).of(5.0)
            end
          end

          context 'the radians' do

            it 'should average 5' do
              average.should be_within(0.5).of(Math::PI)
            end
          end

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
            let(:average) { buckets.inject(:+) / buckets.size }

            it 'standard deviation be within 0.2 of 1' do
              buckets.stdev.should be_within(0.2).of(1)
            end
          end
        end
      end
    end
  end
end
