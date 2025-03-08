import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:page_transition/page_transition.dart';
import 'package:telsavideo/constants.dart';
import 'package:telsavideo/models/vo/signup/signup.dart';
import 'package:telsavideo/screens/signup/otp.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

@immutable
class Register extends StatefulWidget {
  SignUpVO? signUp;
  Register(this.signUp);
  @override
  State<StatefulWidget> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.3, 0.5, 0.7, 0.9],
                  colors: [
                    kBgColorTop.withOpacity(0.4),
                    kBgColorTop.withOpacity(0.55),
                    kBgColorBottom.withOpacity(0.7),
                    kBgColorBottom.withOpacity(0.8),
                    kBgColorBottom.withOpacity(1.0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: FormBuilder(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: EdgeInsets.only(left: 0.0),
                          child: Text(
                            'Create account',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        FormBuilderTextField(
                          name: 'full_name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.65)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.65)),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.65)),
                            ),
                          ),
                          // validator: FormBuilderValidators.compose([
                          //   FormBuilderValidators.required(context),
                          // ]),
                        ),
                        const SizedBox(height: 10),
                        FormBuilderTextField(
                          name: 'email',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.65)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.65)),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.65)),
                            ),
                          ),
                          // validator: FormBuilderValidators.compose([
                          //   FormBuilderValidators.required(context),
                          //   FormBuilderValidators.email(context),
                          // ]),
                        ),
                        const SizedBox(height: 10),
                        FormBuilderTextField(
                          name: 'password',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.65)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.65)),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.65)),
                            ),
                          ),
                          obscureText: true,
                          // validator: FormBuilderValidators.compose([
                          //   FormBuilderValidators.required(context),
                          //   FormBuilderValidators.minLength(context, 6),
                          // ]),
                        ),
                        const SizedBox(height: 10),
                        FormBuilderTextField(
                          name: 'confirm_password',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                            suffixIcon: (_formKey.currentState != null &&
                                    !(_formKey
                                            .currentState
                                            ?.fields['confirm_password']
                                            ?.isValid ??
                                        false))
                                ? const Icon(Icons.error, color: Colors.red)
                                : const Icon(Icons.check, color: Colors.green),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.65)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.65)),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.65)),
                            ),
                          ),
                          obscureText: true,
                          //   validator: FormBuilderValidators.compose([
                          //     /*FormBuilderValidators.equal(
                          // context,
                          // _formKey.currentState != null
                          //     ? _formKey.currentState.fields['password'].value
                          //     : null),*/
                          //     (val) {
                          //       if (val !=
                          //           _formKey.currentState?.fields['password']
                          //               ?.value) {
                          //         return 'Passwords do not match';
                          //       }
                          //       return null;
                          //     }
                          //   ]),
                        ),
                        const SizedBox(height: 10),
                        FormBuilderCheckbox(
                          name: 'term',
                          initialValue: true,
                          title: Text(
                            'I have read and accept the terms of service.',
                            style: TextStyle(color: Colors.white),
                          ),
                          // validator: FormBuilderValidators.compose([
                          //   FormBuilderValidators.required(context),
                          //   FormBuilderValidators.equal(context, true),
                          // ]),
                        ),
                        const SizedBox(height: 10),
                        MaterialButton(
                          minWidth: width,
                          color: Theme.of(context).colorScheme.secondary,
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: OTPScreen()));
                            if (_formKey.currentState?.saveAndValidate() ??
                                false) {
                              print('Valid');
                            } else {
                              print('Invalid');
                            }
                            print(_formKey.currentState?.value);
                          },
                          child: Text('Signup',
                              style: TextStyle(color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            /*
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Create account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200]!.withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: TextField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20.0),
                          hintText: 'Username',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200]!.withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: TextField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20.0),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200]!.withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: TextField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20.0),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200]!.withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: TextField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20.0),
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30.0),
                      onTap: () {
                        //print(signUp!.mobile);
                        /* Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: OTPScreen())); */
                      },
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.bottomRight,
                            stops: [0.1, 0.5, 0.9],
                            colors: [
                              /* Colors.red[300]!.withOpacity(0.8),
                              Colors.red[500]!.withOpacity(0.8),
                              Colors.red[800]!.withOpacity(0.8), */
                              kButtomColor.withOpacity(0.8),
                              kButtomColor.withOpacity(0.8),
                              kButtomColor.withOpacity(0.8),
                            ],
                          ),
                        ),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ), */
          ),
        ],
      ),
    );
  }
}
