import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'internet_state.dart';

class InternetBloc extends Cubit<InternetState> {
  StreamSubscription _streamSubscription;

  InternetBloc(Connectivity connectivity) : super(InternetUnAvailableState()) {
    _streamSubscription = connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        emit(InternetAvailableState());
      }
      if (event == ConnectivityResult.none) {
        emit(InternetUnAvailableState());
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
