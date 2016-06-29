class Note < ActiveRecord::Base
  validates :title, presence: true
  validates :body, length: { maximum: 500 }

  def self.ready_to_show(user)
    priority_notes = get_priority_notes(user)
    date_notes = get_date_notes(user)
    date_notes + priority_notes
  end

  def showing_order
    priority * time_since_seen
  end

  def time_since_seen
    Date.today.mjd - date_seen.mjd
  end

  def show_today?
    Date.today != date_seen
  end

  def self.get_priority_notes(user)
    note = Note.where(user: user)
      .where.not(date_seen: Date.today)
      .sort_by(&:showing_order).reverse
      .reject{ |n| n['priority'] == 0}
    return [] if !note
    note.slice(0,5)
  end

  def self.get_date_notes(user)
    note = Note.where(user: user)
      .where.not(date_seen: Date.today)
      .where.not(date_show: nil)
      .where("date_show <= ?", Date.today)
    return [] if !note
    note
  end

  def priority_in_words
    case priority
    when 1
      return "Low"
    when 2
      return "Medium"
    when 3
      return "High"
    end
  end
end

