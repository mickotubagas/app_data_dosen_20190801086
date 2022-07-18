import 'package:app_data_dosen_20190801086/login_admin.dart';
import 'package:app_data_dosen_20190801086/regis.dart';
import 'package:flutter/material.dart';

class AuthAutoAdmin extends StatefulWidget {
  const AuthAutoAdmin({Key? key}) : super(key: key);

  @override
  State<AuthAutoAdmin> createState() => _AuthAutoAdminState();
}

class _AuthAutoAdminState extends State<AuthAutoAdmin> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginScreenAdmin(onClickedSignUp: toggle)
      : RegisScreen(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
