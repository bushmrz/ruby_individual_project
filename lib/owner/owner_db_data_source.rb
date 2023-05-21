require 'mysql2'
require_relative '../lib/data_sources/db_client'

class OwnerDBDataSource
  def initialize
    @client = DBClient.instance
  end

  # добавляет нового владельца в базу данных, возвращает созданную запись.
  def add(owner)
    query = "INSERT INTO Owner (FirstName, LastName, FatherName) VALUES ('#{owner.first_name}', '#{owner.last_name}', #{owner.father_name.nil? ? 'NULL' : "'#{owner.father_name}'"})"
    @client.query(query)
    owner_id = @client.last_id
    get(owner_id)
  end

  #  изменяет данные об владельце в базе данных, возвращает измененную запись.
  def change(owner)
    query = "UPDATE Owner SET FirstName='#{owner.first_name}', LastName='#{owner.last_name}', FatherName=#{owner.father_name.nil? ? 'NULL' : "'#{owner.father_name}'"} WHERE OwnerID=#{owner.owner_id}"
    @client.query(query)
    get(owner.owner_id)
  end

  # удаляет запись о владельце из базы данных.
  def delete(id)
    query = "DELETE FROM Owner WHERE OwnerID=#{id}"
    @client.query(query)
  end

  #  возвращает запись об владельце по заданному id.
  def get(id)
    query = "SELECT * FROM Owner WHERE OwnerID=#{id}"
    result = @client.query(query).first
    if result
      Owner.new(result[:'OwnerID'], result[:'FirstName'], result[:'LastName'], result[:'FatherName'])
    else
      nil
    end
  end

  # возвращает список владельцов с учетом фильтра по наличию отчества и сортировки, позволяет задавать количество элементов на странице и номер страницы.
  def get_list(page_size, page_num, sort_field, sort_direction, has_father_name = nil)
    offset = (page_num - 1) * page_size
    query = "SELECT * FROM Owner"

    if has_father_name == true
      query += " WHERE FatherName IS NOT NULL"
    elsif has_father_name == false
      query += " WHERE FatherName IS NULL"
    end

    query += " ORDER BY #{sort_field} #{sort_direction} LIMIT #{page_size} OFFSET #{offset}"
    results = @client.query(query)

    owners = []
    results.each do |result|
      owners << Owner.new(result[:'OwnerID'], result[:'FirstName'], result[:'LastName'], result[:'FatherName'])
    end

    owners
  end

  # возвращает количество записей об владельцах в базе данных.
  def count
    query = "SELECT COUNT(*) FROM Owner"
    result = @client.query(query).first

    result[:'COUNT(*)']
  end
end