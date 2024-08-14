import 'package:flutter/material.dart';
import 'dart:ui'; // Addded this import for ImageFilter
import 'package:google_fonts/google_fonts.dart';
// import '../../validation/otp_validation.dart';

class EmployerInfo extends StatefulWidget {
  const EmployerInfo({Key? key}) : super(key: key);

  @override
  State<EmployerInfo> createState() => _EmployerInfoState();
}

class _EmployerInfoState extends State<EmployerInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String companyName = '';
  String email = '';
  String country = '';
  String state = '';
  String city = '';
  String webLink = '';
  String description = '';

  bool isIndividual =
      false; // Flag to track if the employer is individual or company

  // Function to navigate to the selected page
  void navigateToPage() {
    // Navigate to the JobSeekerPage
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => OtpValidation(),
    // ));
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Now you can use the collected data as needed
      // companyName, email, country, state, city, webLink, description, gstnNumber all data
      // Clear the form fields
      _formKey.currentState?.reset();

      // Show confirmation dialog
      _showTermsAndConditionsDialog();
    }
  }

  void _showTermsAndConditionsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Terms and Conditions"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "I agree to the Term of Service and Conditions of Use including consent to electronic communications and I affirm that the information provided is my own.",
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Disagree'),
            ),
            ElevatedButton(
              onPressed:
                  //function for navigations
                  navigateToPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF130160),
              ),
              child: Text('Agree and Continue'),
            ),
          ],
        );
      },
    );
  }

  InputDecoration buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        fontFamily: 'DM Sans',
        color: Color(0xFF0D0140),
        fontSize: 12.0,
        height: 1.5,
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.all(10.0),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  TextStyle buildLabelStyle() {
    return TextStyle(
      fontFamily: 'DM Sans',
      fontSize: 12.0,
      fontWeight: FontWeight.w700,
      color: Color(0xFF130160),
      height: 1.33,
      letterSpacing: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Color(0xFF130160),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        iconSize: 25.0,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Employer Profile',
                      style: GoogleFonts.mooli(
                        color: Colors.blueGrey[800],
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Compleat Your Account',
                    style: GoogleFonts.plusJakartaSans(
                      color: Color(0xFF130160),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "A company profile includes the story of the company's founding and describes its products or services.",
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              // Adding the section to choose employer type as individual or companey..
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isIndividual = true;
                      });
                    },
                    child: Text(
                      'Individual',
                      style: TextStyle(
                        color: isIndividual ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isIndividual = false;
                      });
                    },
                    child: Text(
                      'Company',
                      style: TextStyle(
                        color: !isIndividual ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              // Form for individual or company based on the flag
              Container(
                margin: EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextFormField(
                        label: isIndividual ? 'Full Name' : 'Company Name',
                        hintText: isIndividual
                            ? 'Your Full Name'
                            : 'Company/Production/Agency/Full Name/etc',
                        onSave: (value) {
                          companyName = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return isIndividual
                                ? 'Please enter your full name'
                                : 'Please enter your company name';
                          }
                          return null;
                        },
                      ),
                      buildTextFormField(
                        label: 'Email',
                        hintText: 'your.email@example.com',
                        onSave: (value) {
                          email = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      buildTextFormField(
                        label: 'Country',
                        hintText: 'Enter your country',
                        onSave: (value) {
                          country = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Country is required';
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: buildTextFormField(
                              label: 'State',
                              hintText: 'Enter your state',
                              onSave: (value) {
                                state = value ?? '';
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'State is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: buildTextFormField(
                              label: 'City',
                              hintText: 'Enter your city',
                              onSave: (value) {
                                city = value ?? '';
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'City is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      buildTextFormField(
                        label: 'Web Link',
                        hintText: 'Enter your web link (if any)',
                        onSave: (value) {
                          webLink = value ?? '';
                        },
                      ),
                      buildTextFormField(
                        label: 'Description',
                        hintText:
                            'Enter a brief description about your company',
                        onSave: (value) {
                          description = value ?? '';
                        },
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF130160),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required String label,
    required String hintText,
    required Function(String?) onSave,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 15.0),
          child: Text(
            label,
            style: buildLabelStyle(),
          ),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          decoration: buildInputDecoration(hintText),
          style: TextStyle(fontSize: 16.0, color: Color(0xFF130160)),
          onTap: () {
            setState(() {});
          },
          validator: validator,
          onSaved: onSave,
        ),
      ],
    );
  }
}
