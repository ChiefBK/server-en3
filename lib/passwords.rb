module Passwords
  def self.register_temporary_password(user, duration = 1.minute)
    temporary_password = self.generate_password
    temp_pass = TemporaryPassword.create(user: user, password: temporary_password)

    # TODO - what to do with temporary passwords if multiple are generated for same user
    DeleteTemporaryPassJob.set(wait: duration).perform_later(temp_pass.id)
    temp_pass.password
  end

  def self.check_temporary_password(user, password_to_check)
    temp_pass = TemporaryPassword.temporary_password_for_user(user)
    temp_pass.password == password_to_check
  end

  def self.generate_password(length = 6)
    random_hex_string = SecureRandom.hex
    random_dec_string = Integer("0x#{random_hex_string}").to_s
    random_dec_string[0...length]
  end
end