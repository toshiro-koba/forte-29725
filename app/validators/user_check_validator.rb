class UserCheckValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value[0].to_i == 0
      record.errors[attribute] << "回答して欲しい人を選択してね！"
    end
  end
end