class UserInfo < ActiveRecord::Base
  acts_as_tagger
  serialize :user_tags

  def set_seen_mems
    self.update_attribute(:seen_mem_time, DateTime.now)
  end
end
