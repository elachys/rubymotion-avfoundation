class MainWindowController < NSWindowController
  extend IB

  outlet :record_label, NSTextField
  outlet :video_inputs, NSComboBox
  outlet :audio_inputs, NSComboBox
  outlet :capture_view, NSView

  MOVIE_FILE_NAME = "test_movie"

  def windowDidLoad
    @recording = false
    @movie_recorder = MovieRecorder.new(@capture_view, MOVIE_FILE_NAME)
    @record_label_layout = RecordLabelLayout.new(@record_label, @movie_recorder)
    @audio_input_layout = AudioInputLayout.new(@audio_inputs)
    @video_input_layout = VideoInputLayout.new(@video_inputs)
  end

  def keyDown(theEvent)
    if theEvent.keyCode == 49
      @recording = !@recording
      @movie_recorder.stop_record unless @recording
      @record_label_layout.update(@recording)
    end
  end

end