class Car
  attr_reader :car_id, :model, :owner_id, :tenant_id

  def initialize(car_id, model, owner_id, tenant_id)
    validate_null('car_id', car_id)
    validate_null('model', model)
    validate_null('owner_id', owner_id)
    validate_null('tenant_id', tenant_id)

    validate_title_length(model)

    @car_id = car_id
    @model = model
    @owner_id = owner_id
    @tenant_id = tenant_id
  end

  private

  def validate_null(name, value)
    if value.nil?
      raise ArgumentError, "Argument '#{name}' cannot be null"
    end
  end

  def validate_title_length(model)
    if model.length > 255
      raise ArgumentError, "Model exceeds 255 characters limit: #{model}"
    end
  end
end