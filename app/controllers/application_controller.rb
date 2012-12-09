class ApplicationController < ActionController::Base
  protect_from_forgery

  def create
    ActiveRecord::Base.transaction do
      create_records.each { |record| record.save! }
    end
    redirect_to after_create_path
  end

  def update
    ActiveRecord::Base.transaction do
      update_records.each { |record| record.save! }
    end
    redirect_to after_update_path
  end

  protected

  def self.expose(name, alternates = {})
    super(name)
    if alternates.any?
      alternates = alternates.stringify_keys
      alias_method "decent_#{name}", name
      define_method name do
        send(alternates[action_name] || "decent_#{name}")
      end
    end
  end

  def create_records
    record_builder.build params
  end

  def after_create_path
    root_path
  end

  def update_records
    record_updater.update params
  end

  def after_update_path
    root_path
  end
end
