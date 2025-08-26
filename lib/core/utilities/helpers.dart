
// ignore_for_file: avoid_print, prefer_asserts_with_message

// --------------------
/// TESTED : WORKS PERFECT
Future<void> tryAndCatch({
  required Future<void> Function() functions,
  required String invoker,
  void Function(String? error)? onError,
  Function? onTimeout,
  int? timeout,
}) async {

  try {

    ///  WITHOUT TIMEOUT
    if (timeout == null) {
      await functions();
    }

    /// WITH TIMEOUT
    else {
      await functions().timeout(
        Duration(seconds: timeout),
        onTimeout: () async {

          if (onError != null){
            onError('Timeout ( $invoker ) after ( $timeout) seconds');
          }

          onTimeout?.call();

        },);
    }


  }
// on Exception : this does not work on web
  catch (error) {

    if (onError == null){
      blog('$invoker : tryAndCatch ERROR : $error');
    }

    else {
      onError(error.toString());
    }

// throw(error);
  }

}

void blog(dynamic msg, {String? invoker}) {
// Only prints in debug mode
  assert(() {
    print('[${invoker ?? 'Logger'}] $msg');
    return true;
  }());
}

bool checkCanLoop(List<dynamic>? list) {
  bool _canLoop = false;

  if (list != null && list.isNotEmpty) {
    _canLoop = true;
  }

  return _canLoop;
}
