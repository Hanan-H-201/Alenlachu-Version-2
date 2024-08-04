import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomFormComponents {
  static Widget buildSearchBar(
      TextEditingController controller, String hintText,
      {String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: appTheme.primaryColor.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }

  static Widget buildDatePickerField(
      BuildContext context, TextEditingController controller, Text labelText,
      {String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        label: labelText,
        suffixIcon: const Icon(Icons.calendar_today),
        filled: true,
        fillColor: appTheme.primaryColor.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          controller.text = "${pickedDate.toLocal()}".split(' ')[0];
        }
      },
      validator: validator,
    );
  }

  static Widget buildTimePickerField(
      BuildContext context, TextEditingController controller, Text labelText,
      {String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        label: labelText,
        suffixIcon: const Icon(Icons.access_time),
        filled: true,
        fillColor: appTheme.primaryColor.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          // ignore: use_build_context_synchronously
          controller.text = pickedTime.format(context);
        }
      },
      validator: validator,
    );
  }

  static Widget buildDropdownInputField(Text labelText, List<String> items,
      String? selectedItem, void Function(String?) onChanged,
      {String? Function(String?)? validator}) {
    return DropdownButtonFormField<String>(
      value: selectedItem,
      decoration: InputDecoration(
        label: labelText,
        filled: true,
        fillColor: appTheme.primaryColor.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: appTheme.textTheme.bodySmall,
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }

  static Widget buildNormalTextField(
      TextEditingController controller, Text labelText,
      {IconData? prefixIcon, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: labelText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        filled: true,
        fillColor: appTheme.primaryColor.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }

  static Widget buildPhoneNumberField(
      TextEditingController phoneController,
      Text lable,
      String selectedCountryCode,
      List<String> countryCodes,
      void Function(String?) onCountryCodeChanged,
      {String? Function(String?)? validator}) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: DropdownButtonFormField<String>(
            value: selectedCountryCode,
            decoration: InputDecoration(
              filled: true,
              fillColor: appTheme.primaryColor.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
            ),
            items: countryCodes.map((code) {
              return DropdownMenuItem<String>(
                value: code,
                child: Text(
                  code,
                  style: appTheme.textTheme.bodySmall,
                ),
              );
            }).toList(),
            onChanged: onCountryCodeChanged,
            validator: validator,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 5,
          child: TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
              label: lable,
              filled: true,
              fillColor: appTheme.primaryColor.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: TextInputType.phone,
            validator: validator,
          ),
        ),
      ],
    );
  }

  static Widget buildPasswordField(TextEditingController controller, Text label,
      {String? Function(String?)? validator}) {
    bool obscureText = true;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            label: label,
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            ),
            filled: true,
            fillColor: appTheme.primaryColor.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
          ),
          validator: validator,
        );
      },
    );
  }
}
