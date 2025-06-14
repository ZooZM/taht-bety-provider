import 'package:bloc/bloc.dart';
import 'package:taht_bety_provider/auth/data/models/provider_curuser.dart';
import 'package:taht_bety_provider/auth/data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    final result = await authRepo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold(
      (failure) {
        if (failure.failurMsg == email) {
          return emit(AuthProviderAccountFailure(email));
        }
        return emit(AuthFailure(failure.failurMsg));
      },
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> fetchUser() async {
    emit(AuthLoading());
    final result = await authRepo.fetchuser();
    result.fold(
      (failure) => emit(AuthFailure(failure.failurMsg)),
      (user) => emit(AuthSuccess(user)),
    );
    return;
  }
}
