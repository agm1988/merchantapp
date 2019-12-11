module OldTransactionsRemovalService
  def self.call
    time = Time.zone.now - 1.hour

    Transaction.where('created_at < ?', time).destroy_all
  end
end
