require 'mysql2'
require_relative 'db_client'
class CarDbDataSource
  def initialize
    @client = DBClient.instance
  end

  def add(car)
    query = "INSERT INTO Car (CarID, Model, OwnerID, TenantID) VALUES (#{car.id}, '#{car.title}', #{car.owner_id}, #{car.tenant_id})"
    @client.query(query)
  end

  def change(car)
    query = "UPDATE Car SET Title='#{car.title}', OwnerID=#{car.owner_id}, TenantID=#{car.tenant_id} WHERE CarID=#{car.id}"
    @client.query(query)
  end

  def delete(id)
    query = "DELETE FROM Car WHERE CarID=#{id}"
    @client.query(query)
  end

  def get(id)
    query = "SELECT * FROM Car WHERE CarID=#{id}"
    result = @client.query(query).first
    if result
      Car.new(result['CarID'], result['Model'], result['OwnerID'], result['TenantID'])
    else
      nil
    end
  end

  def get_list(page_size, page_num, sort_field, sort_direction)
    offset = (page_num - 1) * page_size
    query = "SELECT * FROM Car ORDER BY #{sort_field} #{sort_direction} LIMIT #{page_size} OFFSET #{offset}"
    results = @client.query(query)
    cars = []
    results.each do |result|
      cars << Car.new(result['CarID'], result['Model'], result['OwnerID'], result['TenantID'])
    end
    cars
  end
end