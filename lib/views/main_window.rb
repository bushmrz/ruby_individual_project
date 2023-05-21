require 'glimmer-dsl-libui'
require_relative 'tab_students'
require './owner/ui/owner_list_view'
require './tenant/ui/tenant_list_view'

class MainWindow
  include Glimmer

  def initialize
    @view_tab_students = TabStudentsView.new
  end

  def create
    window('Каршеринг', 1000, 600) {
      tab {
        tab_item('Владельцы') {
          OwnerListView.new.create
        }
        tab_item('Арендаторы') {
          TenantListView.new.create
        }
      }
    }
  end
end
