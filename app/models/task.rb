class Task < ApplicationRecord
    # taskモデルがUserモデルに対して、1対1の関連性を示すコード
  belongs_to :user
end
