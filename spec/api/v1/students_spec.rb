require 'rails_helper'

describe 'Students API', type: :request do
  describe 'GET /api/v1/klasses/:klass_id/students' do
    context 'successful' do
      let(:klass) { create(:klass) }
      let!(:student_one) do
        create(:student, klass: klass, first_name: 'first_name1', last_name: 'last_name1', sur_name: 'sur_name1')
      end
      let!(:student_two) do
        create(:student, klass: klass, first_name: 'first_name2', last_name: 'last_name2', sur_name: 'sur_name2')
      end
      let!(:student_three) do
        create(:student, klass: klass, first_name: 'first_name3', last_name: 'last_name3', sur_name: 'sur_name3')
      end

      before do
        get "/api/v1/klasses/#{klass.id}/students"
      end

      it 'returns 200 status' do
        expect(response.status).to eq 200
      end

      it 'returns list of students' do
        expect(json.first['id']).to eq student_one.id
        expect(json.second['id']).to eq student_two.id
        expect(json.third['id']).to eq student_three.id
        expect(json.first['first_name']).to eq student_one.first_name
        expect(json.second['first_name']).to eq student_two.first_name
        expect(json.third['first_name']).to eq student_three.first_name
        expect(json.first['last_name']).to eq student_one.last_name
        expect(json.second['last_name']).to eq student_two.last_name
        expect(json.third['last_name']).to eq student_three.last_name
        expect(json.first['sur_name']).to eq student_one.sur_name
        expect(json.second['sur_name']).to eq student_two.sur_name
        expect(json.third['sur_name']).to eq student_three.sur_name
      end
    end
  end

  describe 'POST /api/v1/students/' do
    context 'successful' do
      let(:klass) { create(:klass) }

      before do
        post "/api/v1/students/",
        params: { 
          klass_id: klass.id,
          first_name: 'имя',
          last_name: 'фамилия',
          sur_name: 'отчество'
        },
        as: :json
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

  describe 'DELETE /api/v1/students/:id' do
    context 'successful' do
      let(:student) { create(:student) }

      before do
        delete "/api/v1/students/#{student.id}",
        headers: { "X-Auth-Token" => BCrypt::Engine.hash_secret(student.id, BCrypt::Engine.generate_salt).to_s }
      end

      it 'returns 200 status' do
        expect(response.status).to eq 200
      end

      it 'delete a student' do
        expect(Student.count).to eq 0
      end
    end

    context 'invalid student id' do
      let(:student) { create(:student) }

      before do
        delete "/api/v1/students/0",
        headers: { "X-Auth-Token" => BCrypt::Engine.hash_secret(student.id, BCrypt::Engine.generate_salt).to_s }
      end

      it 'returns 400 status' do
        expect(response.status).to eq 400
      end

      it 'does not delete a student' do
        expect(Student.count).to eq 1
      end
    end

    context 'invalid authorization' do
      let!(:student) { create(:student) }

      before do
        delete "/api/v1/students/#{student.id}",
        headers: { "X-Auth-Token" => '12345' }
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end

      it 'does not delete a student' do
        expect(Student.count).to eq 1
      end
    end
  end
end
