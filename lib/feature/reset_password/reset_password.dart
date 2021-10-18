import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signtracker/blocs/auth/authentication_bloc.dart';
import 'package:signtracker/blocs/login/login_bloc.dart';
import 'package:signtracker/blocs/login/login_state.dart';
import 'package:signtracker/repository/user_repository.dart';
import 'package:signtracker/widgets/rounded_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage();

  static const String route = '/reset-password-page';

  @override
  State<StatefulWidget> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  LoginBloc bloc;
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    bloc = LoginBloc(
        RepositoryProvider.of<AuthenticationBloc>(context), UserRepository());
    super.initState();
  }

  void onResetPasswordButtonPressed() {
    FocusScope.of(context).requestFocus(FocusNode());

    final email = emailController.text;
    if (email.isEmpty) {
      showSnackBar('Email is required!', false);
    } else {
      bloc.resetPasswordButtonPressed(email);
    }
  }

  void showSnackBar(String message, bool isInfo) {
    Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      message: message,
      icon: Icon(
        isInfo ? Icons.check_circle : Icons.warning,
        color: isInfo ? Colors.green : Colors.red,
        size: 20.0,
      ),
      duration: Duration(seconds: 3),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _ResetPasswordAppbar(),
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is ValidationFailure) {
            showSnackBar(state.error, false);
          } else if (state is LoginFailure) {
            showSnackBar(state.error, false);
          } else if (state is LoginInfo) {
            showSnackBar(state.info, true);
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
                      controller: emailController,
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
                  RoundedButton(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    height: 50.0,
                    radius: 5.0,
                    onPressed: state is LoginLoading
                        ? null
                        : onResetPasswordButtonPressed,
                    text: state is LoginLoading
                        ? 'Resetting'.toUpperCase()
                        : 'Reset'.toUpperCase(),
                    textColor: Colors.black,
                    textSize: 16.0,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    borderColor: Colors.yellow[700],
                    borderWidth: 2.0,
                    color: Colors.yellow[700],
                    elevation: 0.0,
                  ),
                  SizedBox(height: 20),
                  RoundedButton(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    height: 50.0,
                    radius: 5.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Back to Login'.toUpperCase(),
                    textColor: Colors.black,
                    textSize: 16.0,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    elevation: 0.0,
                  ),
                  SizedBox(height: 20),
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

class _ResetPasswordAppbar extends StatelessWidget
    implements PreferredSizeWidget {
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
                'Reset Password',
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
