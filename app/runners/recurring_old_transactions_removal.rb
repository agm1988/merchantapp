# frozen_string_literal: true

class RecurringOldTransactionsRemoval
  include Sidekiq::Worker

  def perform
    OldTransactionsRemovalService.call
  end
end
