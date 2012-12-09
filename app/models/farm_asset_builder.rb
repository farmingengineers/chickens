class FarmAssetBuilder
  def initialize user
    @user = user
  end

  attr_reader :user

  def build params
    records = []
    unless farm = user.farms.first
      records << (farm = Farm.new)
      records << Farmer.new(:farm => farm, :user => user)
    end
    attrs = filter(params[klass.model_name.underscore] || {})
    records << klass.new(attrs.merge(:farm => farm))
    records
  end

  protected

  def klass
    self.class.name.sub(/Builder$/, '').constantize
  end

  def filter(params)
    params
  end
end
