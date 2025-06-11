import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/auth/domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      await authRepository.login(email, password);
      final profile = await authRepository.getUser();
      emit(AuthSuccess(profile));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> register(String email, String password, String displayName) async {
    emit(AuthLoading());
    try {
      await authRepository.register(email, password, displayName);
      final profile = await authRepository.getUser();
      emit(AuthSuccess(profile));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

   Future<void> setAuthFailure(String e) async {
    emit(AuthFailure(e));
   }

  Future<void> logout() async {
    await authRepository.logout();
    emit(AuthInitial());
  }
}