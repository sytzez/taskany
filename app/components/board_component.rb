# frozen_string_literal: true

class BoardComponent < ViewComponent::Base
  def initialize(tasks:)
    @columns = ColumnComponent.for_all_statuses(tasks:)
  end
end
