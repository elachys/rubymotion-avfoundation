class RecordLabelLayout

  def initialize label, movie_recorder
    @movie_recorder = movie_recorder
    @label = label
    set_default
  end

  def clear
    @label.stringValue = ""
  end

  def update recording
    if recording 
      @seconds = 2
      @label.stringValue = @seconds
      @timer = NSTimer.scheduledTimerWithTimeInterval(1,
        target: self,
        selector: "timerHandler:",
        userInfo: nil,
        repeats: true
      )
    else
      set_default
    end
  end

private

  def set_default
    @label.stringValue = "Press [space] to start recording"
    @label.textColor = NSColor.blackColor
  end

  def timerHandler target 
    @seconds -= 1
    if seconds == 0
      @timer.invalidate
      @movie_recorder.record
      @label.stringValue = "Recording... Press [space] to stop"
      @label.textColor = NSColor.redColor
    else
      @label.stringValue = @seconds
    end
  end
end