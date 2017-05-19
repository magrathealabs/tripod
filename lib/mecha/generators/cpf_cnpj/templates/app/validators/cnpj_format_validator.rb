class CnpjFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if CNPJ.valid?(value)
    record.errors.add(attribute, :invalid)
  end
end
