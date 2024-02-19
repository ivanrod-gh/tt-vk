require 'rails_helper'

describe 'Klasses API', type: :request do
  describe 'GET /api/v1/schools/:school_id/klasses' do

    context 'successful' do
      let(:school) { create(:school) }
      let(:first_klass) { create(:klass, school: school, number: 1, letter: 'А') }
      let(:second_klass) { create(:klass, school: school, number: 2, letter: 'Б') }
      let(:third_klass) { create(:klass, school: school, number: 3, letter: 'В') }
      let!(:students_of_klass_one) { create_list(:student, 5, klass: first_klass) }
      let!(:students_of_klass_two) { create_list(:student, 10, klass: second_klass) }
      let!(:students_of_klass_three) { create_list(:student, 15, klass: third_klass) }

      before do
        get "/api/v1/schools/#{school.id}/klasses"
      end

      it 'returns 200 status' do
        expect(response.status).to eq 200
      end

      it 'returns list of classes' do
        expect(json.count).to eq 3
        expect(json.first['number']).to eq 1
        expect(json.second['number']).to eq 2
        expect(json.third['number']).to eq 3
        expect(json.first['letter']).to eq 'А'
        expect(json.second['letter']).to eq 'Б'
        expect(json.third['letter']).to eq 'В'
        expect(json.first['students_count']).to eq 5
        expect(json.second['students_count']).to eq 10
        expect(json.third['students_count']).to eq 15
      end
    end
  end
end
