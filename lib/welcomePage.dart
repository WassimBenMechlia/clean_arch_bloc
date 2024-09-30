import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cores/infrastructure/local/user_local_storage/hive_storage_service.dart';
import 'cores/util/const_colors.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10.0),
                    Center(child: _buildGreetingSection()),
                    SizedBox(height: 20.0), // Added space between sections
                    Center(
                      child: _buildExploreSection(),
                    ),
                    SizedBox(height: 20.0), // Added space between sections
                    // Other content
                  ],
                ),
              ),
            ),
          ),
          _buildInfoSection(), // This will be fixed at the bottom
        ],
      ),
    );
  }

  Widget _buildGreetingSection() {
    final user = ref.watch(storageServiceProvider);

    String baseUrl = "http://192.168.1.24:3000";
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bienvenue, ${user.currentUser!.firstName}',
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 5.0),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child: Container(
                    width: 40,
                    height: 40,
                    child: Image.network(
                      "${baseUrl}/images/users/default.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Où souhaitez-vous garer ?',
                style: TextStyle(
                  fontSize: 17.0,
                  color: ConstColor.thirdcolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.search,
                color: ConstColor.thirdcolor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExploreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              Text(
                'Explorez les meilleures options ',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 17.0, color: Colors.black),
              ),
              Text(
                'de transport pour vos déplacements',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.0),
        SizedBox(height: 10.0),
        Row(
          children: [
            Icon(Icons.warning, color: Colors.yellow),
            SizedBox(width: 5.0),
            Text(
              'Consultez les perturbations en temps réel',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  Widget _buildCard(String title, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        width: 100.0,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.fitWidth,
                width: double.infinity,
                height: 90.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ConstColor.thirdcolor,
        // color: ConstColor.mainColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Partager votre trajet ',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.black,
            ),
          ),
          Text(
            'et économiser avec le covoiturage',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildUnderlinedRow(String imagePath, String text) {
    return Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
              child: Container(
                padding: const EdgeInsets.all(
                    2.0), // Add some padding around the icon
                color: Colors.white, // Background color
                child: Image.asset(
                  imagePath,
                  width: 40.0,
                  height: 40.0,
                ),
              ),
            ),
            SizedBox(width: 16.0), // Space between icon and text
            Text(
              text,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        // SizedBox(height: 5.0),
        // Container(
        //   margin: const EdgeInsets.symmetric(horizontal: 10.0),
        //   height: 2.0,
        //   color: Colors.white,
        // ),
      ],
    );
  }
}
