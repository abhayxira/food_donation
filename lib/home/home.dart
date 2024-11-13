import 'package:flutter/material.dart';
import 'package:food_donation/modules/Ngo/ngoui.dart';
import 'package:food_donation/modules/Profile/profile.dart';
import 'package:food_donation/modules/donation/donation.dart';
import 'package:food_donation/modules/notiffation/notiffiation.dart';
//import 'package:food_donation/modules/notification/notification.dart';
//import 'package:food_donation/utils/appThemes.dart';
import 'package:food_donation/utils/appThems.dart';
//import 'package:food_donation/utils/greeting.dart';
//import 'package:fl_chart/fl_chart.dart';
import 'package:food_donation/utils/greting.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
//import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool _showDashboard = false;
  bool _showDonationBox = false;
  bool _showRecentDonation = false;
  bool _showNgoList = false;

  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _slowLoadUI();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _slowLoadUI() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() => _showDashboard = true);
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() => _showDonationBox = true);
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() => _showRecentDonation = true);
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() => _showNgoList = true);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: AppColor.ornage),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColor.ornage),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationPage()),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildHomeTab(),
          const  FoodDonationForm(),
          const  NgoListScreen(),
          const  ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        indicatorColor: AppColor.ornage,
        labelColor: AppColor.ornage,
        unselectedLabelColor: AppColor.grey,
        tabs: const [
          Tab(icon: Icon(Icons.home), text: 'Home'),
          Tab(icon: Icon(Icons.favorite), text: 'Donate'),
          Tab(icon: Icon(Icons.group), text: 'NGOs'),
          Tab(icon: Icon(Icons.person), text: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnimatedOpacity(_showDashboard, _buildPersonalizedDashboard()),
          const SizedBox(height: 24),
          _buildAnimatedOpacity(_showDonationBox, _buildDonationBox()),
          const SizedBox(height: 24),
          _buildAnimatedOpacity(
              _showRecentDonation, _buildRecentDonationSection()),
          const SizedBox(height: 24),
          if (_showNgoList) _buildNgoListSection(context),
        ],
      ),
    );
  }

  Widget _buildAnimatedOpacity(bool show, Widget child) {
    return AnimatedOpacity(
      opacity: show ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: child,
    );
  }

  Widget _buildPersonalizedDashboard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColor.ornage, AppColor.LightOrnage],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${Utils.greeting()}, Abhay!',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard('Total Donations', '15'),
              _buildStatCard('Meals Donated', '150'),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Your Impact',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.white,
            ),
          ),
          const SizedBox(height: 8),
          LinearPercentIndicator(
            animation: true,
            animationDuration: 1000,
            lineHeight: 20.0,
            percent: 0.7,
            center: const Text(
              "70.0%",
              style:
                  TextStyle(color: AppColor.white, fontWeight: FontWeight.bold),
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: AppColor.white,
            backgroundColor: AppColor.ornage.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: AppColor.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationBox() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Every Meal, A New Hope',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColor.ornage,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Join Us in Making a Difference',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: AppColor.LightOrnage,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    'images/food_bowl.png',
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.ornage,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Over',
                      style: TextStyle(color: AppColor.white, fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          '10,000',
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const FoodDonationForm()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Donate now',
                            style: TextStyle(
                                color: AppColor.ornage,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'meals served this month',
                      style: TextStyle(color: AppColor.white, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentDonationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Donations',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColor.black,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildDonationCard('12/04/2024', 2, 'images/food donation.jpg'),
              const SizedBox(width: 16),
              _buildDonationCard('10/04/2024', 1, 'images/food donation2.jpg'),
              const SizedBox(width: 16),
              _buildDonationCard('12/07/2024', 4, 'images/food donation3.jpg'),
              const SizedBox(width: 16),
              _buildDonationCard('26/08/2024', 8, 'images/food donation.jpg')
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDonationCard(String date, int families, String imagePath) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              imagePath,
              height: 120,
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
                  style: TextStyle(fontSize: 14, color: AppColor.grey),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Helped $families ${families == 1 ? 'family' : 'families'}',
                  style: const TextStyle(fontSize: 14, color: AppColor.ornage),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNgoListSection(BuildContext context) {
    List<Map<String, dynamic>> ngoData = [
      {
        'name': 'Helping Hands',
        'image': 'images/ngologo/logo1.jpg',
        'description': 'Providing food to those in need',
        'rating': 4.8,
      },
      {
        'name': 'Green Earth',
        'image': 'images/ngologo/logo2.jpg',
        'description': 'Promoting sustainable living',
        'rating': 4.6,
      },
      {
        'name': 'Save the Children',
        'image': 'images/ngologo/logo3.jpg',
        'description': 'Supporting children\'s rights',
        'rating': 4.9,
      },
      {
        'name': 'Hope Foundation',
        'image': 'images/ngologo/logo1.jpg',
        'description': 'Building a better future',
        'rating': 4.7,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Top NGOs',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColor.black,
              ),
            ),
            TextButton(
              onPressed: () {
                _tabController.animateTo(2); // Switch to NGO tab
              },
              child: const Text(
                'See All',
                style: TextStyle(color: AppColor.ornage, fontSize: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ngoData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  width: 220,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.asset(
                          ngoData[index]['image'],
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 120,
                              color: Colors.grey[300],
                              child: Center(
                                child: Icon(Icons.image_not_supported,
                                    color: Colors.grey[500]),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ngoData[index]['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColor.ornage,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              ngoData[index]['description'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 18),
                                const SizedBox(width: 4),
                                Text(
                                  '${ngoData[index]['rating']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
