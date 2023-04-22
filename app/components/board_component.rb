# frozen_string_literal: true

class BoardComponent < ViewComponent::Base
  def initialize(tasks:)
    super

    @columns = ColumnComponent.for_all_statuses(tasks:)
  end
end
