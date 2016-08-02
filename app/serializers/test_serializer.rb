class TestSerializer < ApplicationSerializer
  attributes :id, :title, :value


  def value
    # access scope as following
  '	tested_value'
    # scope
  end
end
