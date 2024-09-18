class Dataset
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes

    @attributes.each do |key, value|
      define_singleton_method(key) { value }
    end
  end

  # Returns true if any of the client's fields match the search query
  def matches?(query, fields = searchable_fields)
    valid_fields = fields&.select { |field| searchable_fields.include?(field) } || searchable_fields

    return false if valid_fields.empty?

    valid_fields.any? do |field|
      value = send(field)
      value.to_s.downcase.include?(query.to_s.downcase)
    end
  end

  private

  def searchable_fields
    @searchable_fields ||= attributes.keys.map(&:to_s)
  end
end
