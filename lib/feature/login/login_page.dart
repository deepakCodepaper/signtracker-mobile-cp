import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signtracker/blocs/auth/authentication_bloc.dart';
import 'package:signtracker/blocs/login/login_bloc.dart';
import 'package:signtracker/blocs/login/login_state.dart';
import 'package:signtracker/feature/dashboard/dashboard_page.dart';
import 'package:signtracker/feature/register/register_page.dart';
import 'package:signtracker/repository/user_repository.dart';
import 'package:signtracker/widgets/rounded_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  static const String route = '/login-page';

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = true;
  LoginBloc bloc;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    bloc = LoginBloc(
        RepositoryProvider.of<AuthenticationBloc>(context), UserRepository());
    super.initState();
  }

  void onLoginButtonPressed() {
    FocusScope.of(context).requestFocus(FocusNode());

    final username = usernameController.text;
    final password = passwordController.text;
    if (username.isEmpty) {
      showSnackBar('Username is required!');
    } else if (password.isEmpty) {
      showSnackBar('Password is required!');
    } else {
      bloc.loginButtonPressed(username, password);
    }
  }

  void showSnackBar(String message) {
    Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      message: message,
      icon: Icon(
        Icons.warning,
        color: Colors.red,
        size: 20.0,
      ),
      duration: Duration(seconds: 1),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _LoginAppbar(),
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is ValidationFailure) {
            showSnackBar(state.error);
          } else if (state is LoginFailure) {
            showSnackBar(state.error);
          } else if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, DashboardPage.route);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: usernameController,
                      enabled: !(state is LoginLoading),
                      style: textTheme.bodyText2.copyWith(
                        color: Colors.black45,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.yellow[700],
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[200],
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.yellow[700],
                            width: 2,
                          ),
                        ),
                        hintText: 'Email',
                        hintStyle: textTheme.bodyText2.copyWith(
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: passwordController,
                      enabled: !(state is LoginLoading),
                      obscureText: _obscureText,
                      style: textTheme.bodyText2.copyWith(
                        color: Colors.yellow[700],
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.yellow[700],
                          size: 20,
                        ),
                        suffixIcon: IconButton(
                          onPressed: _toggle,
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.yellow[700],
                            size: 20,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[200],
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.yellow[700],
                            width: 2,
                          ),
                        ),
                        hintText: 'Password',
                        hintStyle: textTheme.bodyText2.copyWith(
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Theme(
                          data: ThemeData(
                            primaryColor: Colors.grey,
                            accentColor: Colors.white,
                            unselectedWidgetColor: Colors.grey,
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (value) {
                                  setState(() => rememberMe = value);
                                },
                                checkColor: Colors.yellow[700],
                              ),
                              Text(
                                'Remember me',
                                style: textTheme.bodyText2.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: false,
                          // hide for now as we don't have process for forgot password
                          child: TextButton(
                            child: Text(
                              'Forgot Password?',
                              style: textTheme.bodyText2.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              usernameController.text =
                                  'rhys.coronado@gmail.com';
                              passwordController.text = 'test1234';
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  RoundedButton(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    height: 50.0,
                    radius: 5.0,
                    onPressed:
                        state is LoginLoading ? null : onLoginButtonPressed,
                    text: state is LoginLoading
                        ? 'Continuing'.toUpperCase()
                        : 'Continue'.toUpperCase(),
                    textColor: Colors.black,
                    textSize: 16.0,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    borderColor: Colors.yellow[700],
                    borderWidth: 2.0,
                    color: Colors.yellow[700],
                    elevation: 0.0,
                  ),
                  SizedBox(height: 40),
//                  Text(
//                    'or sign in with',
//                    style: textTheme.body1.copyWith(
//                      color: Colors.grey,
//                      fontSize: 15.0,
//                      fontWeight: FontWeight.w800,
//                    ),
//                  ),
//                  SizedBox(height: 20),
//                  Padding(
//                    padding: EdgeInsets.symmetric(horizontal: 20),
//                    child: Row(
//                      children: [
//                        Expanded(
//                          child: RoundedButton(
//                            height: 50.0,
//                            radius: 5.0,
//                            onPressed: () {},
//                            text: 'Google',
//                            textColor: Colors.black,
//                            textSize: 14.0,
//                            textAlign: TextAlign.left,
//                            borderColor: Colors.yellow[700],
//                            borderWidth: 2.0,
//                            color: Colors.white,
//                            elevation: 0.0,
//                            leading: Row(
//                              children: [
//                                SvgPicture.asset('assets/drawables/google.svg'),
//                              ],
//                            ),
//                          ),
//                        ),
//                        SizedBox(width: 5),
//                        Expanded(
//                          child: RoundedButton(
//                            height: 50.0,
//                            radius: 5.0,
//                            onPressed: () {},
//                            text: 'Facebook',
//                            textColor: Colors.black,
//                            textSize: 14.0,
//                            textAlign: null,
//                            borderColor: Colors.yellow[700],
//                            borderWidth: 2.0,
//                            color: Colors.white,
//                            elevation: 0.0,
//                            leading: Row(
//                              children: [
//                                SvgPicture.asset(
//                                    'assets/drawables/facebook.svg'),
//                              ],
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(
                        context, RegisterPage.route),
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          'Don\'t have an account?',
                          style: GoogleFonts.karla(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.normal),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Sign Up',
                          style: GoogleFonts.karla(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.normal),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}

class _LoginAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Spacer(),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.transparent,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              Spacer(),
              Text(
                'Login',
                style: GoogleFonts.karla(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
              ),
              Spacer(),
              SizedBox(width: 50),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.0);
}
