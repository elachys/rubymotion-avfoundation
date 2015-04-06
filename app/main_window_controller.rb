class MainWindowController < NSWindowController
  extend IB

  outlet :record_label, NSTextField
  outlet :capture_view, NSView
  outlet :progress_indicator, NSProgressIndicator

  def windowDidLoad
    @recording = false
    @movie_recorder = MovieRecorder.new(@capture_view)
    @record_label_layout = RecordLabelLayout.new(@record_label, @movie_recorder)
    @progress_indicator.startAnimation(self)
    get_translation
  end

  def keyDown(theEvent)
    if theEvent.keyCode == 49
      @recording = !@recording
      @movie_recorder.stop_record unless @recording
      @record_label_layout.update(@recording)
    end
  end

end