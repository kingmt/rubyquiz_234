require 'circle_rand'

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
        context 'over 1000 points' do
          let(:points) { points = []
                         100.times {|num| points.push CircleRand.random_point(10)}
                         points
                       }

          context 'the distance' do
            let(:all_distances) { points.collect(&:first) }
            let(:average) { all_distances.inject(:+) / all_distances.size }

            it 'should average 5' do
              average.should be_within(0.5).of(5.0)
            end
          end

          context 'the radians' do
            let(:all_radians) { points.collect(&:last) }
            let(:average) { all_radians.inject(:+) / all_radians.size }

            it 'should average 5' do
              average.should be_within(0.5).of(Math::PI)
            end
          end
        end
      end
    end
  end
end
