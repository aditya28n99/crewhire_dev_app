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
      mainAxisSize: MainAxisSize
          .min, // Make sure the column does not take more space than needed
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
        SizedBox(height: 8), // Increased space between image and text
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            // Center the text horizontally
            child: Text(
              employer.companyName,
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87, // Updated color for better visibility
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationInfo(Employer employer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
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
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(height: 5),
                Text(
                  '${employer.officeLocationAddress.city}, ${employer.officeLocationAddress.state}, ${employer.officeLocationAddress.country}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
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
              SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  if (employer.socialMediaHandles.instagram.isNotEmpty)
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.instagram),
                      color: Colors.red,
                      iconSize: 20.0,
                      onPressed: () {
                        launch('${employer.socialMediaHandles.instagram}');
                      },
                    ),
                  if (employer.socialMediaHandles.youtube.isNotEmpty)
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.youtube),
                      color: Colors.red,
                      iconSize: 20.0,
                      onPressed: () {
                        launch('${employer.socialMediaHandles.youtube}');
                      },
                    ),
                  if (employer.socialMediaHandles.facebook.isNotEmpty)
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.facebook),
                      color: Colors.blue,
                      iconSize: 20.0,
                      onPressed: () {
                        launch('${employer.socialMediaHandles.facebook}');
                      },
                    ),
                  if (employer.socialMediaHandles.twitter.isNotEmpty)
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.twitter),
                      color: Colors.lightBlue,
                      iconSize: 20.0,
                      onPressed: () {
                        launch('${employer.socialMediaHandles.twitter}');
                      },
                    ),
                  if (employer.socialMediaHandles.linkedIn.isNotEmpty)
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
                          SizedBox(height: 10),
                          _buildProfileImage(employer),
                          _buildLocationInfo(employer),
                        ],
                      ),
                    ),
                    _buildAboutSection(employer),
                    _buildContactSection(employer),
                    _buildLocationSection(employer),
                    _buildIndustrySection(employer),
                    _buildSinceSection(employer),
                    _buildAchievementsSection(employer),
                    _buildGallerySection(employer),
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

  // Reusable Widgets for different sections

  Widget _buildAboutSection(Employer employer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About Company",
            style: GoogleFonts.dmSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity, // Full width
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
              ],
            ),
            child: Text(
              '${employer.aboutCompany}',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(Employer employer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact",
            style: GoogleFonts.dmSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity, // Full width
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mobile: ${employer.contact.mobile}',
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Email: ${employer.contact.email}',
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection(Employer employer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Office Location",
            style: GoogleFonts.dmSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity, // Full width
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${employer.officeLocationAddress.address1}',
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '${employer.officeLocationAddress.address2}',
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '${employer.officeLocationAddress.city}, ${employer.officeLocationAddress.state}, ${employer.officeLocationAddress.country}',
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndustrySection(Employer employer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Industry",
            style: GoogleFonts.dmSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity, // Full width
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
              ],
            ),
            child: Text(
              '${employer.industryType}',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSinceSection(Employer employer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Established Since",
            style: GoogleFonts.dmSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity, // Ensure it takes full width
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
              ],
            ),
            child: Text(
              '${employer.since}',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsSection(Employer employer) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Awards & Achievements",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var award in employer.awardsAndAchievemets)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        if (award.uploadImage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Image.network(
                              award.uploadImage,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                award.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Issued by: ${award.issuerOrOrganization}',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Category: ${award.category}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGallerySection(Employer employer) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Company Photos",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: employer.companyPhotos.length,
              itemBuilder: (context, index) {
                return Image.network(
                  employer.companyPhotos[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
