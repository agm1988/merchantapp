# frozen_string_literal: true

module Applicative
  class None
    attr_reader :value

    def initialize(value)
      @value = value || nil
    end

    def some?
      false
    end

    def none?
      true
    end
  end
end
