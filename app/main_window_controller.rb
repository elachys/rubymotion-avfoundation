class MainWindowController < NSWindowController
  extend IB

  outlet :record_label, NSTextField
  outlet :capture_view, NSView
  outlet :audio_input_box, NSBox
  outlet :video_input_box, NSBox

  MOVIE_FILE_NAME = "test_movie"

  def windowDidLoad
    @recording = false
    @movie_recorder = MovieRecorder.new(@capture_view, MOVIE_FILE_NAME)
    @record_label_layout = RecordLabelLayout.new(@record_label, @movie_recorder)
    add_video_device_input
    add_audio_device_input
  end

  def select_audio sender
    select(self)
  end

  def select_video sender
    select(self)
  end

  def add_audio_device_input
    popup = NSPopUpButton.alloc.initWithFrame([[7, 6], [178, 24]])
    AVCaptureDevice.devicesWithMediaType(AVMediaTypeAudio).each do |device|
      popup.addItemWithTitle(device.localizedName)
    end
    # popup.selectItemAtIndex(0)
    popup.autoresizingMask = NSViewMinYMargin
    popup.target = self
    popup.action = :"select_audio :"
    @audio_input_box.contentView.addSubview(popup)
  end

  def add_video_device_input
    popup = NSPopUpButton.alloc.initWithFrame([[7, 6], [178, 24]])
    AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo).each do |device|
      popup.addItemWithTitle(device.localizedName)
    end
    # popup.selectItemAtIndex(0)
    popup.autoresizingMask = NSViewMinYMargin
    popup.target = self
    popup.action = :"select_video:"
    @video_input_box.contentView.addSubview(popup)
  end

  def keyDown(theEvent)
    if theEvent.keyCode == 49
      @recording = !@recording
      @movie_recorder.stop_record unless @recording
      @record_label_layout.update(@recording)
    end
  end

end