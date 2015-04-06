class MovieProcessor 

  def initialize file_name
    @file_name = file_name
    remove_local_files([transcoded_file_path])
    trim_video
    remove_local_files([local_file_path])
  end

private

  def trim_video
    asset = AVURLAsset.alloc.initWithURL(NSURL.fileURLWithPath(local_file_path), options: nil)
    export_session = AVAssetExportSession.alloc.initWithAsset(asset, presetName:AVAssetExportPreset640x480) 
    export_session.outputURL = NSURL.fileURLWithPath(transcoded_file_path)
    export_session.outputFileType = AVFileTypeMPEG4
    export_session.videoComposition = video_composition(asset)

    export_session.exportAsynchronouslyWithCompletionHandler(lambda do
      Dispatch::Queue.main.async do
        case export_session.status
        when AVAssetExportSessionStatusCompleted
          p "success"
        end
      end
    end)
  end

  def video_composition asset 
    clip_track = asset.tracksWithMediaType(AVMediaTypeVideo).objectAtIndex(0)

    composition = AVMutableVideoComposition.videoComposition
    composition.frameDuration = CMTimeMake(1, 30)
    composition.renderSize = CGSizeMake(480, 480)

    instruction = AVMutableVideoCompositionInstruction.videoCompositionInstruction
    instruction.timeRange = CMTimeRangeMake(KCMTimeZero, CMTimeMakeWithSeconds(60, 30) )

    transformer = AVMutableVideoCompositionLayerInstruction.videoCompositionLayerInstructionWithAssetTrack(clip_track)
    transformer.setTransform(CGAffineTransformMakeTranslation(-80, 0), atTime: KCMTimeZero)

    instruction.layerInstructions = NSArray.arrayWithObject(transformer)
    composition.instructions = NSArray.arrayWithObject(instruction)
    composition
  end

  def remove_local_files file_paths
    file_paths.each do |file_path|
      if NSFileManager.defaultManager.fileExistsAtPath(file_path)
        NSFileManager.defaultManager.removeItemAtPath(file_path, error:nil)
      end
    end
  end

  def local_file_path
    "#{NSHomeDirectory()}/Desktop/#{@file_name}.mov"
  end

  def transcoded_file_path
    "#{NSHomeDirectory()}/Desktop/#{@file_name}.mp4"
  end

end