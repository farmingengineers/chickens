class FeedTypesController < ApplicationController
  before_filter :authenticate_user!

  expose(:feed_types) { current_user.feed_types }
  expose(:feed_type, :new => :build_feed_type, :index => :build_feed_type)

  def update
    feed_type.save!
    redirect_to information_path
  end

  protected

  def after_create_path
    information_path
  end

  def record_builder
    FeedTypeBuilder.new current_user
  end

  def build_feed_type
    create_records.detect { |r| r.is_a? FeedType }
  end
end
