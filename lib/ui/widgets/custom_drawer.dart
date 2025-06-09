import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/menu_sections/employess/employee_branches_screen.dart';
import '../screens/menu_sections/employess/employee_list.dart';
import '../screens/menu_sections/employess/employee_permission_screen.dart';
import '../screens/menu_sections/employess/employee_role_screen.dart';
import '../screens/menu_sections/expences/expence_category_screen.dart';
import '../screens/menu_sections/expences/expences_list_screen.dart';
import '../screens/menu_sections/finance/service_directory_screen.dart';
import '../screens/menu_sections/finance/service_history_screen.dart';
import '../screens/menu_sections/patients/patient_appointments_screen.dart';
import '../screens/menu_sections/patients/patients_list_screen.dart';
import '../screens/menu_sections/reports/cash_reports_screen.dart';
import '../screens/menu_sections/reports/expence_reports_screen.dart';
import '../screens/menu_sections/settings/settings_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? _expandedMenu;
  String? _selectedSubItem;
  String? _highlightedMenu;

  void _highlightMenu(String label) {
    setState(() {
      _highlightedMenu = label;
    });
  }

  void _toggleSubItems(String label) {
    setState(() {
      if (_expandedMenu == label) {
        _expandedMenu = null;
      } else {
        _expandedMenu = label;
      }
    });
  }

  Widget _buildMenuItem({
    required String iconPath,
    required String label,
    bool hasArrow = true,
    List<String>? subItems,
  }) {
    bool isExpanded = _expandedMenu == label;
    bool isHighlighted = _highlightedMenu == label;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            _highlightMenu(label);
            if ((subItems == null || subItems.isEmpty) || !hasArrow) {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => _getPageForLabel(label)),
              );
            }
          },

          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration:
                isHighlighted
                    ? BoxDecoration(
                      color: Color(0xffE0F2FE),
                      borderRadius: BorderRadius.circular(8),
                    )
                    : null,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24,
                  child: Center(
                    child: SvgPicture.asset(
                      iconPath,
                      height: 20,
                      color:
                          isHighlighted ? Color(0xff0284C7) : Color(0xff4B5563),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color:
                          isHighlighted ? Color(0xff0284C7) : Color(0xff4B5563),
                    ),
                  ),
                ),
                if (hasArrow)
                  GestureDetector(
                    onTap: () {
                      _toggleSubItems(label);
                    },
                    child: SizedBox(
                      width: 24,
                      child: Center(
                        child: SvgPicture.asset(
                          isExpanded
                              ? 'assets/icons/up_arrow.svg'
                              : 'assets/icons/down_arrow.svg',
                          width: 8,
                          height: 8,
                          color:
                              isHighlighted
                                  ? Color(0xff0284C7)
                                  : Color(0xff4B5563),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (isExpanded && subItems != null)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  subItems.map((subItem) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSubItem = subItem;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => _getPageForLabel(subItem),
                          ),
                        );
                      },

                      child: Container(
                        margin: EdgeInsets.only(top: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color:
                              _selectedSubItem == subItem
                                  ? Color(0xffE0F2FE)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              subItem,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color:
                                    _selectedSubItem == subItem
                                        ? Color(0xff0284C7)
                                        : Color(0xff4B5563),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      width: 280,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/images/logo.svg', height: 32),
                SizedBox(width: 8),
                Text(
                  'MedCRM',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                ),
                Spacer(),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/back_arrow.svg',
                    width: 16,
                    height: 16,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'ГЛАВНОЕ МЕНЮ',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff4B5563),
              ),
            ),
            SizedBox(height: 16),

            _buildMenuItem(
              iconPath: 'assets/icons/employee.svg',
              label: 'Сотрудники',
              subItems: ['Список сотрудников', 'Роли', 'Разрешения', 'Филиалы'],
            ),
            _buildMenuItem(
              iconPath: 'assets/icons/patients.svg',
              label: 'Пациенты',
              subItems: ['Список', 'Приемы'],
            ),
            _buildMenuItem(
              iconPath: 'assets/icons/finance.svg',
              label: 'Финанс',
              subItems: ['Справочник услуг', 'История услуг'],
            ),
            _buildMenuItem(
              iconPath: 'assets/icons/expenses.svg',
              label: 'Расходы',
              subItems: ['Список расходов', 'Категория расходов'],
            ),
            _buildMenuItem(
              iconPath: 'assets/icons/reports.svg',
              label: 'Отчеты',
              subItems: ['Отчеты по кассе', 'Отчеты по расходам'],
            ),
            _buildMenuItem(
              iconPath: 'assets/icons/settings.svg',
              label: 'Настройки',
              hasArrow: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPageForLabel(String label) {
    switch (label) {
      case 'Сотрудники':
        return EmployeeListPage();
      case 'Список сотрудников':
        return EmployeeListPage();
      case 'Роли':
        return EmployeeRoleScreen();
      case 'Разрешения':
        return EmployeePermissionScreen();
      case 'Филиалы':
        return EmployeeBranchesScreen();
      case 'Пациенты':
        return PatientsListScreen();
      case 'Список':
        return PatientsListScreen();
      case 'Приемы':
        return PatientAppointmentsScreen();
      case 'Финанс':
        return ServiceDirectoryScreen();
      case 'Справочник услуг':
        return ServiceDirectoryScreen();
      case 'История услуг':
        return ServiceHistoryScreen();
      case 'Расходы':
        return ExpencesListScreen();
      case 'Список расходов':
        return ExpencesListScreen();
      case 'Категория расходов':
        return ExpenceCategoryScreen();
      case 'Отчеты':
        return CashReportsScreen();
      case 'Отчеты по кассе':
        return CashReportsScreen();
      case 'Отчеты по расходам':
        return ExpenceReportsScreen();
      case 'Настройки':
        return SettingsScreen();
      default:
        return Placeholder();
    }
  }
}
