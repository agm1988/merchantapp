# frozen_string_literal: true

RSpec::Matchers.define :expose do |expected|
  match do |entity_class|
    @actual = entity_class.root_exposure.nested_exposures.map(&:key)
    expect(@actual).to include(*Array(expected))
  end

  diffable
end
