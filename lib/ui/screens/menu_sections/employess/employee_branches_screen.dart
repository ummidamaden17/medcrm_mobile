import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medcrm_mobile/ui/widgets/custom_drawer.dart';

import '../../../widgets/custom_top_bar.dart';
import 'employee_add_screen.dart';
import 'employee_edit_page.dart';
import 'modals/employee_delete_modal.dart';

class EmployeeBranchesScreen extends StatefulWidget {
  const EmployeeBranchesScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeBranchesScreen> createState() => _EmployeeBranchesScreen();
}

class _EmployeeBranchesScreen extends State<EmployeeBranchesScreen> {
  int currentPage = 1;
  int itemsPerPage = 10;
  List<bool> checked = List.generate(18, (_) => false);
  final List<String> employees = List.generate(18, (_) => 'Айдана');
  bool selectAll = false;
  bool showSearch = false;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    int totalPages = (employees.length / itemsPerPage).ceil();
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = (startIndex + itemsPerPage).clamp(0, employees.length);
    List<String> paginatedEmployees = employees.sublist(startIndex, endIndex);

    int? getSelectedIndex() {
      for (int i = 0; i < checked.length; i++) {
        if (checked[i]) return i;
      }
      return null;
    }

    return Scaffold(
      backgroundColor: Color(0xffF3F4F6),
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Builder(builder: (context) => customTopBar(context)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Главная / ',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xff6B7280),
                    ),
                  ),
                  TextSpan(
                    text: 'Список филиалы',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xff0987EC),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showSearch) ...[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: searchController,
                  style: GoogleFonts.inter(fontSize: 14),
                  decoration: InputDecoration(
                    fillColor: Color(0xffF3F4F6),
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    hintText: 'Поиск',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      color: Color(0xff6B7280),
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(
                        color: Color(0xffF6F8FB),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xffE8E8E8),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xff0987EC),
                        width: 2,
                      ),
                    ),
                    suffixIcon: SizedBox(
                      width: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/search.svg',
                            width: 16,
                            height: 16,
                            color: Color(0xff9CA3AF),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                searchController.clear();
                                showSearch = false;
                              });
                            },
                            child: Icon(
                              Icons.close,
                              size: 18,
                              color: Color(0xff9CA3AF),
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                    suffixIconConstraints: BoxConstraints(minHeight: 40),
                  ),
                ),
              ),
            ),
          ],

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (!showSearch)
                                  IconButton(
                                    icon: SvgPicture.asset(
                                      'assets/icons/search.svg',
                                      width: 24,
                                      height: 24,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        showSearch = true;
                                      });
                                    },
                                  ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => EmployeeAddScreen(),
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                            const Color(0xFF0987EC),
                                          ),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      padding: MaterialStateProperty.all(
                                        EdgeInsets.zero,
                                      ),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/icons/add.svg',
                                        width: 20,
                                        height: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: SvgPicture.asset(
                                    'assets/icons/edit.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                  onPressed: () {
                                    int? selectedIndex = getSelectedIndex();
                                    if (selectedIndex != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => EmployeeEditPage(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Выберите сотрудника для редактирования',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),

                                IconButton(
                                  onPressed:
                                      checked.contains(true)
                                          ? () {
                                            employeeDeleteModal(context, () {
                                              setState(() {
                                                for (
                                                  int i = checked.length - 1;
                                                  i >= 0;
                                                  i--
                                                ) {
                                                  if (checked[i]) {
                                                    employees.removeAt(i);
                                                    checked.removeAt(i);
                                                  }
                                                }
                                                selectAll = false;
                                              });
                                            });
                                          }
                                          : null,
                                  icon: SvgPicture.asset(
                                    'assets/icons/delete.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      const Divider(thickness: 0.5, height: 0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  checkboxTheme: CheckboxThemeData(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    fillColor:
                                        MaterialStateProperty.resolveWith((
                                          states,
                                        ) {
                                          if (states.contains(
                                            MaterialState.selected,
                                          )) {
                                            return Color(0xFF0987EC);
                                          }
                                          return Colors.white;
                                        }),
                                    checkColor: MaterialStateProperty.all(
                                      Colors.white,
                                    ),
                                    side: const BorderSide(
                                      color: Color(0xffD1D5DB),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Checkbox(
                                  value: selectAll,
                                  onChanged: (val) {
                                    setState(() {
                                      selectAll = val!;
                                      for (int i = 0; i < checked.length; i++) {
                                        checked[i] = selectAll;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    'ФИО',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff6B7280),
                                    ),
                                  ),
                                  const SizedBox(width: 80),
                                  SvgPicture.asset(
                                    'assets/icons/filter.svg',
                                    width: 16,
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    'РОЛИ',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff6B7280),
                                    ),
                                  ),
                                  const SizedBox(width: 80),
                                  SvgPicture.asset(
                                    'assets/icons/filter.svg',
                                    width: 16,
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xffE8E8E8),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: paginatedEmployees.length,
                          itemBuilder: (context, index) {
                            int realIndex = startIndex + index;

                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: SizedBox(
                                          width: 40,
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                              checkboxTheme: CheckboxThemeData(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                side: const BorderSide(
                                                  color: Color(0xffD1D5DB),
                                                  width: 1.0,
                                                ),
                                                fillColor:
                                                    MaterialStateProperty.resolveWith<
                                                      Color
                                                    >((states) {
                                                      if (states.contains(
                                                        MaterialState.selected,
                                                      )) {
                                                        return Colors.blue;
                                                      }
                                                      return Colors.transparent;
                                                    }),
                                                checkColor:
                                                    MaterialStateProperty.all(
                                                      Colors.white,
                                                    ),
                                              ),
                                            ),
                                            child: Checkbox(
                                              value: checked[realIndex],
                                              onChanged: (val) {
                                                setState(() {
                                                  checked[realIndex] = val!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0,
                                          ),
                                          child: Text(
                                            employees[realIndex],
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff6B7280),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 4.0,
                                          ),
                                          child: Text(
                                            'Админ',
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff6B7280),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(0xffE5E7EB),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap:
                                currentPage > 1
                                    ? () {
                                      setState(() {
                                        currentPage--;
                                      });
                                    }
                                    : null,
                            child: Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/left_arrow.svg',
                                width: 10,
                                height: 20,
                                color:
                                    currentPage < totalPages
                                        ? Color(0xffD1D5DB)
                                        : Color(0xff6B7280),
                              ),
                            ),
                          ),
                          ...List.generate(totalPages, (i) {
                            final page = i + 1;
                            final bool isSelected = currentPage == page;

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentPage = page;
                                  });
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? Colors.grey.shade100
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '$page',
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 16,
                                      fontWeight:
                                          isSelected
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                          GestureDetector(
                            onTap:
                                currentPage < totalPages
                                    ? () {
                                      setState(() {
                                        currentPage++;
                                      });
                                    }
                                    : null,
                            child: Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/right_arrow.svg',
                                width: 10,
                                height: 20,
                                color:
                                    currentPage > 1
                                        ? Color(0xffD1D5DB)
                                        : Color(0xff6B7280),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Показаны с ${startIndex + 1} по $endIndex из ${employees.length} записей',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff6B7280),
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
}
