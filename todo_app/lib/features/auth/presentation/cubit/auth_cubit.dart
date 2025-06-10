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
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> register(String email, String password, String fullName) async {
    emit(AuthLoading());
    try {
      await authRepository.register(email, password, fullName);
      emit(AuthSuccess());
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