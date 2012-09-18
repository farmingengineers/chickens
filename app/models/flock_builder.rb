class FlockBuilder
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
    records << Flock.new(:farm => farm, :name => params[:flock][:name])
    records
  end
end
