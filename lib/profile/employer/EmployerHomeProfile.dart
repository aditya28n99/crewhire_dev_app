import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/employer_model.dart';
import '../../../services/remote_services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmployerHomeProfile extends StatefulWidget {
  const EmployerHomeProfile({super.key});

  @override
  State<EmployerHomeProfile> createState() => _EmployerHomeProfileState();
}

class _EmployerHomeProfileState extends State<EmployerHomeProfile> {
  late Future<Employer> _employerProfile;

  @override
  void initState() {
    super.initState();
    _employerProfile = RemoteServices.fetchEmployerProfile(
        '068979ad-8d63-41a0-b95c-3d9fcfd1a432');
  }

  Widget _buildProfileImage(Employer employer) {
    return Column(
      children: [
        Container(
          width: 95,
          height: 97.64,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                "", // Add image URL here
                width: 95,
                height: 97.64,
                fit: BoxFit.cover,
                // Handle image loading and errors
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.error, color: Colors.red),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: 250,
          height: 22,
          alignment: Alignment.center,
          child: Text(
            ' ${employer.companyName}',
            style: GoogleFonts.dmSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.015,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis, // Handle overflow
            maxLines: 1, // Limit text to 1 line
          ),
        ),
      ],
    );
  }

  Widget _buildLocationInfo(Employer employer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          // Use Expanded to avoid overflow
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${employer.officeLocationAddress.address1} ${employer.officeLocationAddress.address2}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis, // Handle overflow
                  maxLines: 2, // Limit text to 2 lines
                ),
                SizedBox(height: 5),
                Text(
                  '${employer.officeLocationAddress.city} ${employer.officeLocationAddress.state} ${employer.officeLocationAddress.country}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis, // Handle overflow
                  maxLines: 2, // Limit text to 2 lines
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  launch('${employer.websiteLink}');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black12,
                ),
                child: Text("Visit Website"),
              ),
              Wrap(
                spacing: 8.0, // Space between icons horizontally
                runSpacing: 8.0, // Space between icons vertically
                children: [
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.instagram),
                    color: Colors.red,
                    iconSize: 20.0,
                    onPressed: () {
                      launch('${employer.socialMediaHandles.instagram}');
                    },
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.youtube),
                    color: Colors.red,
                    iconSize: 20.0,
                    onPressed: () {
                      launch('${employer.socialMediaHandles.youtube}');
                    },
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.facebook),
                    color: Colors.blue,
                    iconSize: 20.0,
                    onPressed: () {
                      launch('${employer.socialMediaHandles.facebook}');
                    },
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.twitter),
                    color: Colors.lightBlue,
                    iconSize: 20.0,
                    onPressed: () {
                      launch('${employer.socialMediaHandles.twitter}');
                    },
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.linkedin),
                    color: Colors.blue,
                    iconSize: 20.0,
                    onPressed: () {
                      launch('${employer.socialMediaHandles.linkedIn}');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: Text('Employer Profile')),
      body: SafeArea(
        child: FutureBuilder<Employer>(
          future: _employerProfile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              var employer = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF7551FF),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(height: 10),
                            ],
                          ),
                          _buildProfileImage(employer),
                          _buildLocationInfo(employer),
                        ],
                      ),
                    ),
                    _buildAboutSection(employer),
                    _buildContactSection(employer),
                    _buildLocationSection(employer), // Added location section
                    _buildIndustrySection(employer), // Added industry section
                    _buildSinceSection(employer), // Added since section
                    _buildAchievementsSection(
                        employer), // Added achievements section
                    _buildGallerySection(employer)
                  ],
                ),
              );
            }
            return Container(); // Should never reach here
          },
        ),
      ),
    );
  }
}

// Reusable Widgets for different sections

Widget _buildAboutSection(Employer employer) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "About Company",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(10),
                child: Text('${employer.aboutCompany}'),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildContactSection(Employer employer) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Contact",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  '${employer.contact.mobile}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  '${employer.contact.email}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildLocationSection(Employer employer) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Office Location",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  '${employer.officeLocationAddress.address1} ${employer.officeLocationAddress.address2} ${employer.officeLocationAddress.city} ${employer.officeLocationAddress.state} ${employer.officeLocationAddress.country}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildIndustrySection(Employer employer) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Industry Type",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  '${employer.industryType}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildSinceSection(Employer employer) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Since",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  '${employer.since}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildAchievementsSection(Employer employer) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Awards and Achievements",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      Column(
        children: employer.awardsAndAchievemets.map((achievement) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10), // Add margin between items
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    achievement.issuerOrOrganization,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    achievement.category,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  // ignore: unnecessary_null_comparison
                  achievement.uploadImage != null
                      ? Image.network(
                          achievement.uploadImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.error, color: Colors.red),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(child: CircularProgressIndicator());
                          },
                        )
                      : Container(),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ],
  );
}

Widget _buildGallerySection(Employer employer) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Gallery",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      employer.companyPhotos.isNotEmpty
          ? Column(
              children: employer.companyPhotos.map((photo) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(10),
                    margin:
                        EdgeInsets.only(bottom: 10), // Add margin between items
                    child: Image.network(
                      photo,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.error, color: Colors.red),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                );
              }).toList(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text("No photos available"),
            ),
    ],
  );
}
