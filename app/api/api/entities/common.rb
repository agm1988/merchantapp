# frozen_string_literal: true

module Api
  module Entities
    module Common
      extend ActiveSupport::Concern

      included do
        format_with(:iso_timestamp, &:iso8601)
      end
    end
  end
end
