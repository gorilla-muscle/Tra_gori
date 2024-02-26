namespace :send_line_notifies do
  desc "運動報告していない場合にLINE通知を送信する"
  # タスク名(notify)を指定
  task notify: :environment do
    not_sport_users = User.where.not(id: TrainingRecord.where(created_at: Time.zone.now.all_day)
                                                        .select(:user_id)
                                                        .distinct)

    not_sport_users.each do |user|
      user.authentications.where(provider: "line").find_each do |authentication|
        send_notification(authentication.uid)
      end
    end
  end
end
