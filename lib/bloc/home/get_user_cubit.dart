import 'package:bloc/bloc.dart';
import 'package:insurance_agent_flutter/model/login/user_model.dart';
import 'package:insurance_agent_flutter/util/secure_storage_utils.dart';
import 'package:meta/meta.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(GetUserInitial()){
    SecureStorageUtils.getUserData().then((value) {
      if(value != null){
        emit(GetUserLoaded(value));
      }
    });
  }
}
