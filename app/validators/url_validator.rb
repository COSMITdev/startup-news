class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "must be a valid URL") unless url_valid?(value)
  end

  private

  def url_valid?(url)
    parsed_url = URI.parse(url) rescue false
    url && url.match(/\Ahttps?:\/\//) && parsed_url.kind_of?(URI::HTTP)
  end
end
