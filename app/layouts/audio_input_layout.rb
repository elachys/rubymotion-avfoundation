class AudioInputLayout

  def initialize combo_box 
    @combo_box = combo_box
    self.setAudioDevices(AVCaptureDevice.devicesWithMediaType(AVMediaTypeAudio))
    @combo_box.addItemsWithObjectValues(test)
  end

  def devices
    AVCaptureDevice.devicesWithMediaType(AVMediaTypeAudio)
  end
end