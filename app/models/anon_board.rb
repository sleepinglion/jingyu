module AnonBoard
  def authenticate(password)
    puts password 
    expected_password=self.make_encrypted_password(password,self.salt)
    if self.encrypted_password != expected_password
      return nil
    end
    return true    
  end
  
  def password
    @password
  end
  
  def password=(pwd)
    @password=pwd
    self.encrypted_password=make_encrypted_password(self.password, self.create_new_salt)
  end
  
  protected
  
  def make_encrypted_password(password,salt)
    string_to_hash=password+'slboard'+salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
  def create_new_salt
    self.salt=self.object_id.to_s+rand.to_s
  end  
end