import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final Color? saveButtonColor;
  final Color? cancelButtonColor;
  final String cancelButtonText;
  final String saveButtonText;

  const CustomActionButtons({
    Key? key,
    required this.onCancel,
    required this.onSave,
    this.saveButtonColor,
    this.cancelButtonColor,
    this.cancelButtonText = 'Отменить',
    this.saveButtonText = 'Сохранить',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Flex(
          direction: isSmallScreen ? Axis.vertical : Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: isSmallScreen ? double.infinity : 150,
              height: 50,
              child: OutlinedButton(
                onPressed: onCancel,
                style: OutlinedButton.styleFrom(
                  backgroundColor: cancelButtonColor ?? Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  side: const BorderSide(color: Color(0xffE8E8E8), width: 1.0),
                ),
                child: Text(
                  cancelButtonText,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff111928),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: isSmallScreen ? 12 : 0,
              width: isSmallScreen ? 0 : 12,
            ),
            SizedBox(
              width: isSmallScreen ? double.infinity : 150,
              height: 50,
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: saveButtonColor ?? const Color(0xff0987EC),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  saveButtonText,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
