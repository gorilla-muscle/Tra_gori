require 'rails_helper'

RSpec.describe TrainingRecord, type: :model do
  describe 'バリデーションチェック' do
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
    it 'userとの関連が定義されているか' do
      should belong_to(:user)
    end
  end

  describe 'カスタムメソッドチェック' do
    let(:user) { FactoryBot.create(:user) }

    describe '.check_report?' do
      context '当日の運動記録を保持している場合' do
        it 'trueを返す' do
          FactoryBot.create(:training_record, user: user)
          expect(TrainingRecord.check_report?(user)).to eq true
        end
      end
      context '当日の運動記録を保持していない場合' do
        it 'falseを返す' do
          FactoryBot.create(:training_record, user: user, start_time: 1.day.ago)
          expect(TrainingRecord.check_report?(user)).to eq false
        end
      end
    end

    describe '.generate_openai_compliment' do
      it '運動内容に基づいたメッセージが生成される' do
        training_record = FactoryBot.create(:training_record, user: user)
        allow(OpenaiComplimentGenerator).to receive(:generate_compliment).with(training_record.sport_content).and_return('良い有酸素運動ですね！')
        expect(training_record.generate_openai_compliment).to eq('良い有酸素運動ですね！')
      end
    end

    describe '.openai_response_handling' do
      let(:record_params) { { sport_content: 'walking' } }
      
      it 'レコードのsport_contentが適切に設定される' do
        allow(OpenaiComplimentGenerator).to receive(:generate_compliment).and_return('Nice walking!')
        training_record = TrainingRecord.openai_response_handling(user, record_params)
        expect(training_record.sport_content).to eq('walking')
      end

      it 'レコードのbot_contentが適切に設定される' do
        allow(OpenaiComplimentGenerator).to receive(:generate_compliment).and_return('Nice walking!')
        training_record = TrainingRecord.openai_response_handling(user, record_params)
        expect(training_record.bot_content).to eq('Nice walking!')
      end

      it 'バナナ数が1増加する' do
        allow(OpenaiComplimentGenerator).to receive(:generate_compliment).and_return('Nice walking!')
        expect {TrainingRecord.openai_response_handling(user, record_params) }.to change(user.number_of_banana, :count).by(1)
      end

      it 'TrainingRecordレコードが問題なく作成されている' do
        allow(OpenaiComplimentGenerator).to receive(:generate_compliment).and_return('Nice walking!')
        expect {TrainingRecord.openai_response_handling(user, record_params) }.to change(TrainingRecord, :count).by(1)
      end
    end
  end
end
