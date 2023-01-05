import 'package:flutter/material.dart';
import 'package:thewarehouse/config/constant/constant.dart';
import 'package:thewarehouse/config/helper/screenSizeConfig.dart';
import 'package:thewarehouse/config/helper/uiHelpers.dart';
import 'package:thewarehouse/config/routes/routes.dart';
import 'package:thewarehouse/config/theme/themes.dart';
import 'package:thewarehouse/services/core/preferenceService.dart';
import 'package:thewarehouse/view/core/baseView.dart';
import 'package:thewarehouse/viewModel/authViewModel.dart';
import 'package:thewarehouse/widgets/progressDialog.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameTextController = TextEditingController(text: PreferenceService().userName);
  final TextEditingController passwordTextController = TextEditingController();
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(builder: (context, model, child) {
      return Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  appName,
                  style: TextStyle(color: Colors.black, fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: 30)),
                ),
                const SizedBox(
                  height: 60,
                ),
                TextFormField(
                  controller: usernameTextController,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please Enter Username";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: "Username", prefixIcon: Icon(Icons.person)),
                ),
                adaptableHeight(20),
                TextFormField(
                  controller: passwordTextController,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please Enter Password";
                    }
                    return null;
                  },
                  obscureText: isObscure,
                  decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.key),
                      suffixIcon: IconButton(
                          onPressed: () {
                            isObscure = !isObscure;
                            model.setState();
                          },
                          icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off))),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextButton(
                  style: ButtonStyle(minimumSize: MaterialStateProperty.resolveWith((states) => Size(ScreenSizeConfig.getAdaptableWidth(mobileSize: 200), Themes.buttonHeight))),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (_formKey.currentState!.validate()) {
                      ProgressDialog pr = ProgressDialog(context, 'Logging in');
                      await pr.show();
                      try {
                        await model.login(usernameTextController.value.text, passwordTextController.value.text);
                        await pr.hide();
                        Navigator.pushNamedAndRemoveUntil(context, Routes.truckPage, (route) => false);
                      } catch (e) {
                        await pr.hide();
                        showAlertDialog(context, e.toString());
                      }
                    }
                  },
                  child: const Text(
                    "Login",
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
