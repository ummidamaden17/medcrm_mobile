import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_top_bar.dart';
import 'modals/cancel_profile.dart';
import 'modals/edit_profile.dart';

class ProfileAccountSetting extends StatelessWidget {
  const ProfileAccountSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Builder(builder: (context) => customTopBar(context)),
          const SizedBox(height: 10),
          _buildBreadcrumb(),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: 460,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text(
                          'Редактирование профиля',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF111827),
                          ),
                        ),
                      ),
                      const Divider(height: 1, color: Color(0xFFE5E7EB)),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildField(
                              'UUID сотрудника',
                              'be6c32c-a2a9-4928-8f11-03eb7',
                              readOnly: true,
                            ),
                            _buildField('ФИО', 'Мейржан Азатулы'),
                            _buildField(
                              'UUID роля',
                              '900291923',
                              readOnly: true,
                            ),
                            _buildPasswordField('Пароль', '************'),
                            _buildField('Номер телефона', '+7 775 627 0912'),
                            _buildField('Адрес', 'Сайрам 14'),
                            _buildDropdownField('Филиал', [
                              'Сайрам 14',
                            ], 'Сайрам 14'),
                            _buildDropdownField('Тип сотрудника', [
                              'Директор',
                            ], 'Директор'),
                            _buildField(
                              'Дата регистрации',
                              '15.02.2025',
                              readOnly: true,
                            ),
                            const SizedBox(height: 10),
                            CustomActionButtons(
                              onCancel: () {
                                showLogoutConfirmationDialog(context);
                                print("Cancel pressed");
                              },
                              onSave: () {
                                showConfirmationDialog(context);
                                print("Save pressed");
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumb() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12, bottom: 8),
      child: Row(
        children: [
          Text(
            'Главная / ',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6B7280),
            ),
          ),
          Text(
            'Настройка аккаунта',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0987EC),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, String value, {bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: value,
          readOnly: readOnly,
          decoration: _inputDecoration(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPasswordField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 6),
        TextFormField(
          obscureText: true,
          initialValue: value,
          decoration: _inputDecoration().copyWith(
            suffixIcon: IconButton(
              icon: const Icon(Icons.visibility_outlined),
              onPressed: () {},
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    List<String> items,
    String selected,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: selected,
          items:
              items.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
          onChanged: (_) {},
          decoration: _inputDecoration(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF111928),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFF9CA3AF)),
      ),
    );
  }
}
