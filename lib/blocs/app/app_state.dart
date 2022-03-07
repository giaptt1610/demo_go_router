part of 'app_bloc.dart';

class AppState {
  final bool authenticated;

  final bool loading;

  AppState({
    this.authenticated = false,
    this.loading = false,
  });

  AppState copyWith({bool? loading, bool? isLogged}) {
    return AppState(
      loading: loading ?? this.loading,
      authenticated: isLogged ?? this.authenticated,
    );
  }
}
