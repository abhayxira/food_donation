import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_donation/utils/appThems.dart';

class NGODetailsPage extends StatelessWidget {
  const NGODetailsPage({super.key});

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ' Ngo Detiled',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: AppColor.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColor.appbarColors,
            ),
          ),
        ),
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/food donation.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bridges Of Understanding',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Est. 1984',
                      style: TextStyle(color: AppColor.grey),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage('images/ngologo/logo1.jpg'),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Founder of NGO'),
                              Text(
                                'Ashish Agrawal',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: const Text('About me'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'About NGO',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.',
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star_outline, color: Colors.orange),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Icon(Icons.people, color: AppColor.ornage),
                        SizedBox(width: 8),
                        Text('Served over 1k+ people'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.phone, color: AppColor.ornage),
                        const SizedBox(width: 8),
                        const Text('91+ 9123456789'),
                        IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () =>
                              _copyToClipboard(context, '91+ 9123456789'),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.ornage,
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text(
            'Select NGO',
            style: TextStyle(fontSize: 18, color: AppColor.white),
          ),
        ),
      ),
    );
  }
}
