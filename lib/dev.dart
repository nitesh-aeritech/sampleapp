import 'package:thewarehouse/config/constant/apiUrl.dart';
import 'package:thewarehouse/main.dart';

//Entry Point for Dev Env Variable
void main() async {
  //Configure needed services for Dev Env
  ApiUrl.isDevEnv = true;
  mainApp();
}
