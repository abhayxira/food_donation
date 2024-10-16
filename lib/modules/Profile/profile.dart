import 'package:flutter/material.dart';
import 'package:food_donation/modules/Ngo/ngoui.dart';
import 'package:food_donation/modules/donation/donation.dart';
import 'package:food_donation/modules/login/auth.dart';
import 'package:food_donation/modules/notiffation/notiffiation.dart';
import 'package:food_donation/utils/appThems.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3; // Assuming profile is the 4th tab

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FoodDonationForm()));
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NgoListScreen()));
    }
    // No need to navigate to ProfilePage if already here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   expandedHeight: 200.0,
          //   floating: false,
          //   pinned: true,
          //   flexibleSpace: FlexibleSpaceBar(
          //     background: Container(
          //       decoration: BoxDecoration(
          //         gradient: LinearGradient(
          //           begin: Alignment.topLeft,
          //           end: Alignment.bottomRight,
          //           colors: AppColor.appbarColors,
          //         ),
          //       ),
          //     ),
          //     title: Text(
          //       'Profile',
          //       style: TextStyle(
          //         fontSize: 22,
          //         fontWeight: FontWeight.bold,
          //         color: AppColor.white,
          //       ),
          //     ),
          //     centerTitle: true,
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileHeader(),
                  const SizedBox(height: 24),
                  _buildDashboardCard(),
                  const SizedBox(height: 24),
                  _buildMenuOptions(),
                  const SizedBox(height: 24),
                  _buildRecentDonations(),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   backgroundColor: Colors.white,
      //   selectedItemColor: AppColor.ornage,
      //   unselectedItemColor: AppColor.grey,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Donate'),
      //     BottomNavigationBarItem(icon: Icon(Icons.group), label: 'NGOs'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //   ],
      // ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 80, // Diameter of the CircleAvatar (2 * radius)
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.white, // Background color
                image: DecorationImage(
                  image: AssetImage('images/profile.png'),
                  fit: BoxFit
                      .cover, // Apply fit here (BoxFit.cover, BoxFit.contain, etc.)
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Abhay',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '0845-3243-2324',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: AppColor.ornage),
              onPressed: () {
                //Navigate to edit profile page
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColor.ornage, AppColor.LightOrnage],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Impact',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatItem('Total Donations', '15'),
                _buildStatItem('Meals Donated', '150'),
              ],
            ),
            const SizedBox(height: 16),
            LinearPercentIndicator(
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2000,
              percent: 0.7,
              center: const Text(
                "70.0%",
                style: TextStyle(
                    color: AppColor.white, fontWeight: FontWeight.bold),
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: AppColor.white,
              backgroundColor: AppColor.ornage.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColor.white,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: AppColor.white,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuOptions() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          _buildMenuItem(Icons.track_changes_outlined, 'Tracking', () {}),
          const Divider(),
          _buildMenuItem(Icons.notifications, 'Notifications', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NotificationPage()));
          }),
          const Divider(),
          _buildMenuItem(Icons.food_bank, 'Donation History', () {}),
          const Divider(),
          _buildMenuItem(
              Icons.connected_tv_outlined, 'Terms And Conditions', () {}),
          const Divider(),
          _buildMenuItem(Icons.man_2, 'Change Role', () {}),
          const Divider(),
          _buildMenuItem(Icons.logout, 'Logout', () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const AuthPage()));
          }, textColor: Colors.red),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap,
      {Color textColor = Colors.black}) {
    return ListTile(
      leading: Icon(icon, color: AppColor.ornage),
      title: Text(title, style: TextStyle(color: textColor)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildRecentDonations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Donations',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColor.black,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildDonationCard('12/04/2024', 2, 'images/food donation.jpg'),
              const SizedBox(width: 16),
              _buildDonationCard('10/04/2024', 1, 'images/food donation2.jpg'),
              const SizedBox(width: 16),
              _buildDonationCard('12/07/2024', 4, 'images/food donation3.jpg'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDonationCard(String date, int families, String imagePath) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Donated on',
                  style: TextStyle(fontSize: 12, color: AppColor.grey),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Helped $families ${families == 1 ? 'family' : 'families'}',
                  style: const TextStyle(fontSize: 12, color: AppColor.ornage),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
