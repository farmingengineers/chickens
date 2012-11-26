module Report
  module Base
    extend ActiveSupport::Concern

    module ClassMethods
      def human_name name = nil
        @human_name = name if name
        @human_name || self.name.demodulize
      end

      def id
        self.name.demodulize.underscore
      end

      def generate params
        new params
      end
    end

    def initialize params
      @params = params
    end

    def human_name
      self.class.human_name
    end

    protected

    attr_reader :params

    def user
      params[:current_user]
    end
  end
end
