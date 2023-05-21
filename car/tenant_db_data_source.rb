require 'mysql2'
require_relative '../data_sources/db_client'
require_relative '../models/car'

class CarDbDataSource
  def initialize
    @client = DBClient.instance
  end

  def add(car)
    query = "INSERT INTO car (Model, OwnerID, TenantID) VALUES ('#{car.model}', #{car.owner_id}', '#{car.tenant_id}')"
    @client.query(query)
    car_id = @client.last_id
    get(car_id)
  end

  def change(tenant)
    query = "UPDATE car SET Model='#{tenant.name}', Email=#{tenant.email.nil? ? 'NULL' : "'#{tenant.email}'"} WHERE PublisherID=#{tenant.tenant_id}"
    @client.query(query)
    get(tenant.tenant_id)
  end

  def delete(id)
    query = "DELETE FROM Tenant WHERE TenantID=#{id}"
    @client.query(query)
  end

  def get(id)
    query = "SELECT * FROM Tenant WHERE TenantID=#{id}"
    result = @client.query(query).first
    if result
      Tenant.new(result[:'TenantID'], result[:'Name'], result[:'Email'])
    else
      nil
    end
  end

  def get_list(page_size, page_num, sort_field, sort_direction, has_email = nil)
    offset = (page_num - 1) * page_size
    query = "SELECT * FROM Tenant"

    if has_email == true
      query += " WHERE Email IS NOT NULL"
    elsif has_email == false
      query += " WHERE Email IS NULL"
    end

    query += " ORDER BY #{sort_field} #{sort_direction} LIMIT #{page_size} OFFSET #{offset}"

    results = @client.query(query)
    tenants = []
    results.each do |result|
      tenants << Tenant.new(result[:'TenantID'], result[:'Name'], result[:'Email'])
    end
    tenants
  end

  def count
    query = "SELECT COUNT(*) FROM Tenant"
    result = @client.query(query).first
    result[:'COUNT(*)']
  end
end