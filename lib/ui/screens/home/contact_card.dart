import 'dart:io';

import 'package:contact_app/core/utils/app_assets.dart';
import 'package:contact_app/core/utils/app_colors.dart';
import 'package:contact_app/model/contact_model.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback onDelete;

  const ContactCard({super.key, required this.contact, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.goldColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: height * 0.01,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              //Image
              Container(
                height: height * 0.2,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF283348),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  child: contact.imagePath.isNotEmpty
                      ? Image.file(
                          File(contact.imagePath),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.person,
                          color: AppColors.goldColor,
                          size: 48,
                        ),
                ),
              ),
              //name
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                  horizontal: width * 0.01,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                  horizontal: width * 0.02,
                ),
                decoration: BoxDecoration(
                  color: AppColors.goldColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  contact.name,
                  style: const TextStyle(
                    color: AppColors.darkBlueColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          _contactInfo(iconImage: AppAssets.emailIcon, data: contact.email),

          _contactInfo(iconImage: AppAssets.phoneIcon, data: contact.phone),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redColor,
                foregroundColor: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onDelete,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.delete, size: 12),
                  const Text(
                    'Delete',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactInfo({required String iconImage, required String data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        spacing: 4,
        children: [
          Image.asset(iconImage),
          Expanded(
            child: Text(
              data,
              style: const TextStyle(
                color: AppColors.darkBlueColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

/*
Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              spacing: 4,
              children: [
                Image.asset(AppAssets.emailIcon),
                // const Icon(
                //   Icons.email,
                //   size: 20,
                //   color: AppColors.darkBlueColor,
                // ),
                Expanded(
                  child: Text(
                    contact.email,
                    style: const TextStyle(
                      color: AppColors.darkBlueColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          */
