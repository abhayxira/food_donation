import 'package:flutter/material.dart';
import 'package:food_donation/utils/appThems.dart';

class Ngo {
  final String name;
  final double rating;
  final int reviewsCount;
  final String imageUrl;
  final String description;

  Ngo({
    required this.name,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    required this.description,
  });
}

class NgoListScreen extends StatefulWidget {
  const NgoListScreen({super.key});

  @override
  _NgoListScreenState createState() => _NgoListScreenState();
}

class _NgoListScreenState extends State<NgoListScreen> {
  final List<Ngo> _allNgos = [
    Ngo(
      name: 'Creative People NGO',
      rating: 4.0,
      reviewsCount: 51,
      imageUrl: 'images/ngologo/logo1.jpg',
      description:
          'An NGO focused on community development and providing support to underprivileged areas. We work on various projects including education, healthcare, and environmental sustainability.',
    ),
    Ngo(
      name: 'Helping Hands',
      rating: 4.5,
      reviewsCount: 88,
      imageUrl: 'images/ngologo/logo2.jpg',
      description:
          'Providing help to underprivileged families through food donation drives, educational programs, and skill development workshops.',
    ),
    Ngo(
      name: 'Global Health Initiative',
      rating: 3.5,
      reviewsCount: 150,
      imageUrl: 'images/ngologo/logo4.jpg',
      description:
          'A leading organization delivering health and sanitation services to impoverished areas, focusing on combatting diseases like malaria and cholera.',
    ),

    Ngo(
      name: 'Bright Futures',
      rating: 4.4,
      reviewsCount: 110,
      imageUrl: 'images/ngologo/logo5.jpg',
      description:
          'A youth-focused NGO helping young people in marginalized communities gain access to education and career opportunities.',
    ),
    // Add more NGOs here...
  ];

  List<Ngo> _filteredNgos = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredNgos = _allNgos;
  }

  void _filterNgos(String query) {
    setState(() {
      _filteredNgos = _allNgos
          .where((ngo) =>
              ngo.name.toLowerCase().contains(query.toLowerCase()) ||
              ngo.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
          //     title: Text('NGO List'),
          //     background: Container(
          //       decoration: BoxDecoration(
          //         gradient: LinearGradient(
          //           begin: Alignment.topLeft,
          //           end: Alignment.bottomRight,
          //           colors: AppColor.appbarColors,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
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
                  // controller: _searchController,

                  controller: _searchController,
                  onChanged: _filterNgos,
                  decoration: InputDecoration(
                    hintText: 'Search buildings...',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: TextField(
            //     controller: _searchController,
            //     onChanged: _filterNgos,
            //     decoration: InputDecoration(
            //       hintText: 'Search NGOs...',
            //       hintStyle: TextStyle(color: AppColor.black),
            //       prefixIcon: Icon(Icons.search),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(12),
            //         borderSide: BorderSide(
            //           color: Colors.blue, // Set your desired border color here
            //         ),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(12),
            //         borderSide: BorderSide(
            //           color: AppColor
            //               .ornage, // Border color when the TextField is enabled
            //         ),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(12),
            //         borderSide: BorderSide(
            //           color: Colors
            //               .orange, // Border color when the TextField is focused
            //           width:
            //               2.0, // Optional: Make the border thicker when focused
            //         ),
            //       ),
            //       fillColor: AppColor.ornage, // Replace with your color
            //     ),
            //   ),
            // ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return NgoCard(
                  ngo: _filteredNgos[index],
                  onTap: () => _showNgoDetails(_filteredNgos[index]),
                );
              },
              childCount: _filteredNgos.length,
            ),
          ),
        ],
      ),
    );
  }

  void _showNgoDetails(Ngo ngo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.white,
      builder: (context) => NgoDetailsSheet(ngo: ngo),
    );
  }
}

class NgoCard extends StatelessWidget {
  final Ngo ngo;
  final VoidCallback onTap;

  const NgoCard({super.key, required this.ngo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  ngo.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ngo.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ngo.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          '${ngo.rating.toStringAsFixed(1)} (${ngo.reviewsCount} reviews)',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NgoDetailsSheet extends StatelessWidget {
  final Ngo ngo;

  const NgoDetailsSheet({super.key, required this.ngo});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        ngo.imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ngo.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                '${ngo.rating.toStringAsFixed(1)} (${ngo.reviewsCount} reviews)',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'About',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  ngo.description,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(Icons.call, 'Call', () {}),
                    _buildActionButton(Icons.chat, 'Chat', () {}),
                    _buildActionButton(Icons.email, 'Email', () {}),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement see more functionality
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.ornage,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    'See More',
                    style: TextStyle(color: AppColor.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: AppColor.ornage),
          onPressed: onPressed,
        ),
        Text(label, style: const TextStyle(color: AppColor.ornage)),
      ],
    );
  }
}
