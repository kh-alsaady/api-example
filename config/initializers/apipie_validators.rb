class IntegerValidator < Apipie::Validator::BaseValidator

  def initialize(param_description, argument)
    super(param_description)
    @type = argument
  end

  def validate(value)
    return false if value.nil?
    !!(value.to_s =~ /^[-+]?[0-9]+$/)
  end

  def self.build(param_description, argument, options, block)
    if argument == Integer || argument == Fixnum
      self.new(param_description, argument)
    end
  end

  def description
    I18n.t 'integer_desc'
  end

end

class FloatValidator < Apipie::Validator::BaseValidator

  def initialize(param_description, argument)
    super(param_description)
    @type = argument
  end

  def validate(value)
    return false if value.nil?
    !!(value.to_s =~ /^[-+]?[0-9]+[.][0-9]+$/)
  end

  def self.build(param_description, argument, options, block)
    if argument == Float
      self.new(param_description, argument)
    end
  end

  def description
    I18n.t 'float_desc'
  end

end


#class RegexpValidator < Apipie::Validator::BaseValidator
#
#  def initialize(param_description, argument)
#    super(param_description)
#    @regexp = argument
#  end
#
#  def validate(value)
#    value =~ @regexp
#  end
#
#  def self.build(param_description, argument, options, proc)
#    self.new(param_description, argument) if argument.is_a? Regexp
#  end
#
#  def description
#    I18n.t 'regexp_desc'
#  end
#
#end


#class StringValidator < Apipie::Validator::BaseValidator
#
#    def initialize(param_description, argument)
#      super(param_description)
#      @type = argument
#    end
#
#    def validate(value)
#      return false if value.nil?
#      !!(value.to_s =~ /.*\S.*/) # This will allow anything else than empty string
#    end
#
#    def self.build(param_description, argument, options, block)
#      if argument == String && options[:required] == true
#        self.new(param_description, argument)
#      end
#    end
#
#    def description
#      I18n.t 'required_field'
#    end
#
#end