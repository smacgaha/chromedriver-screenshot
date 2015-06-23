require "spec_helper"

describe ChromedriverScreenshot::Tile do
  context "#screenshot" do
    subject { new_tile.screenshot }
    before(:each) do
      image_blob = Magick::Image.read("spec/support/fixtures/smiley_face.png").first.to_blob
      allow_any_instance_of(described_class).to receive(:get_screenshot).and_return(image_blob)
    end

    context "full screen shot" do
      let(:new_tile) { described_class.new([0, 0], [180, 180]) }

      it "isn't cropped" do
        expected = Magick::Image.read("spec/support/fixtures/smiley_face.png").first
        expect(subject <=> expected).to be 0
      end
    end

    context "partial screenshot" do
      let(:new_tile) { described_class.new([0, 0], [120, 90]) }

      it "partial screen shot is cropped" do
        expected = Magick::Image.read("spec/support/fixtures/cropped_smiley_face.png").first
        expect(subject <=> expected).to be 0
      end
    end
  end
end
