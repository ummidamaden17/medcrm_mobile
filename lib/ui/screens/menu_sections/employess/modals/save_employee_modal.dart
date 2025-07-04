import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../widgets/custom_buttons.dart';
import '../employee_list.dart';

void saveEmployeeDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          width: 400,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Редактирование сотрудников',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF212B36),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 90,
                height: 3,
                decoration: BoxDecoration(
                  color: const Color(0xFF0987EC),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(height: 20),
              Text(
                'Вы уверены, что хотите редактировать\nсотрудника ?',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 24),
              const SizedBox(height: 15),
              CustomActionButtons(
                onCancel: () {
                  Navigator.pop(context);
                  print("Cancel pressed");
                },
                onSave: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmployeeListPage()),
                  );
                  print("Save pressed");
                },
                cancelButtonColor: Color(0xffF3F4F6),
                saveButtonColor: Color(0xff0987EC),
              ),
            ],
          ),
        ),
      );
    },
  );
}
