import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp_3dapp/components/custom_surfix_icon.dart';
import 'package:myapp_3dapp/components/default_button.dart';
import 'package:myapp_3dapp/components/form_error.dart';
import 'package:myapp_3dapp/services/authentication_service.dart';
import 'package:provider/src/provider.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

import 'package:open_location_code/open_location_code.dart' as olc;

class CompleteProfileForm extends StatefulWidget {

  final String temail;
  final String tpassword;

  CompleteProfileForm({this.temail, this.tpassword});

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  String firstName;
  String lastName;
  String phoneNumber;
  String addressPCode;
  String DOB;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController DOBController = TextEditingController();

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    /*
    final routeData = ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final email = routeData['email'];
    final password = routeData['password'];

     */

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildDOBField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "continue",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                //print("Inside CPF button");

                //print("email = ${widget.temail}");

                await context.read<AuthenticationService>().signUp(
                  email: widget.temail,
                  password: widget.tpassword,
                ).then((value){
                  User user = FirebaseAuth.instance.currentUser;
                  //print(User);
                    FirebaseFirestore.instance.collection("user_cred")
                        .doc(user.uid)
                        .set({
                      'Uid': user.uid,
                      'Email': widget.temail,
                      'Date Joined': "${user.metadata.creationTime}".substring(0,10),
                      'First Name' : firstNameController.text.trim(),
                      'Last Name' : lastNameController.text.trim(),
                      'Date of Birth' : DOBController.text.trim(),
                      'Address Latitude' : olc.decode("7JFJ" + addressPCode.split(' ').first).center.latitude.toString(),
                      'Address Longitude' : olc.decode("7JFJ" + addressPCode.split(' ').first).center.longitude.toString(),
                      'Phone Number' : phoneNumberController.text.trim(),
                      'Prev Test Date' : 'Unavailable',
                      'Prev Test Time'  : 'Unavailable',
                      'Prev Test Result' : 'Unavailable',
                    });
                }
                );

                /*
                await context.read<DatabaseService>().updateUserSignUpData(
                    user_uid: firebaseUser.uid,
                    email: firebaseUser.email,
                    first_name: firstNameController.text.trim(),
                    last_name: lastNameController.text.trim(),
                    address: addressController.text.trim(),
                    ph_number: phoneNumberController.text.trim(),
                );

                 */

                //Navigator.pushNamed(context, OtpScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildDOBField() {
    return TextFormField(
      onSaved: (newValue) => DOB = newValue,
      controller: DOBController,
      readOnly: true,
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
            context: context, initialDate: DateTime.now(),
            firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime.now()
        );

        if(pickedDate != null ){
          print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(formattedDate); //formatted date output using intl package =>  2021-03-16
          //you can implement different kind of Date Format here according to your requirement

          setState(() {
            DOBController.text = formattedDate; //set output date to TextField value.
          });
        }else{
          print("Date is not selected");
        }
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kDOBNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kDOBNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Date of Birth",
        hintText: "Pick your DOB",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => addressPCode = newValue,
      controller: addressController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address Plus Code",
        hintText: "Enter your Home Plus Code",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      controller: phoneNumberController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      controller: lastNameController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kLNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kLNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      controller: firstNameController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kFNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
