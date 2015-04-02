require 'rails_helper'

describe ApplicationHelper do
  describe "#row_and_col_for(n)" do
    it "returns [1, 1] if n = 0" do
      expect(helper.row_and_col_for(0)).to match_array [[1, 1]]
    end

    it "returns [1, 2] if n = 1" do
      expect(helper.row_and_col_for(1)).to match_array [[1, 2]]
    end

    it "returns [2, 2] if n = 2" do
      expect(helper.row_and_col_for(2)).to match_array [[2, 2]]
    end

    it "returns [2, 2] if n = 3" do
      expect(helper.row_and_col_for(3)).to match_array [[2, 2]]
    end

    it "returns [2, 3] if n = 5" do
      expect(helper.row_and_col_for(5)).to match_array [[2, 3]]
    end

    it "returns [3, 3] if n = 8" do
      expect(helper.row_and_col_for(8)).to match_array [[3, 3]]
    end

    it "returns [4, 4] if n = 13" do
      expect(helper.row_and_col_for(13)).to match_array [[4, 4]]
    end

    it "returns [5, 5] if n = 21" do
      expect(helper.row_and_col_for(21)).to match_array [[5, 5]]
    end

    it "returns [6, 6] if n = 34" do
      expect(helper.row_and_col_for(34)).to match_array [[6, 6]]
    end
  end
end