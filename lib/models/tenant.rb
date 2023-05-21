class Tenant
  PHONE_REGEX = /^\+?[78] ?[(-]?\d{3} ?[)-]?[ -]?\d{3}[ -]?\d{2}[ -]?\d{2}$/
  attr_reader :tenant_id, :first_name, :last_name, :phone

  def initialize(tenant_id, first_name, last_name, phone = nil)
    validate_null('tenant_id', tenant_id)
    validate_null('first_name', first_name)
    validate_null('last_name', last_name)

    validate_name_length(first_name, last_name)
    validate_phone(phone)

    @tenant_id = tenant_id
    @first_name = first_name
    @last_name = last_name
    @phone = phone
  end

  private

  def validate_null(name, value)
    if value.nil?
      raise ArgumentError, "Argument '#{name}' cannot be null"
    end
  end

  def validate_name_length(first_name, last_name)
    [first_name, last_name].each do |name|
      if name && name.length > 50
        raise ArgumentError, "Name exceeds 50 characters limit: #{name}"
      end
    end
  end

  def validate_phone(phone)
    if phone && !phone.match?(PHONE_REGEX)
      raise ArgumentError, "Invalid phone format: #{phone}"
    end
  end
end
