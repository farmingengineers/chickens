class FlockBuilder < FarmAssetBuilder
  protected

  def filter params
    params.slice :name
  end
end
