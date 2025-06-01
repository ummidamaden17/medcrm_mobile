import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medcrm_mobile/ui/screens/menu_sections/employess/modals/cancel_employee_modal.dart';
import 'package:medcrm_mobile/ui/screens/menu_sections/employess/modals/save_employee_modal.dart';

import '../../../widgets/custom_buttons.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/custom_top_bar.dart';

class EmployeeEditPage extends StatefulWidget {
  const EmployeeEditPage({super.key});

  @override
  State<EmployeeEditPage> createState() => _EmployeeEditPageState();
}

class _EmployeeEditPageState extends State<EmployeeEditPage> {
  String selectedBranch = 'Сайрам 14';
  String selectedType = 'Стажер';
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: isMobile ? const CustomDrawer() : null,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Builder(builder: (context) => customTopBar(context)),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Breadcrumb
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Главная / ',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: const Color(0xff6B7280),
                          ),
                        ),
                        TextSpan(
                          text: 'Настройки',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: const Color(0xff0987EC),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Form Container
                Center(
                  child: Container(
                    width: width > 600 ? 500 : double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Редактирование сотрудника',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF111928),
                            ),
                          ),
                        ),
                        const Divider(height: 24, color: Color(0xffE8E8E8)),

                        _buildLabel('UUID сотрудника'),
                        _buildDisabledField('900291923'),

                        _buildLabel('ФИО'),
                        _buildTextField('Адильбаева Айдана Нурбеткызы'),

                        _buildLabel('UUID роли'),
                        _buildDisabledField('R-001'),

                        _buildLabel('Пароль'),
                        _buildPasswordField(),

                        _buildLabel('Номер телефона'),
                        _buildTextField('+7 775 627 0912'),

                        _buildLabel('Адрес'),
                        _buildTextField('Сайрам 14'),

                        _buildLabel('Филиал'),
                        _buildDropdown(
                          selectedBranch,
                          ['Сайрам 14', 'Шымкент', 'Астана'],
                          (val) => setState(() => selectedBranch = val),
                        ),

                        _buildLabel('Тип сотрудника'),
                        _buildDropdown(selectedType, [
                          'Стажер',
                          'Менеджер',
                          'Админ',
                        ], (val) => setState(() => selectedType = val)),

                        _buildLabel('Дата регистрации'),
                        _buildDisabledField('15.02.2025'),

                        _buildLabel('Статус'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFE5E7EB),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 0.8,
                                  child: Switch(
                                    value: isActive,
                                    onChanged:
                                        (val) => setState(() => isActive = val),
                                    activeColor: const Color(0xFFFFFFFF),
                                    activeTrackColor: const Color(0xFF10B981),
                                    inactiveThumbColor: const Color(0xFFFFFFFF),
                                    inactiveTrackColor: const Color(
                                      0xFFD1D5DB,
                                    ), // Gray track
                                    trackOutlineColor:
                                        MaterialStateProperty.resolveWith<
                                          Color?
                                        >((states) => const Color(0xFFE5E7EB)),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  isActive ? 'Активный' : 'Не активный',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        isActive
                                            ? const Color(0xFF10B981)
                                            : const Color(0xFF6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        CustomActionButtons(
                          onCancel: () {
                            cancelEmployeeModal(context);
                            print("Cancel pressed");
                          },
                          onSave: () {
                            saveEmployeeDialog(context);
                            print("Save pressed");
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6, right: 16, left: 16),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: const Color(0xff6B7280),
        ),
      ),
    );
  }

  Widget _buildTextField(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        initialValue: value,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0xff111928),
        ),
        decoration: _inputDecoration(filledColor: const Color(0xffF6F8FB)),
      ),
    );
  }

  Widget _buildDisabledField(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        initialValue: value,
        enabled: false,
        style: GoogleFonts.inter(
          fontSize: 16,
          color: const Color(0xff111928),
          fontWeight: FontWeight.w500,
        ),
        decoration: _inputDecoration(filledColor: const Color(0xffF6F8FB)),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        obscureText: true,
        initialValue: '************',
        style: GoogleFonts.inter(fontSize: 16),
        decoration: _inputDecoration().copyWith(
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SvgPicture.asset(
              'assets/icons/password.svg',
              width: 16,
              height: 16,
            ),
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 32,
            minHeight: 32,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String currentValue,
    List<String> options,
    void Function(String) onChanged, {
    Widget? customIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonFormField<String>(
        value: currentValue,
        decoration: _inputDecoration(),
        icon: SvgPicture.asset(
          'assets/icons/down_arrow.png',
          width: 24,
          height: 24,
        ),
        items:
            options
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
        onChanged: (val) {
          if (val != null) {
            onChanged(val);
          }
        },
      ),
    );
  }

  InputDecoration _inputDecoration({Color filledColor = Colors.white}) {
    return InputDecoration(
      fillColor: filledColor,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Color(0xFFE8E8E8), width: 2),
      ),
    );
  }
}
