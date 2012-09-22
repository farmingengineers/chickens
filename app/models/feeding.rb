class Feeding < DataPoint
  def pounds
    quantity
  end

  def to_s
    "#{occurred_on.to_date.to_s} fed #{pounds} pounds"
  end
end
