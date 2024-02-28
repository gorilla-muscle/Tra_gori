require 'rails_helper'

RSpec.describe TrainingRecord, type: :model do
  describe 'バリデーション' do
    let(:user) { FactoryBot.create(:user) }

    context '運動内容保存の成功' do
      it '運動内容が入力されており、且つ100文字以内であれば有効' do
        training_record = FactoryBot.build(:training_record, user: user)
        expect(training_record).to be_valid
      end
    end

    context '運動内容保存の失敗' do
      it '運動内容が空の場合だと無効' do
        content = FactoryBot.build(:training_record, user: user, sport_content: nil)
        expect(content).not_to be_valid
        expect(content.errors.full_messages).to include("Sport contentを入力してください")
      end

      it '運動内容が100文字以上の場合だと無効'do
        content = FactoryBot.build(:training_record, user: user, sport_content: 'A' * 101)
        expect(content).not_to be_valid
        expect(content.errors.full_messages).to include("Sport contentは100文字以内で入力してください")
      end
    end
  end

  describe 'アソシエーションチェック' do
    it 'userとの関連が存在するか' do
      should belong_to(:user)
    end
  end

  describe 'カスタムメソッド' do
    let(:user) { FactoryBot.create(:user) }

    context '外部プロバイダーチェック' do
      it '当日の運動記録を保持していればtrueを返す' do
        FactoryBot.create(:training_record, user: user)
        expect(TrainingRecord.check_report?(user)).to eq true
      end

      it '当日の運動記録を保持していなければfalseを返す' do
        FactoryBot.create(:training_record, user: user, start_time: 1.day.ago)
        expect(TrainingRecord.check_report?(user)).to eq false
      end
    end

    context 'OpenAIリクエストチェック' do
      it '運動内容に基づいたメッセージが生成される' do
        training_record = FactoryBot.create(:training_record, user: user)
        allow(OpenaiComplimentGenerator).to receive(:generate_compliment).with(training_record.sport_content).and_return('素晴らしいランニングです！')
        expect(training_record.generate_openai_compliment).to eq('素晴らしいランニングです！')
      end
    end
  end

end
