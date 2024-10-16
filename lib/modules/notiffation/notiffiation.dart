import 'package:flutter/material.dart';
import 'package:food_donation/utils/appThems.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationItem> notifications = [
    NotificationItem(
      imageUrl: 'assets/accepted.png',
      title: 'images/men/men.jpg',
      description:
          'Helping hands has accepted your request and arriving to take the food.',
      timeAgo: '2 min',
      fullContent:
          'Helping hands organization has accepted your food donation request. They are currently on their way to collect the food from your specified location. Please ensure the food is properly packed and ready for pickup. Thank you for your generosity!',
    ),
    NotificationItem(
      imageUrl: 'images/men/men2.jpg',
      title: 'Donation Requested',
      description:
          'You have sent a food donation request for helpers on the way.',
      timeAgo: '6 min',
      fullContent:
          'Your food donation request has been successfully submitted. We are currently searching for nearby NGOs and volunteers who can collect your donation. You will receive an update once a helper accepts your request. Thank you for your contribution to fighting hunger!',
    ),
    NotificationItem(
        imageUrl: 'images/men/men3.jpg',
        title: 'Happy Stomachs',
        description: 'You have donated 50 meals today and made their day.',
        timeAgo: '10 min',
        fullContent:
            'Congratulations! Your recent food donation has provided 50 meals to those in need. Your generosity has made a significant impact on our community. Here'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColor.white,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: AppColor.appbarColors,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _buildSearchBar(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildNotificationCard(notifications[index]),
              childCount: notifications.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search notifications...',
          hintStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: AppColor.ornage.withOpacity(0.5), width: 1),
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(notification.imageUrl),
        ),
        title: Text(
          notification.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification.description,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              notification.timeAgo,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              notification.fullContent,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Handle action button press
                  },
                  child: const Text('View Details',
                      style: TextStyle(color: AppColor.ornage)),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () {
                    // Handle delete notification
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItem {
  final String imageUrl;
  final String title;
  final String description;
  final String timeAgo;
  final String fullContent;

  NotificationItem({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.fullContent,
  });
}
