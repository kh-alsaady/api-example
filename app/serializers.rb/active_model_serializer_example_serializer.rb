class ActiveModelSerializerExampleSerializer < ActiveModel::Serializer
  attributes :id, :title, :value

  attribute :test1, key: :my_custom_label do
    'test1'
  end

  def value
    # access scope as following:
    # using scope name option
  	tested_value
    # scope
  end

end
