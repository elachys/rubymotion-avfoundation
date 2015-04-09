class MainWindowController < NSWindowController
  extend IB

  outlet :record_label, NSTextField
  outlet :capture_view, NSView
  outlet :inputs_box, NSBox

  MOVIE_FILE_NAME = "test_movie"

  def windowDidLoad
    @recording = false
    @movie_recorder = MovieRecorder.new(@capture_view, MOVIE_FILE_NAME)
    @record_label_layout = RecordLabelLayout.new(@record_label, @movie_recorder)
    add_audio_device_input
  end

  def runAgain(sender)
    select(self)
  end

  def add_audio_device_input
    popup = NSPopUpButton.alloc.initWithFrame([[10, 15], [178, 24]])
    AVCaptureDevice.devicesWithMediaType(AVMediaTypeAudio).each do |device|
      popup.addItemWithTitle(device.localizedName)
    end
    # popup.selectItemAtIndex(0)
    popup.autoresizingMask = NSViewMinYMargin
    popup.target = self
    popup.action = :"runAgain:"
    @inputs_box.contentView.addSubview(popup)
  end

  def keyDown(theEvent)
    if theEvent.keyCode == 49
      @recording = !@recording
      @movie_recorder.stop_record unless @recording
      @record_label_layout.update(@recording)
    end
  end

end