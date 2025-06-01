import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medcrm_mobile/ui/screens/menu_sections/employess/employee_list.dart';

import '../../../../widgets/custom_buttons.dart';

void cancelEmployeeModal(BuildContext context) {
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
                'Отменить изменения сотрудника',
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
                  color: const Color(0xFFF23030),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(height: 20),
              Text(
                'Вы уверены, что хотите отменить редактирование сотрудника?',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmployeeListPage()),
                  );
                  print("Cancel pressed");
                },
                onSave: () {
                  MaterialPageRoute(builder: (context) => EmployeeListPage());
                  print("Save pressed");
                },
                saveButtonText: 'Выйти',
                cancelButtonColor: Color(0xffF3F4F6),
                saveButtonColor: Color(0xffF23030),
              ),
            ],
          ),
        ),
      );
    },
  );
}
