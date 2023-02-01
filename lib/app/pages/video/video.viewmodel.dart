import 'dart:async';
import 'dart:developer';

import 'package:smartfarm/repositories.dart';

class VideoViewModel extends ViewModel {
  bool hasPlayed = false;
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  bool _isControllerShow = false;
  bool get isControllerShow => _isControllerShow;
  set isControllerShow(bool value) {
    _isControllerShow = value;
    notifyListeners();
  }

  Timer? timer;

  double _videoAspectRatio = 16 / 9;
  double get videoAspectRatio => _videoAspectRatio;
  set videoAspectRatio(double value) {
    _videoAspectRatio = value;
    notifyListeners();
  }

  VideoPlayerController? _controller;
  VideoPlayerController? get controller => _controller;
  set controller(VideoPlayerController? value) {
    _controller = value;
    notifyListeners();
  }

  VideoModel _video = VideoModel();
  VideoModel get video => _video;
  set video(VideoModel value) {
    _video = value;
    notifyListeners();
  }

  List<VideoModel> _videos = List<VideoModel>.empty(growable: true);
  List<VideoModel> get videos => _videos;
  set videos(List<VideoModel> value) {
    _videos = value;
    notifyListeners();
  }

  void hideVideoController() {
    isControllerShow = false;
  }

  void showVideoController() {
    isControllerShow = true;

    if (timer != null) {
      timer?.cancel();
    }
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      isControllerShow = false;
      timer.cancel();
    });
  }

  void showOrHideVideoController() {
    if (isControllerShow) {
      hideVideoController();
    } else {
      showVideoController();
    }
  }

  void playVideo() {
    if (controller != null) {
      controller?.play();
      hasPlayed = true;
      isPlaying = true;

      showVideoController();
    }
  }

  void pauseVideo() {
    if (controller != null) {
      if (controller!.value.isPlaying) {
        controller?.pause();
        isPlaying = false;
        showVideoController();
      }
    }
  }

  void playNextVideo() {
    if (videos.length > 1) {
      final index =
          videos.indexWhere((element) => element.videoID == video.videoID);
      if (index < videos.length - 1) {
        changeVideo(videos[index + 1]);
      }
    }
  }

  void playPreviousVideo() {
    if (videos.length > 1) {
      final index =
          videos.indexWhere((element) => element.videoID == video.videoID);
      if (index > 0) {
        changeVideo(videos[index - 1]);
      }
    }
  }

  void changeVideo(VideoModel video) async {
    this.video = video;
    hideVideoController();
    try {
      controller = VideoPlayerController.network(video.videoUrl!);
      controller?.addListener(() {
        log('isPlaying: ${controller!.value.isPlaying}');

        if (controller!.value.isPlaying) {
          if (controller!.value.position == controller!.value.duration) {
            isPlaying = false;
            showVideoController();
          }
        }

        // isPlaying = controller!.value.isPlaying;
      });
      controller?.setLooping(false);
      controller?.setVolume(1.0);
      controller?.initialize().then((_) {
        videoAspectRatio = controller!.value.aspectRatio;
        playVideo();
        notifyListeners();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void init() {
    videos.add(VideoModel(
      videoID: '1',
      videoUrl:
          'https://file-examples.com/storage/fec6ed21bf63d96b49d1196/2017/04/file_example_MP4_1280_10MG.mp4',
      videoName: 'Video 1',
    ));
    videos.add(VideoModel(
      videoID: '2',
      videoUrl:
          'https://file-examples.com/storage/fec6ed21bf63d96b49d1196/2017/04/file_example_MP4_1280_10MG.mp4',
      videoName: 'Video 2',
    ));
    videos.add(VideoModel(
      videoID: '3',
      videoUrl:
          'https://file-examples.com/storage/fec6ed21bf63d96b49d1196/2017/04/file_example_MP4_1280_10MG.mp4',
      videoName: 'Video 3',
    ));
    videos = videos;
    changeVideo(VideoModel(
      videoID: '1',
      videoUrl:
          'https://file-examples.com/storage/fec6ed21bf63d96b49d1196/2017/04/file_example_MP4_1280_10MG.mp4',
      videoName: 'Video 1',
    ));
  }

  @override
  void onDependenciesChange() {}

  @override
  void onBuild() {}

  @override
  void onMount() {
    try {
      if (hasPlayed) {
        controller?.pause();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onUnmount() {
    try {
      if (hasPlayed) {
        controller?.dispose();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onResume() {
    try {
      if (hasPlayed) {
        controller?.pause();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onPause() {
    try {
      if (hasPlayed) {
        controller?.pause();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onInactive() {
    try {
      if (hasPlayed) {
        controller?.pause();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onDetach() {
    try {
      if (hasPlayed) {
        controller?.pause();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
