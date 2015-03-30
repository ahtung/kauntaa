module ApplicationHelper
  def row_and_col_for(n)
    hsh = []
    hsh[0]  = [1, 1]
    hsh[1]  = [1, 2]
    hsh[2]  = [2, 2]
    hsh[3]  = [2, 2]
    hsh[4]  = [2, 3]
    hsh[5]  = [2, 3]
    hsh[6]  = [3, 3]
    hsh[7]  = [3, 3]
    hsh[8]  = [3, 3]
    hsh[9]  = [3, 4]
    hsh[10] = [3, 4]
    hsh[11] = [3, 4]
    hsh[12] = [4, 4]
    hsh[13] = [4, 4]
    hsh[14] = [4, 4]
    [hsh[n]]
  end
end
