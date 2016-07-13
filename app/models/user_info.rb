class UserInfo < ActiveRecord::Base
  acts_as_tagger

  def set_seen_mems
    self.update_attribute(:seen_mem_time, DateTime.now)
  end
end
