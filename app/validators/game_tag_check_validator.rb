class GameTagCheckValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << 'ゲームタイトルを選択してね！' if value[0].to_i == 0
  end
end
