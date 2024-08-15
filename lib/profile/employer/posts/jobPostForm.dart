import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/post_model.dart';
import '../../../services/remote_services.dart';
import 'package:intl/intl.dart';

class JobPostForm extends StatefulWidget {
  final String empId;

  const JobPostForm({Key? key, required this.empId}) : super(key: key);

  @override
  State<JobPostForm> createState() => _JobPostFormState();
}

class _JobPostFormState extends State<JobPostForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String jobTitle = '';
  String jobDescription = '';
  String jobLocation = '';
  String salary = '';
  DateTime? applyBefore;
  List<String> benefits = [];
  String education = '';
  String jobRequirements = '';
  String experience = '';
  List<String> skills = [];
  String employementType = '';
  String workType = '';
  String position = '';

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final post = Post(
        jobId: '', // Not used for creation
        logoUrl: '', // Not used for creation
        jobTitle: jobTitle,
        jobDescription: jobDescription,
        jobLocation: jobLocation,
        salary: salary,
        applyBefore: applyBefore?.toIso8601String() ?? '',
        daysRemaining: '', // Not used for creation
        numApplicants: 0, // Not used for creation
        benefits: benefits,
        education: education,
        jobRequirements: jobRequirements,
        experience: experience,
        skills: skills,
        employementType: employementType,
        workType: workType,
        position: position,
      );

      try {
        final jobPostService = RemoteServices();
        await jobPostService.createJobPost(widget.empId, post);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Job post created successfully!')),
        );
        Navigator.of(context).pop(); // Go back to the previous page
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create job post: $e')),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null && selectedDate != applyBefore) {
      setState(() {
        applyBefore = selectedDate;
      });
    }
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
                      'Create Job Post',
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
                    'Fill Out Job Details',
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
                      "Provide details about the job posting including the position, requirements, and benefits.",
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
              Container(
                margin: EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextFormField(
                        label: 'Job Title',
                        hintText: 'Enter Job Title',
                        onSave: (value) {
                          jobTitle = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Job Title';
                          }
                          return null;
                        },
                      ),
                      buildTextFormField(
                        label: 'Job Description',
                        hintText: 'Enter Job Description',
                        onSave: (value) {
                          jobDescription = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Job Description';
                          }
                          return null;
                        },
                      ),
                      buildTextFormField(
                        label: 'Job Location',
                        hintText: 'Enter Job Location',
                        onSave: (value) {
                          jobLocation = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Job Location';
                          }
                          return null;
                        },
                      ),
                      buildTextFormField(
                        label: 'Salary',
                        hintText: 'Enter Salary',
                        onSave: (value) {
                          salary = value ?? '';
                        },
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Apply Before',
                              hintText: applyBefore == null
                                  ? 'Select Apply Before Date'
                                  : DateFormat('yyyy-MM-dd')
                                      .format(applyBefore!),
                              suffixIcon: Icon(Icons.calendar_today),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(10.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (applyBefore == null) {
                                return 'Please select Apply Before Date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildTextFormField(
                        label: 'Benefits',
                        hintText: 'Enter Benefits (comma-separated)',
                        onSave: (value) {
                          benefits =
                              value?.split(',').map((s) => s.trim()).toList() ??
                                  [];
                        },
                      ),
                      buildTextFormField(
                        label: 'Education',
                        hintText: 'Enter Required Education',
                        onSave: (value) {
                          education = value ?? '';
                        },
                      ),
                      buildTextFormField(
                        label: 'Job Requirements',
                        hintText: 'Enter Job Requirements',
                        onSave: (value) {
                          jobRequirements = value ?? '';
                        },
                      ),
                      buildTextFormField(
                        label: 'Experience',
                        hintText: 'Enter Experience Required',
                        onSave: (value) {
                          experience = value ?? '';
                        },
                      ),
                      buildTextFormField(
                        label: 'Skills',
                        hintText: 'Enter Skills Required (comma-separated)',
                        onSave: (value) {
                          skills =
                              value?.split(',').map((s) => s.trim()).toList() ??
                                  [];
                        },
                      ),
                      buildTextFormField(
                        label: 'Employment Type',
                        hintText: 'Enter Employment Type',
                        onSave: (value) {
                          employementType = value ?? '';
                        },
                      ),
                      buildTextFormField(
                        label: 'Work Type',
                        hintText: 'Enter Work Type',
                        onSave: (value) {
                          workType = value ?? '';
                        },
                      ),
                      buildTextFormField(
                        label: 'Position',
                        hintText: 'Enter Position',
                        onSave: (value) {
                          position = value ?? '';
                        },
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF130160),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _submitForm,
                          child: Text(
                            'Submit',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
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
    required FormFieldSetter<String> onSave,
    FormFieldValidator<String>? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: buildInputDecoration(hintText),
        style: TextStyle(
          fontFamily: 'DM Sans',
          fontSize: 12.0,
        ),
        onSaved: onSave,
        validator: validator,
      ),
    );
  }
}
