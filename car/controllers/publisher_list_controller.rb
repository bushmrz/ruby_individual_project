# frozen_string_literal: true

require './lib/state_holders/list_state_notifier'
require_relative '../ui/tenant_input_form'
require_relative 'publisher_input_form_controller_create.rb'
require_relative 'publisher_input_form_controller_edit'
require_relative '../tenant_db_data_source'
require 'win32api'

class OwnerListController

  attr_reader :state_notifier
  def initialize(view)
    @view = view
    @state_notifier = ListStateNotifier.new
    @state_notifier.add_listener(@view)
    @publisher_rep = OwnerDbDataSource.new

    @sort_columns = %w[PublisherID Name Email]
    @sort_by = @sort_columns.first

    @email_filter_columns = [nil, true, false]
    @email_filter = @email_filter_columns.first
  end



  def on_view_created
    # begin
    #   @student_rep = StudentRepository.new(DBSourceAdapter.new)
    # rescue Mysql2::Error::ConnectionError
    #   on_db_conn_error
    # end
  end

  def show_view
    @view.create.show
  end

  def show_modal_add
    controller = OwnerInputFormControllerCreate.new(self)
    view = OwnerInputForm.new(controller)
    controller.set_view(view)
    view.create.show
  end

  def show_modal_edit(current_page, per_page, selected_row)
    # item_num = (current_page - 1) * per_page + selected_row

    item = @state_notifier.get(selected_row)

    controller = OwnerInputFormControllerEdit.new(self, item)
    view = OwnerInputForm.new(controller)
    controller.set_view(view)
    view.create.show
  end

  def delete_selected(current_page, per_page, selected_row)
    begin
      item = @state_notifier.get(selected_row)
      @publisher_rep.delete(item.publisher_id)
      @state_notifier.delete(item)
    rescue
      api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
      api.call(0, "You cannot delete the author because he is associated with some book", "Error", 0)
    end
  end

  def refresh_data(page, per_page)
    # begin
    #   @data_list = @student_rep.paginated_short_students(page, per_page, @data_list)
    #   @view.update_student_count(@student_rep.student_count)
    # rescue
    #   on_db_conn_error
    # end
    items = @publisher_rep.get_list(per_page, page, @sort_by, 'ASC', @email_filter)
    @state_notifier.set_all(items)
    @view.update_count(@publisher_rep.count)
  end

  def sort(page, per_page, sort_index)
    @sort_by = @sort_columns[sort_index]
    refresh_data(page, per_page)
  end

  def filter_email(page, per_page, filter_index)
    @email_filter = @email_filter_columns[filter_index]
    refresh_data(page, per_page)
  end


  private

  def on_db_conn_error
    api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
    api.call(0, "No connection to DB", "Error", 0)
    exit(false)
  end
end
