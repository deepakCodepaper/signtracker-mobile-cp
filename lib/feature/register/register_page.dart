import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signtracker/blocs/auth/authentication_bloc.dart';
import 'package:signtracker/blocs/login/login_bloc.dart';
import 'package:signtracker/blocs/login/login_state.dart';
import 'package:signtracker/feature/login/login_page.dart';
import 'package:signtracker/repository/user_repository.dart';
import 'package:signtracker/utilities/color_helper.dart';
import 'package:signtracker/widgets/rounded_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage();

  static const String route = '/register-page';

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool rememberMe = true;
  LoginBloc bloc;
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String stateCode = "";
  List states = List.empty(growable: true);

  String countryCode = "";
  List countries = List.empty(growable: true);

  loadCountries() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/countries_regions.json');
    setState(() {
      countries = json.decode(data);
    });
  }

  @override
  void initState() {
    bloc = LoginBloc(
      RepositoryProvider.of<AuthenticationBloc>(context),
      UserRepository(),
    );
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadCountries();
    });
  }

  void onRegisterButtonPressed() {
    FocusScope.of(context).requestFocus(FocusNode());

    final username = usernameController.text;
    final password = passwordController.text;
    final name = nameController.text;
    final mobile = mobileController.text;
    final companyCode = companyController.text;
    final countryIndex =
        countries.indexWhere((element) => element['iso3'] == countryCode);
    final countryName = countryIndex > 0 ? countries[countryIndex]['name'] : "";
    final stateIndex =
        states.indexWhere((element) => element['state_code'] == stateCode);
    final stateName = stateIndex > 0 ? states[stateIndex]['name'] : "";

    if (username.isEmpty) {
      showSnackBar('Username is required.');
    } else if (password.isEmpty) {
      showSnackBar('Password is required.');
    } else if (name.isEmpty) {
      showSnackBar('Name is required.');
    } else if (mobile.isEmpty) {
      showSnackBar('Mobile is required.');
    } else if (companyCode.isEmpty) {
      showSnackBar('Company code is required.');
    } else if (countryCode.isEmpty) {
      showSnackBar('Country is required.');
    } else if (states.length > 0 && stateCode.isEmpty) {
      showSnackBar('State is required.');
    } else {
      bloc.registerButtonPressed(username, password, name, mobile, companyCode,
          countryName, countryCode, stateName, stateCode);
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
      duration: Duration(seconds: 3),
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
            showDialog<dynamic>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  title: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: HexColor("#4CAF50"),
                          size: 75,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Account Created!',
                          style: GoogleFonts.karla(
                              color: HexColor("#4CAF50"),
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  content: Container(
                    height: 200,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'You have successfully created an account! \nPlease check the email you registered and verify your account before logging in.',
                            style: GoogleFonts.karla(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 25),
                          Container(
                            height: 48,
                            width: 140,
                            child: TextButton(
                              // color: AppColors.blueDialogButton,
                              child: new Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  LoginPage.route,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
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
                      controller: nameController,
                      enabled: !(state is LoginLoading),
                      style: textTheme.bodyText2.copyWith(
                        color: Colors.yellow[700],
                      ),
                      decoration: InputDecoration(
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
                        hintText: 'Name',
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
                      controller: usernameController,
                      enabled: !(state is LoginLoading),
                      style: textTheme.bodyText2.copyWith(
                        color: Colors.yellow[700],
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
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
                    child: TextField(
                      controller: mobileController,
                      enabled: !(state is LoginLoading),
                      style: textTheme.bodyText2.copyWith(
                        color: Colors.yellow[700],
                      ),
                      decoration: InputDecoration(
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
                        hintText: 'Mobile Number',
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
                      controller: companyController,
                      enabled: !(state is LoginLoading),
                      style: textTheme.bodyText2.copyWith(
                        color: Colors.yellow[700],
                      ),
                      decoration: InputDecoration(
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
                        hintText: 'Company code',
                        hintStyle: textTheme.bodyText2.copyWith(
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
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
                        hintText: 'Select Country',
                        hintStyle: textTheme.bodyText2.copyWith(
                          color: Colors.black38,
                        ),
                      ),
                      value: countryCode == '' ? null : countryCode,
                      onChanged: (newValue) {
                        setState(() {
                          countryCode = newValue;
                          final index = countries.indexWhere(
                              (element) => element['iso3'] == countryCode);
                          states.clear();
                          states = countries[index]['states'];
                          stateCode = "";
                        });
                      },
                      items: countries.map((item) {
                        return DropdownMenuItem(
                          value: item['iso3'],
                          child: Text(
                            item['name'],
                            style: TextStyle(color: Colors.black87),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
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
                        hintText: 'State/Province',
                        hintStyle: textTheme.bodyText2.copyWith(
                          color: Colors.black38,
                        ),
                      ),
                      value: stateCode == '' ? null : stateCode,
                      onChanged: (newValue) {
                        setState(() {
                          stateCode = newValue;
                        });
                      },
                      items: states.map((item) {
                        return DropdownMenuItem(
                          value: item['state_code'],
                          child: Text(
                            item['name'],
                            style: TextStyle(color: Colors.black87),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: cityController,
                      enabled: !(state is LoginLoading),
                      style: textTheme.bodyText2.copyWith(
                        color: Colors.yellow[700],
                      ),
                      decoration: InputDecoration(
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
                        hintText: 'City',
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
                      controller: addressController,
                      enabled: !(state is LoginLoading),
                      style: textTheme.bodyText2.copyWith(
                        color: Colors.yellow[700],
                      ),
                      decoration: InputDecoration(
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
                        hintText: 'Address',
                        hintStyle: textTheme.bodyText2.copyWith(
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  RoundedButton(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    height: 50.0,
                    radius: 5.0,
                    onPressed:
                        state is LoginLoading ? null : onRegisterButtonPressed,
                    text: state is LoginLoading
                        ? 'Registering'.toUpperCase()
                        : 'Register'.toUpperCase(),
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
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(
                        context, LoginPage.route),
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          'Already have an account?',
                          style: GoogleFonts.karla(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.normal),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Sign In',
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
                  SizedBox(height: 40),
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
                'Register',
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
