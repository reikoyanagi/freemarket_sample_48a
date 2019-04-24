require 'rails_helper'

describe Item do
  describe '#create' do
    it "バリデーションが正常に動くか" do
      item = build(:item)
      expect(item).to be_valid
    end
  end
end

