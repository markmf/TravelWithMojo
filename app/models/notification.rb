class Notification < ApplicationRecord
  after_create_commit { NotificationJob.perform_now self }

  belongs_to :user
end
