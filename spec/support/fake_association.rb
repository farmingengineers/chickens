class FakeAssociation
  def initialize klass, attributes
    @klass = klass
    @attributes = attributes
  end

  def build attributes = {}
    @klass.new @attributes.merge(attributes)
  end
end
