import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/contact_us_success_dialog.dart';
import '../routes/app_routes.dart';

class ContactUsController extends GetxController {
  // Form key
  final formKey = GlobalKey<FormState>();

  // Text controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  // Loading state
  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }

  // Validation methods
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Message is required';
    }
    if (value.length < 10) {
      return 'Message must be at least 10 characters';
    }
    return null;
  }

  // Submit contact form
  Future<void> submitContactForm() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      // In a real app, you would call an API to send the contact message
      await Future.delayed(const Duration(seconds: 2));

      // Simulate API call
      // await apiService.sendContactMessage(
      //   name: nameController.text,
      //   email: emailController.text,
      //   message: messageController.text,
      // );

      // Clear fields
      nameController.clear();
      emailController.clear();
      messageController.clear();

      // Show success dialog
      Get.dialog(
        ContactUsSuccessDialog(
          onOkPressed: () {
            Get.back(); // Close dialog
            Get.back(); // Go back to previous screen
          },
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send message. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
