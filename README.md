# rubymotion-avfoundation

This is a simple OSX app for recording video from your webcam.  Some of the features:

* It launches the record with spacebar input to begin, then counts down from 2 and starts to record. 

* It displays a square aspect ratio and makes the post-record trims necessary to save the file as a square. 

* It saves the file as test_movie.mp4, and will save the file to your desktop.

* The audio and video input device is selectable.

### To get started:

```
bundle
rake
```

### Todo:

* Allow selection of save location
* Better compression on the mp4 file