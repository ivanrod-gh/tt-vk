require 'rails_helper'

describe 'Answers API', type: :request do
  describe 'POST /api/v1/students/' do

    context 'successful' do
      let(:klass) { create(:klass) }

      before do
        post "/api/v1/students/",
        params: { 
          student: {
            klass_id: klass.id,
            first_name: 'имя',
            last_name: 'фамилия',
            sur_name: 'отчество'
          }
        }
      end

      it 'returns 201 status' do
        expect(response.status).to eq 201
      end

      it 'create a student' do
        expect(Student.count).to eq 1
        expect(Student.first.klass_id).to eq klass.id
        expect(Student.first.first_name).to eq 'имя'
        expect(Student.first.last_name).to eq 'фамилия'
        expect(Student.first.sur_name).to eq 'отчество'
      end

      it 'return all public fields' do
        %w[id klass_id first_name last_name sur_name].each do |attr|
          expect(json[attr]).to eq Student.first.send(attr).as_json
        end
      end

      it 'return security token in X-Auth-Token header' do
        token = BCrypt::Engine.hash_secret(Student.first.id, response.headers['X-Auth-Token'].first(29))
        expect(response.headers['X-Auth-Token']).to eq token
      end
    end

    context 'invalid input' do
      before { post "/api/v1/students/" }

      it 'returns 405 status' do
        expect(response.status).to eq 405
      end

      it 'does not create a student' do
        expect(Student.count).to eq 0
      end
    end
  end
end

        