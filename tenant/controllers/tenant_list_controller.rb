# frozen_string_literal: true

require './state_holders/list_state_notifier'
require_relative '../ui/tenant_input_form'
require_relative 'tenant_input_form_controller_create'
require_relative 'tenant_input_form_controller_edit'
require_relative '../tenant_db_data_source'
require 'win32api'

# Класс TenantListController отвечает за управление списком
# авторов, используя различные методы для обновления данных и
# взаимодействия с пользовательским интерфейсом.
class TenantListController

  attr_reader :state_notifier

  def initialize(view)
    LoggerHolder.instance.debug('TenantListController: initialize')
    @view = view
    @state_notifier = ListStateNotifier.new
    @state_notifier.add_listener(@view)
    @tenant_rep = TenantDbDataSource.new

    @sort_columns = %w[TenantID FirstName LastName Phone]
    @sort_by = @sort_columns.first

    @phone_filter_columns = [nil, true, false]
    @phone_filter = @phone_filter_columns.first
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
    LoggerHolder.instance.debug('TenantListController: show_modal_add')
    controller = TenantInputFormControllerCreate.new(self)
    view = TenantInputForm.new(controller)
    controller.set_view(view)
    view.create.show
  end

  # метод, который создает контроллер TenantInputFormControllerEdit, представление OwnerInputForm, устанавливает связи между ними и показывает модальное окно.
  def show_modal_edit(current_page, per_page, selected_row)
      LoggerHolder.instance.debug('TenantListController: show_modal_edit')
    # item_num = (current_page - 1) * per_page + selected_row

    item = @state_notifier.get(selected_row)

    controller = TenantInputFormControllerEdit.new(self, item)
    view = TenantInputForm.new(controller)
    controller.set_view(view)
    view.create.show
  end

  # метод, который получает выбранный элемент из state_notifier, удаляет его из базы данных и из state_notifier
  def delete_selected(current_page, per_page, selected_row)
    LoggerHolder.instance.debug('TenantListController: delete_selected')
    begin
      item = @state_notifier.get(selected_row)
      @tenant_rep.delete(item.tenant_id)
      @state_notifier.delete(item)
    rescue
      api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
      api.call(0, "You cannot delete the tenant because he is associated with some car", "Error", 0)
    end
  end

  # етод, который получает список авторов из базы данных, устанавливает их в state_notifier и обновляет пользовательский интерфейс
  def refresh_data(page, per_page)
    # begin
    #   @data_list = @student_rep.paginated_short_students(page, per_page, @data_list)
    #   @view.update_student_count(@student_rep.student_count)
    # rescue
    #   on_db_conn_error
    # end
    items = @tenant_rep.get_list(per_page, page, @sort_by, 'ASC', @phone_filter)
    @state_notifier.set_all(items)
    @view.update_count(@tenant_rep.count)
  end

  def sort(page, per_page, sort_index)
    @sort_by = @sort_columns[sort_index]
    refresh_data(page, per_page)
  end

  def filter_phone(page, per_page, filter_index)
    @phone_filter = @phone_filter_columns[filter_index]
    refresh_data(page, per_page)
  end

  private

  def on_db_conn_error
    api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
    api.call(0, "No connection to DB", "Error", 0)
    exit(false)
  end
end
