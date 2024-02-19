class SendLineNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # 当日の日付でsport_contentカラムが空のユーザーを検索
    not_sport_users = User.where.not(id: TrainingRecord.where(created_at: Time.zone.now.begging_of_day..Time.zone.now.end_of_day).select(:user_id).distinct)

    not_sport_users.each do |user|
      user.authentications.where(provider: "line").each do |authentication|
        send_notification(authentication.uid)
      end
    end
  end

  private

  def send_notification(line_uid)
    message = {
      type: 'text',
      text: '今日の運動報告をまだしていないウホね...？急いで『トレゴリ』を開いて今日の運動を報告するウホ！'
    }
    LineBot.push_message(line_uid, message)
  end
end
