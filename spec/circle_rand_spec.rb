require 'circle_rand'

describe CircleRand do
  describe '#random_point' do
    context 'when no radius specified' do
      let(:result) { CircleRand.random_point }
      subject { result }

      it { should be_nil }
      it 'returns 0,0'
    end

    context 'when given a radius' do
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
    end
  end
end
