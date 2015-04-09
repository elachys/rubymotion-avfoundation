class MainWindowController < NSWindowController
  extend IB

  outlet :record_label, NSTextField
  #~/proj/RubyMotionSamples/osx/PathDemo
  outlet :audioDevices, NSPopUpButtonCell
  outlet :capture_view, NSView

  MOVIE_FILE_NAME = "test_movie"

  def windowDidLoad
    @recording = false
    @movie_recorder = MovieRecorder.new(@capture_view, MOVIE_FILE_NAME)
    @record_label_layout = RecordLabelLayout.new(@record_label, @movie_recorder)
    add_popups
    # ary  = ["tacos","rainbows", "iPhones", "gold coins"]
    # self.setAudioDevices(AVCaptureDevice.devicesWithMediaType(AVMediaTypeAudio))
    # @audioDevices.addItemsWithTitles(ary)
    # @audioDevices.selectItemAtIndex(0)
    # @audio_input_layout = AudioInputLayout.new(@audio_inputs)
    # @video_input_layout = VideoInputLayout.new(@video_inputs)
  end

  def runAgain
    p "run again"
  end

  def add_popups
    popup = NSPopUpButton.alloc.initWithFrame([[158, 431], [178, 24]])
    ['Rectangles', 'Circles', 'Bezier Paths', 'Circle Clipping'].each do |title|
      popup.addItemWithTitle(title)
    end
    popup.autoresizingMask = NSViewMinYMargin
    popup.target = self
    popup.action = :"runAgain:"
    # self.addSubview(@popup)
  end

  def keyDown(theEvent)
    if theEvent.keyCode == 49
      @recording = !@recording
      @movie_recorder.stop_record unless @recording
      @record_label_layout.update(@recording)
    end
  end

end