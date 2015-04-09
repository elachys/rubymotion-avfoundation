class VideoInputLayout

  def initialize combo_box 
    @combo_box = combo_box
  end

  def devices
    AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
  end

end