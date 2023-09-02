import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CoustomFormField extends StatelessWidget {
  const CoustomFormField(
      {super.key,
      required this.controller,
      required this.tybe,
      this.onChange,
      required this.label,
      this.onTap,
      this.enabled,
      required this.prefix});
  final TextEditingController controller;
  final TextInputType tybe;
  final Function(String)? onChange;
  final void Function()? onTap;

  final String label;
  final dynamic prefix;
  final bool? enabled;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      enabled: enabled,
      onTap: onTap,
      controller: controller,
      keyboardType: tybe,
      onChanged: onChange,
      validator: (data) {
        if (data!.isEmpty) {
          return "Error  Must Not Be Empty";
        }
        return null;
      },
      decoration: InputDecoration(
          fillColor: Colors.white,
          focusColor: Colors.white,
          labelText: label,
          prefixIcon: prefix,
          border: const OutlineInputBorder()),
    );
  }
}
