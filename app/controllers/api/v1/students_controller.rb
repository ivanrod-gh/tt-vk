module Api
  module V1
    class StudentsController < Api::V1::BaseController
      def create
        student = Student.create!(student_params)

        headers(student.id)
        render json: student, serializer: StudentSerializer, status: 201
      rescue
        head :method_not_allowed
      end

      def destroy
        student = Student.find_by(id: params[:id])
        return head :bad_request if student.nil?

        return head :unauthorized if unauthorized?

        student.destroy
        head :ok
      rescue
        head :unauthorized
      end

      private

      def student_params
        params.require(:student).permit(
          :klass_id,
          :first_name,
          :last_name,
          :sur_name
        )
      end

      def headers(id)
        response.headers['X-Auth-Token'] = security_token(id)
      end

      def security_token(id)
        BCrypt::Engine.hash_secret(id, BCrypt::Engine.generate_salt)
      end

      def unauthorized?
        return true if request.headers['X-Auth-Token'].blank?

        token = BCrypt::Engine.hash_secret(params[:id], request.headers['X-Auth-Token'].first(29))
        return true if request.headers['X-Auth-Token'] != token
      end
    end
  end
end
