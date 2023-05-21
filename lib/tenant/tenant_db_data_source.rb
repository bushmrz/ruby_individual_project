require 'mysql2'
require_relative '../data_sources/db_client'

# выполняет роль адаптера между приложением и базой данных
class TenantDbDataSource
  def initialize
    @client = DBClient.instance
  end

  # добавляет нового арендатора в базу данных, возвращает созданную запись.
  def add(tenant)
    query = "INSERT INTO Tenant (FirstName, LastName, FatherName) VALUES ('#{tenant.first_name}', '#{tenant.last_name}', #{tenant.phone.nil? ? 'NULL' : "'#{tenant.phone}'"})"
    @client.query(query)
    tenant_id = @client.last_id
    get(tenant_id)
  end

  #  изменяет данные об арендаторе в базе данных, возвращает измененную запись.
  def change(tenant)
    query = "UPDATE Tenant SET FirstName='#{tenant.first_name}', LastName='#{tenant.last_name}', Phone=#{tenant.phone.nil? ? 'NULL' : "'#{tenant.phone}'"} WHERE tenantID=#{tenant.tenant_id}"
    @client.query(query)
    get(tenant.tenant_id)
  end

  # удаляет запись об арендаторе из базы данных.
  def delete(id)
    query = "DELETE FROM Tenant WHERE tenantID=#{id}"
    @client.query(query)
  end

  #  возвращает запись об арендаторе по заданному id.
  def get(id)
    query = "SELECT * FROM Tenant WHERE tenantID=#{id}"
    result = @client.query(query).first
    if result
      Tenant.new(result[:'TenantID'], result[:'FirstName'], result[:'LastName'], result[:'Phone'])
    else
      nil
    end
  end

  # возвращает список арендаторов с учетом фильтра по наличию отчества и сортировки, позволяет задавать количество элементов на странице и номер страницы.
  def get_list(page_size, page_num, sort_field, sort_direction, has_phone = nil)
    offset = (page_num - 1) * page_size
    query = "SELECT * FROM Tenant"

    if has_phone == true
      query += " WHERE Phone IS NOT NULL"
    elsif has_phone == false
      query += " WHERE Phone IS NULL"
    end

    query += " ORDER BY #{sort_field} #{sort_direction} LIMIT #{page_size} OFFSET #{offset}"
    results = @client.query(query)

    tenants = []
    results.each do |result|
      tenants << Tenant.new(result[:'TenantID'], result[:'FirstName'], result[:'LastName'], result[:'Phone'])
    end

    tenants
  end

  # возвращает количество записей об арендаторах в базе данных.
  def count
    query = "SELECT COUNT(*) FROM Tenant"
    result = @client.query(query).first

    result[:'COUNT(*)']
  end
end