import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState()) {
    on<LoginEvent>((event, emit) async {
      emit(state.copyWith(loading: true));

      await Future.delayed(const Duration(seconds: 1));

      emit(state.copyWith(loading: false, isLogged: true));
    });

    on<LogoutEvent>((event, emit) async {
      emit(state.copyWith(loading: true));
      await Future.delayed(Duration(seconds: 1));

      emit(state.copyWith(loading: false, isLogged: false));
    });
  }
}
