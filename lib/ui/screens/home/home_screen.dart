import 'package:contact_app/core/utils/app_assets.dart';
import 'package:contact_app/core/utils/app_colors.dart';
import 'package:contact_app/model/contact_model.dart';
import 'package:contact_app/ui/screens/home/add_contact_bottom_sheet.dart';
import 'package:contact_app/ui/screens/home/body/body_is_empty.dart';
import 'package:contact_app/ui/screens/home/contact_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ContactModel> contacts = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.darkBlueColor,
      appBar: AppBar(
        backgroundColor: AppColors.darkBlueColor,
        title: Image.asset(AppAssets.appBarImage),
        titleSpacing: width * 0.06,
      ),
      body: contacts.isEmpty
          ? BodyIsEmpty()
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.04,
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: width * 0.03,
                  mainAxisSpacing: height * 0.01,
                  childAspectRatio: 0.60,
                ),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return ContactCard(
                    contact: contacts[index],
                    onDelete: () {
                      setState(() {
                        contacts.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: height * 0.02,
        children: [
          if (contacts.isNotEmpty) ...[
            FloatingActionButton(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: AppColors.redColor,
              foregroundColor: AppColors.whiteColor,

              onPressed: () {
                setState(() {
                  contacts.removeLast();
                });
              },
              child: const Icon(Icons.delete),
            ),
          ],

          if (contacts.length < 6)
            FloatingActionButton(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: AppColors.goldColor,
              foregroundColor: AppColors.darkBlueColor,
              onPressed: () async {
                ContactModel? newContact = await _showAddContactBottomSheet(
                  context,
                );
                if (newContact != null) {
                  setState(() {
                    contacts.add(newContact);
                  });
                }
              },
              child: const Icon(Icons.add),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<ContactModel?> _showAddContactBottomSheet(BuildContext context) {
    return showModalBottomSheet<ContactModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (context) {
        return const AddContactBottomSheet();
      },
    );
  }
}
