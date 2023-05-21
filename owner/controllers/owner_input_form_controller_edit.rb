# frozen_string_literal: true

require 'win32api'

class OwnerInputFormControllerEdit
  def initialize(parent_controller, item)
    @parent_controller = parent_controller
    @item = item
    @owner_rep = OwnerDBDataSource.new
  end

  def set_view(view)
    @view = view
  end

  def on_view_created
    # begin
    #   @student_rep = StudentRepository.new(DBSourceAdapter.new)
    # rescue Mysql2::Error::ConnectionError
    #   on_db_conn_error
    # end

    # @item = @author_rep.get(@item_id)
    # @view.make_readonly(:git, :telegram, :email, :phone)
    populate_fields(@item)
  end

  def populate_fields(item)
    @view.set_value(:first_name, item.first_name)
    @view.set_value(:last_name, item.last_name)
    @view.set_value(:father_name, item.father_name)
  end

  def process_fields(fields)
    begin
      item = Owner.new(@item.owner_id, *fields.values)
      item = @owner_rep.change(item)
      @parent_controller.state_notifier.replace(@item, item)
      @view.close
    rescue ArgumentError => e
      api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
      api.call(0, e.message, 'Error', 0)
    end
  end

  private

  def on_db_conn_error
    api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
    api.call(0, "No connection to DB", "Error", 0)
    @view.close
  end
end
