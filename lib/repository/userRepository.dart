import 'package:thewarehouse/config/constant/apiUrl.dart';
import 'package:thewarehouse/services/core/httpService.dart';

abstract class UserRepository {
  Future<dynamic> loginUser(String username, String password);
  // Future<dynamic> userDetails();
}

class UserRepositoryImpl implements UserRepository {
  final HttpService httpService;
  UserRepositoryImpl(this.httpService);
  @override
  Future<dynamic> loginUser(String userName, String password) async {
    try {
      final data = await httpService.postRequestWithoutAuth(ApiUrl.loginUser, data: {'username': userName, 'password': password});
      return data;
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<dynamic> userDetails() async {
  //   final data = await httpService.getData(ApiUrl.userDetails);
  //   return data;
  // }
}
