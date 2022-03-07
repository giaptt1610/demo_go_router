import 'package:demo_go_router/app/app_bloc.dart';
import 'package:flutter/foundation.dart';

class AppStateNotifier extends ChangeNotifier {
  Stream<AppState> appStateStream;

  AppState? state;

  AppStateNotifier(this.appStateStream) {
    appStateStream.listen((newState) {
      print('-- new state: $newState');
      state = newState;
      notifyListeners();
    });
  }
}
