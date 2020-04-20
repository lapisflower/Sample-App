class Task < ApplicationRecord
    #並び替えてくれるコード。descは降順。書かなくてもいい？Text3.12
    # default_scope -> { order(created_at: :desc) } ???
   
    # taskモデルがUserモデルに対して、1対1の関連性を示すコード
  belongs_to :user
  
  #C10.タスクモデルのバリデーション。
  #user_id,nameの存在性と文字数を制限。
  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: {in: 5..300}
end
