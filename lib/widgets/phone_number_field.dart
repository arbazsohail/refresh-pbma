import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';
import '../utils/app_colors.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validation;
  final RxString selectedCountryCode;

  const PhoneNumberField({
    super.key,
    required this.controller,
    this.validation,
    required this.selectedCountryCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          // Country code selector
          GestureDetector(
            onTap: () => _showCountryPicker(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.borderGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => Text(
                      selectedCountryCode.value,
                      style: const TextStyle(
                        color: AppColors.blackText,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'DMSans',
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.blackText,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),

          // Phone number input
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                validator: validation,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.blackText,
                ),
                decoration: const InputDecoration(
                  hintText: '422- 6454- 1544',
                  hintStyle: TextStyle(fontSize: 16, color: AppColors.textHint),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  filled: false,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        selectedCountryCode.value = '+${country.phoneCode}';
      },
      countryListTheme: CountryListThemeData(
        backgroundColor: AppColors.lightBackground,
        textStyle: const TextStyle(
          color: AppColors.blackText,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'DMSans',
        ),
        searchTextStyle: const TextStyle(
          color: AppColors.blackText,
          fontSize: 16,
          fontFamily: 'DMSans',
        ),
        inputDecoration: InputDecoration(
          fillColor: AppColors.lightBackground,
          labelText: 'Search',
          hintText: 'Start typing to search',
          filled: true,
          hintStyle: TextStyle(color: Colors.black),
          prefixIcon: const Icon(Icons.search, color: AppColors.blackText),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.lightBorder),
          ),
        ),
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.7,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}
