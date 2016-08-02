class ApplicationSerializer < ActiveModel::Serializer
  attributes :hello
  def hello
    'hello from application serializer'
  end
end
