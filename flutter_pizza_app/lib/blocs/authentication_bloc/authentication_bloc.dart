import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  late final StreamSubscription<MyUser?> _userSubscription;

  AuthenticationBloc({required this.userRepository})
    : super(const AuthenticationState.unknown()) {
    // User stream'ini dinliyoruz ve her değişimde event fırlatıyoruz
    _userSubscription = userRepository.user.listen(
      (user) => add(AuthenticationUserChanged(user)),
    );

    on<AuthenticationUserChanged>(_onAuthenticationUserChanged);
  }

  void _onAuthenticationUserChanged(
    AuthenticationUserChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    final user = event.user;

    // Kullanıcının "gerçekten" giriş yapıp yapmadığını burada karar veriyoruz
    final isUnauthenticated =
        user == null ||
        user == MyUser.empty ||
        user.userId.isEmpty; // MyUser'daki id alanın adı userId olduğu için

    if (isUnauthenticated) {
      // Giriş yapılmamış
      emit(const AuthenticationState.unauthenticated());
    } else {
      // Geçerli kullanıcı → giriş yapılmış
      emit(AuthenticationState.authenticated(user));
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
