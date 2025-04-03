import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:moviego/utils/colors.dart';
import 'package:moviego/widgets/customText.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customText(text: "Profile",isbold: true,size: 22,),
        backgroundColor: colors.primary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Profile Picture
            CircleAvatar(
              backgroundColor: Colors.red,
              radius: 50,
              child: Icon(Iconsax.user,color: Colors.white,size: 40,),
            ),
            const SizedBox(height: 10),

            // Name
            const Text(
              "John Doe",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
            ),

            // Email
            const Text(
              "johndoe@example.com",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // Profile Details
            ListTile(
              leading: Icon(Icons.phone, color: Colors.blueGrey),
              title: customText(text: "+1 234 567 890"),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.blueGrey),
              title: customText(text: "New York, USA"),
            ),
            ListTile(
              leading: Icon(Icons.cake, color: Colors.blueGrey),
              title: customText(text: "January 1, 1990"),
            ),

            const Spacer(),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text("Logout", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
