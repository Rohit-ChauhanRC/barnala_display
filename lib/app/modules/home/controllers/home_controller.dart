import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  final RxBool _circularProgress = true.obs;
  bool get circularProgress => _circularProgress.value;
  set circularProgress(bool v) => _circularProgress.value = v;

  final RxDouble _progress = 0.0.obs;
  double get progress => _progress.value;
  set progress(double i) => _progress.value = i;

  InAppWebViewSettings settings = InAppWebViewSettings(
    useShouldOverrideUrlLoading: true,
    clearCache: true,
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: true,
    allowsInlineMediaPlayback: true,
    iframeAllow: "camera; microphone;storage;mediaLibrary;photosAddOnly;Photos",
    iframeAllowFullscreen: true,
    allowFileAccessFromFileURLs: true,
    allowContentAccess: true,
    allowFileAccess: true,
    allowsBackForwardNavigationGestures: true,
    useOnDownloadStart: true,
    allowUniversalAccessFromFileURLs: true,
    javaScriptEnabled: true,
    useOnLoadResource: true,
  );

  PullToRefreshController? pullToRefreshController;

  @override
  void onInit() {
    super.onInit();

    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
