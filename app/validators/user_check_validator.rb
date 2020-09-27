class UserCheckValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << '回答して欲しい人を選択してね！' if value[0].to_i == 0
  end
end
