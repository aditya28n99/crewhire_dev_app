import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../profile/employer/EmployerHomeProfile.dart';
// import '../profile/JobseekerProfile/jobseeker_info.dart';

class ChooseProfileScreen extends StatefulWidget {
  const ChooseProfileScreen({super.key});

  @override
  State<ChooseProfileScreen> createState() => _ChooseProfileScreenState();
}

class _ChooseProfileScreenState extends State<ChooseProfileScreen> {
  int selectedProfileIndex = -1; // Track the selected profile

  // Function to handle profile selection
  void handleProfileSelection(int index) {
    setState(() {
      selectedProfileIndex = index;
    });
    print('Selected Profile: ${index == 0 ? 'Employer' : 'Job Seeker'}');
  }

  // Function to navigate to the selected page
  void navigateToPage() {
    if (selectedProfileIndex == 0) {
      // Navigate to the EmployerPage
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EmployerHomeProfile(),
      ));
    } else if (selectedProfileIndex == 1) {
      // Navigate to the JobSeekerPage
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => JobseekerInfo(),
      // ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
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
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                      iconSize: 25.0,
                      onPressed: () {
                        // Navigator.of(context).pop(); // we can add it later.
                      },
                    ),
                  ),
                ),
                Container(
                  child: Text('Choose Profile',
                      style: GoogleFonts.mooli(
                        color: Colors.blueGrey[800],
                        fontSize: 22,
                      )),
                )
              ],
            ),
            SizedBox(height: 50),
            Column(
              children: [
                Text(
                  'Choose Job Type',
                  style: GoogleFonts.plusJakartaSans(
                      color: Color(0xFF130160),
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: Text(
                    'Are you looking for a new job or looking for new employee',
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyHoverContainer(
                  index: 0,
                  selected: selectedProfileIndex == 0,
                  onTap: handleProfileSelection,
                  icon: Icons.work_outline_outlined,
                  iconcolor: Color.fromARGB(255, 242, 108, 5),
                  title: 'Employer',
                  description:
                      "It's easy to post a job and find your employee/crew members.",
                ),
                SizedBox(
                  width: 10,
                ),
                MyHoverContainer(
                  index: 1,
                  selected: selectedProfileIndex == 1,
                  onTap: handleProfileSelection,
                  icon: Icons.person_outline_outlined,
                  iconcolor: Color.fromARGB(255, 242, 108, 5),
                  title: 'Job Seeker',
                  description:
                      "It's easy to find your dream jobs here with us.",
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              width: 280,
              height: 50,
              child: ElevatedButton(
                onPressed:
                    //function for navigations
                    navigateToPage, // Navigate to the selected page
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF130160),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Adjust the border radius
                  ),
                ),
                child: Text('Continue'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyHoverContainer extends StatelessWidget {
  final int index;
  final bool selected;
  final IconData icon;
  final Color iconcolor;
  final String title;
  final String description;
  final Function(int) onTap;

  MyHoverContainer({
    required this.index,
    required this.selected,
    required this.onTap,
    required this.icon,
    required this.iconcolor,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index), // Call the onTap function with the index
      child: Container(
        height: 229,
        width: 166,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: selected ? Color(0xFFD6CDFE) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 58, 38, 38),
              blurRadius: 7,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 32,
              backgroundColor: selected
                  ? Color.fromARGB(255, 221, 251, 241)
                  : Colors.orange[50],
              child: Icon(
                icon,
                color: selected ? Color.fromARGB(255, 3, 211, 145) : iconcolor,
                size: 30,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF130160),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                description,
                style: TextStyle(
                  color: selected ? Colors.grey[700] : Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
