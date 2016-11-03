RSpec.describe ChromedriverScreenshot::Page do
  context "#initialize" do
    subject { ChromedriverScreenshot::Page.new }

    before(:example) do
      platform = double("platform", page_height: 100, window_height: window_height)
      allow(ChromedriverScreenshot::Platforms).to receive(:platform).and_return(platform)
      expect(ChromedriverScreenshot::Row).to receive(:from_boundaries).with(expected_ary)
    end

    context "page height is a multiple of window height" do
      let(:window_height) { 20 }
      let(:expected_ary) { [20, 40, 60, 80, 100] }

      it "returns even boundaries" do
        subject
      end
    end

    context "page height is not a multiple of window height" do
      let(:window_height) { 30 }
      let(:expected_ary) { [30, 60, 90, 100] }

      it "returns partial boundaries" do
        subject
      end
    end

    context "page height is equal to window height" do
      let(:window_height) { 100 }
      let(:expected_ary) { [100] }

      it "returns single even boundary" do
        subject
      end
    end

    context "page height is smaller than window height" do
      let(:window_height) { 200 }
      let(:expected_ary) { [100] }

      it "returns single partial boundary" do
        subject
      end
    end
  end
end
