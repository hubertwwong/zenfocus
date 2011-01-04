class Post < ActiveRecord::Base

  validates :body, :presence => true

  # current active
  #
  # determines if the most recent task is active.
  # if it is, return it. if it is not, return nil.
  # need to nil check..
  def current
    current_post = Post.last

    # makes 2 checks.
    # 1. if the item isn't nil. (sanity check)
    # 2. if the task timed out yet. completed time > time now.
    if current_post != nil # and current_post.completed_at > Time.now.utc
      current_post
    else
      nil
    end
  end

  # parse time
  #
  # method to parse the time value out of a string using some escape code.
  # for now. i'm just assuming the first word of with the '+' prefix
  # will be used.
  #
  # buggy... sorta basically i don't want this to be called every time.
  # just on update.
  def parse_time
    # add a default time for a task.
    length_of_task = Time.now + 15.minutes

    # splits the entered text.
    sentence = body.split ' '
    esc_code = sentence.first

    # determines if the word is long enough.
    # if it was long enough, split the word into the necessary code.
    if esc_code.length >= 2
       esc_code_prefix = esc_code[0]
       esc_code_suffix = esc_code[1..-1]
    end

    # checks for valid escape sequence to parse.
    if esc_code_prefix == "+" and esc_code_suffix.match /\d/
      # set time specified by user.
      length_of_task = Time.now + (esc_code_suffix.to_i * 60)
      # remove the escape code from the string.
      sentences = body.split ' ', 2
      self.body = sentences[1]
    end

    # set the completed at time field.
    self.completed_at = length_of_task
    
  end


  # NOTE.
  #
  # columns in play.
  # completed_task, completed_at, body.
  #
  # completed_task (0=no, 1=yes)
end
