class GameTagCheckValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value[0].to_i == 0
      record.errors[attribute] << "ゲームタイトルを選択してね！"
    end
  end
end