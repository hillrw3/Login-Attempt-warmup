class User < ActiveRecord::Base
  validates_presence_of :email, :password
  validates_uniqueness_of :email


  def login_attempt_counter
    self.update(logins: (self.logins + 1))
  end

  def check_user_logins
   if self.logins >= 4
     self.update(active: false)
   end
  end

  def erase_logins
    self.update(logins: 0)
  end

  def wait_1_minute
    sleep(60)
    erase_logins
    self.update(active: true)
  end



end
