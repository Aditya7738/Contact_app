import 'package:bloc/bloc.dart';
import 'package:contact_app/src/controller/authentication/auth_repository.dart';
import 'package:contact_app/src/core/network/api_response.dart';
import 'package:contact_app/src/core/storage/storage_helper.dart';
import 'package:contact_app/src/core/storage/storage_keys.dart';
import 'package:contact_app/src/models/signupModel.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthStateInitial());

  Future<void> login(String email, String password) async {
    emit(AuthStateLoading());

    AuthRepository authRepository = AuthRepository();

    try {
      ApiResponse apiResponse = await authRepository.login(email, password);
      if (apiResponse.status) {
        //store token and id

        await StorageHelper()
            .writeData(StorageKeys.userToken, apiResponse.token!);
        await StorageHelper()
            .writeData(StorageKeys.userId, apiResponse.data["_id"]);

        emit(AuthStateAuthenticate(email)); //success state
      } else {
        emit(const AuthStateUnauthenticate('Invalid Credentials'));
      }
    } catch (e) {
      emit(const AuthStateUnauthenticate('Authentication Error'));
    }
  }

  Future<void> signUp(SignupModel signupModel) async {
    emit(AuthStateLoading());
//
    AuthRepository authRepository = AuthRepository();

    try {
      ApiResponse apiResponse = await authRepository.signup(signupModel);
      if (apiResponse.status) {
        //store token and id

        await StorageHelper()
            .writeData(StorageKeys.userToken, apiResponse.token!);
        await StorageHelper()
            .writeData(StorageKeys.userId, apiResponse.data["_id"]);

        emit(AuthStateAuthenticate(signupModel.email));
      } else {
        emit(const AuthStateUnauthenticate("Failed to register"));
      }
    } catch (e) {
      emit(const AuthStateUnauthenticate("Failed to create user"));
    }
  }
}
