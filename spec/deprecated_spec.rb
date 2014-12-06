require_relative "spec_helper"

class FilmSnob
  describe Deprecated do

    class Dog
      extend Deprecated

      deprecated_alias :woof, :bark, removed_in: "v4.0.0"

      def bark
        "bark"
      end
    end

    let(:milo) { Dog.new }

    describe "deprecated_alias" do
      it "does not interfere with the current method" do
        expect(Kernel).to_not receive(:warn)
        milo.bark
      end

      it "creates an alias" do
        expect(milo).to respond_to :woof
        expect(Kernel).to receive(:warn)
        expect(milo.woof).to eq "bark"
      end
    end
  end
end

