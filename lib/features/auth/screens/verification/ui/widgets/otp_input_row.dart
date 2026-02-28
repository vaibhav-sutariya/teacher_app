import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teachers_app/core/widgets/app_text_field.dart';

class OtpInputRow extends StatelessWidget {
  const OtpInputRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return _OtpDigitField(autoFocus: index == 0);
      }),
    );
  }
}

class _OtpDigitField extends StatelessWidget {
  final bool autoFocus;

  const _OtpDigitField({this.autoFocus = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: AppTextField(
        autofocus: autoFocus,
        // textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        obscureText: true,
        // style: TextStyle(
        //   fontSize: 24,
        //   fontWeight: FontWeight.bold,
        //   color: context.colors.primary, // Primary Blue
        // ),
        // decoration: const InputDecoration(
        //   border: InputBorder.none,
        //   contentPadding: EdgeInsets.zero,
        //   counterText: '', // Hide counter
        // ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          } else {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
