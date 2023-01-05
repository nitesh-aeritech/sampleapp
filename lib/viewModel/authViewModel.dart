import 'package:thewarehouse/services/userService.dart';
import 'package:thewarehouse/viewModel/core/baseViewModel.dart';

class AuthViewModel extends BaseViewModel {
  final UserService userService;
  AuthViewModel(this.userService);

  Future<String> login(String username, String password) async {
    try {
      await userService.loginUser(username, password);
      return 'OK';
    } catch (e) {
      rethrow;
    }
  }
}
