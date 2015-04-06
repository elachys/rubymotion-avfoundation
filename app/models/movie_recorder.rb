class MovieRecorder

  attr_accessor :file_name

  def initialize capture_view
    @capture_view = capture_view
    setup
  end

  def file_name=file_name 
    @file_name = file_name.tr(".", "").tr("!", "").tr("?", "").tr(" ", "_").downcase
  end

  def record
    @video_output.startRecordingToOutputFileURL(local_ns_url, recordingDelegate:self)
  end

  def stop_record
    @video_output.stopRecording()
    MovieProcessor.new(@file_name)
  end

  def clip_data
    {
      content_type: "video/quicktime",
      filename: "#{@file_name}.mov",
      data: NSData.dataWithContentsOfFile(local_file_path)
    }
  end

private

  def setup
    @session = AVCaptureSession.alloc.init
    add_av_audio_input
    add_av_video_input
    add_av_audio_output 
    add_av_video_output
    create_capture_view
    @session.setSessionPreset(AVCaptureSessionPreset640x480)
    @session.startRunning()
  end

  def create_capture_view
    preview_layer = AVCaptureVideoPreviewLayer.alloc.initWithSession(@session)
    preview_layer.videoGravity = AVLayerVideoGravityResizeAspectFill
    preview_layer.setFrame(@capture_view.layer.bounds)
    @capture_view.layer.addSublayer(preview_layer)
  end

  def add_av_video_output 
    @video_output = AVCaptureMovieFileOutput.alloc.init
    @video_output.setDelegate(self)
    @session.addOutput(@video_output)
  end
  
  def add_av_audio_output 
    @audio_output = AVCaptureAudioPreviewOutput.alloc.init
    @session.addOutput(@audio_output)
  end

  def add_av_audio_input 
    audio_device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
    if audio_input = AVCaptureDeviceInput.deviceInputWithDevice(audio_device, error:error)
        @session.addInput(audio_input)
    end
  end

  def add_av_video_input 
    video_device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    if video_input = AVCaptureDeviceInput.deviceInputWithDevice(video_device, error:error)
        @session.addInput(video_input)
    end
  end

  def error
    Pointer.new('@')
  end

  def local_ns_url
    NSURL.fileURLWithPath(local_file_path)
  end

  def local_file_path
    "#{NSHomeDirectory()}/Desktop/#{@file_name}.mov"
  end

end