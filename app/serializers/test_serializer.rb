class TestSerializer < ActiveModel::Serializer
  attributes :id, :value

  def value
  	scope[:lang_code]
  end
end
