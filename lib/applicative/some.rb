# frozen_string_literal: true

module Applicative
  class Some
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def some?
      true
    end

    def none?
      false
    end
  end
end
