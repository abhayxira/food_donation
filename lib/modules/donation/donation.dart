import 'package:flutter/material.dart';
import 'package:food_donation/modules/Ngo/ngoui.dart';
import 'package:food_donation/modules/Profile/profile.dart';
//import 'package:food_donation/utils/appThemes.dart';
import 'package:food_donation/utils/appThems.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FoodDonationForm extends StatefulWidget {
  const FoodDonationForm({super.key});

  @override
  _FoodDonationFormState createState() => _FoodDonationFormState();
}

class _FoodDonationFormState extends State<FoodDonationForm> {
  int _selectedIndex = 1;
  File? _image;
  final picker = ImagePicker();
  String mealType = 'veg';
  String vehicleType = 'bike';
  double foodQuantity = 50;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      Navigator.pop(context); // Go back to Home
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NgoListScreen()));
    } else if (index == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfilePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Donate Food', style: TextStyle(color: AppColor.white)),
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         begin: Alignment.topLeft,
      //         end: Alignment.bottomRight,
      //         colors: [AppColor.ornage, AppColor.LightOrnage],
      //       ),
      //     ),
      //   ),
      //   elevation: 0,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImagePicker(),
                  const SizedBox(height: 24),
                  _buildTextField(nameController, 'Name', Icons.person),
                  const SizedBox(height: 16),
                  _buildLocationField(),
                  const SizedBox(height: 16),
                  _buildTextField(phoneController, 'Phone Number', Icons.phone,
                      TextInputType.phone),
                  const SizedBox(height: 24),
                  _buildMealTypeSection(),
                  const SizedBox(height: 24),
                  _buildVehicleTypeSection(),
                  const SizedBox(height: 24),
                  _buildFoodQuantitySlider(),
                  const SizedBox(height: 32),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   backgroundColor: Colors.white,
      //   selectedItemColor: AppColor.ornage,
      //   unselectedItemColor: Colors.grey,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Donate'),
      //     BottomNavigationBarItem(icon: Icon(Icons.group), label: 'NGOs'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //   ],
      // ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColor.ornage, AppColor.LightOrnage],
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Make a Difference',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Text(
              'Your donation can change lives',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: _image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(_image!, fit: BoxFit.cover),
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('Add Food Image', style: TextStyle(color: Colors.grey)),
                ],
              ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      [TextInputType? keyboardType]) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColor.ornage),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.ornage),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.ornage, width: 2),
        ),
      ),
      keyboardType: keyboardType,
    );
  }

  Widget _buildLocationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: addressController,
          decoration: InputDecoration(
            labelText: 'Address',
            prefixIcon: const Icon(Icons.location_on, color: AppColor.ornage),
            suffixIcon: IconButton(
              icon: const Icon(Icons.my_location, color: AppColor.ornage),
              onPressed: () {
                // Handle current location
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.ornage),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.ornage, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Tap the location icon to use your current location',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildMealTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Meal Type',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildMealTypeOption('Veg', 'veg', Icons.eco),
            const SizedBox(width: 16),
            _buildMealTypeOption('Non-Veg', 'nonveg', Icons.restaurant),
          ],
        ),
      ],
    );
  }

  Widget _buildMealTypeOption(String title, String value, IconData icon) {
    bool isSelected = mealType == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => mealType = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColor.ornage : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.white : Colors.grey),
              const SizedBox(height: 8),
              Text(
                title,
                style:
                    TextStyle(color: isSelected ? Colors.white : Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Vehicle Type',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildVehicleOption('Bike', 'bike', Icons.directions_bike),
            _buildVehicleOption('Car', 'car', Icons.directions_car),
            _buildVehicleOption('Tempo', 'tempo', Icons.local_shipping),
          ],
        ),
      ],
    );
  }

  Widget _buildVehicleOption(String title, String value, IconData icon) {
    bool isSelected = vehicleType == value;
    return GestureDetector(
      onTap: () => setState(() => vehicleType = value),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? AppColor.ornage : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(icon,
                color: isSelected ? Colors.white : Colors.grey, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? AppColor.ornage : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodQuantitySlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Food Quantity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.lunch_dining, color: AppColor.ornage),
            Expanded(
              child: Slider(
                value: foodQuantity,
                min: 0,
                max: 100,
                divisions: 100,
                activeColor: AppColor.ornage,
                inactiveColor: Colors.grey[300],
                label: '${foodQuantity.round()} servings',
                onChanged: (value) => setState(() => foodQuantity = value),
              ),
            ),
            Text(
              '${foodQuantity.round()}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: AppColor.ornage),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        // Handle form submission
        print('Form submitted');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.ornage,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text('Submit Donation',
          style: TextStyle(fontSize: 18, color: AppColor.white)),
    );
  }
}
