import 'dart:io';

import 'package:contact_app/core/utils/app_assets.dart';
import 'package:contact_app/core/utils/app_colors.dart';
import 'package:contact_app/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class AddContactBottomSheet extends StatefulWidget {
  const AddContactBottomSheet({super.key});

  @override
  State<AddContactBottomSheet> createState() => _AddContactBottomSheetState();
}

class _AddContactBottomSheetState extends State<AddContactBottomSheet> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  XFile? selectedImage;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null && mounted) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.04,
        ),
        decoration: BoxDecoration(
          color: AppColors.darkBlueColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: height * 0.02,
            children: [
              Row(
                spacing: width * 0.02,
                children: [
                  // Image Picker
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      width: width * 0.35,
                      height: height * 0.15,
                      decoration: BoxDecoration(
                        color: const Color(0xFF283348),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.goldColor),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: selectedImage != null
                            ? Image.file(
                                File(selectedImage!.path),
                                height: height * 0.61,
                                fit: BoxFit.cover,
                              )
                            : Lottie.asset(AppAssets.imagePickerAnimation),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCustomText(
                          data: nameController.text.isEmpty
                              ? 'User Name'
                              : nameController.text,
                        ),
                        Divider(color: AppColors.goldColor),
                        _buildCustomText(
                          data: emailController.text.isEmpty
                              ? 'example@email.com'
                              : emailController.text,
                        ),
                        Divider(color: AppColors.goldColor),
                        _buildCustomText(
                          data: phoneController.text.isEmpty
                              ? '+200000000000'
                              : phoneController.text,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              _buildCustomTextField(
                controller: nameController,
                hintText: 'Enter User Name',
              ),

              _buildCustomTextField(
                controller: emailController,
                hintText: 'Enter User Email',
                keyboardType: TextInputType.emailAddress,
              ),

              _buildCustomTextField(
                controller: phoneController,
                hintText: 'Enter User Phone',
                keyboardType: TextInputType.phone,
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: height * 0.012),
                  backgroundColor: AppColors.goldColor,
                  foregroundColor: AppColors.darkBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  if (nameController.text.trim().isNotEmpty) {
                    final ContactModel newContact = ContactModel(
                      name: nameController.text.trim(),
                      email: emailController.text.isEmpty
                          ? 'example@email.com'
                          : emailController.text.trim(),
                      phone: phoneController.text.isEmpty
                          ? '+200000000000'
                          : phoneController.text.trim(),
                      imagePath: selectedImage!.path,
                    );

                    Navigator.pop(context, newContact);
                  }
                },
                child: const Text(
                  'Enter user',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      cursorColor: AppColors.goldColor,
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: AppColors.lightBlueColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      onChanged: (value) {
        setState(() {});
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.lightBlueColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: const Color(0xFF1E2738),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.goldColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.goldColor),
        ),
      ),
    );
  }

  Widget _buildCustomText({required String data}) {
    return Text(
      data,
      style: const TextStyle(
        color: AppColors.goldColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
/*Text(
                          nameController.text.isEmpty
                              ? 'User Name'
                              : nameController.text,
                          style: TextStyle(
                            color: AppColors.goldColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),*/
