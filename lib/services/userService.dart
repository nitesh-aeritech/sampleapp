import 'package:thewarehouse/repository/userRepository.dart';
import 'package:thewarehouse/services/core/preferenceService.dart';

class UserService {
  final UserRepository userRepository;

  final PreferenceService preferenceService = PreferenceService();
  UserService(
    this.userRepository,
  );
  Future<Map<String, dynamic>> loginUser(String username, String password) async {
    try {
      final Map<String, dynamic> data = await userRepository.loginUser(username, password);
      PreferenceService().accessToken = data['accessToken'];
      PreferenceService().userName = username;
      return data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
}
