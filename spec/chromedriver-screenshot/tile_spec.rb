require "spec_helper"

describe ChromedriverScreenshot::Tile do
  context "#screenshot" do
    subject { new_tile.screenshot }
    before(:each) do
      image_blob = Magick::Image.read("spec/support/fixtures/smiley_face.png").first.to_blob
      allow_any_instance_of(described_class).to receive(:get_screenshot).and_return(image_blob)
      allow_any_instance_of(described_class).to receive(:get_offset).and_return(offset)
    end

    context "window without offset" do
      let(:offset) { [0, 0] }

      context "full screen shot" do
        let(:new_tile) { described_class.new([0, 0], [180, 180]) }

        it "isn't cropped" do
          expected = Magick::Image.read("spec/support/fixtures/smiley_face.png").first
          expect(subject <=> expected).to be 0
        end
      end

      context "partial screenshot" do
        let(:new_tile) { described_class.new([0, 0], [120, 90]) }

        it "is cropped" do
          expected = Magick::Image.read("spec/support/fixtures/cropped_smiley_face.png").first
          expect(subject <=> expected).to be 0
        end
      end
    end

    context "window with offset" do
      let(:offset) { [20, 40] }

      context "full screenshot" do
        let(:new_tile) { described_class.new([0, 0], [160, 140]) }

        it "is cropped" do
          expected = Magick::Image.read("spec/support/fixtures/offset_smiley_face.png").first
          expect(subject <=> expected).to be 0
        end
      end

      context "partial screenshot" do
        let(:new_tile) { described_class.new([0, 0], [120, 90]) }

        it "is cropped" do
          expected = Magick::Image.read("spec/support/fixtures/offset_cropped_smiley_face.png").first
          expect(subject <=> expected).to be 0
        end
      end
    end
  end
end
