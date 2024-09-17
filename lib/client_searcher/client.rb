class Client
  attr_reader :id, :full_name, :email

  SEARCHABLE_FIELDS = %w[full_name email]

  def initialize(id:, full_name:, email:)
    @id = id
    @full_name = full_name
    @email = email
  end

  # Returns true if any of the client's fields match the search query
  def matches?(query, fields = SEARCHABLE_FIELDS)
    fields.any? do |field|
      value = send(field)
      value.downcase.include?(query.downcase)
    end
  end
end
