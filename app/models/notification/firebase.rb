class Notification::Firebase
  def new
    @fcm = FCM.new(Rails.application.secrets.fcm_server_key)
  end

  def send(registration_ids)
    @fcm.send(registration_ids, {})
  end
end
