module Api
  module V1
    class KlassesController < Api::V1::BaseController
      def index
        render json: School.find_by(id: params[:school_id]).klasses.order(:id),
               each_serializer: KlassesSerializer,
               status: 200
      end
    end
  end
end
