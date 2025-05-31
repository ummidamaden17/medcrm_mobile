import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({Key? key}) : super(key: key);

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  int currentPage = 1;
  int itemsPerPage = 10;
  List<bool> checked = List.generate(18, (_) => false);
  final List<String> employees = List.generate(18, (_) => 'Айдана');
  bool selectAll = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    int totalPages = (employees.length / itemsPerPage).ceil();
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = (startIndex + itemsPerPage).clamp(0, employees.length);
    List<String> paginatedEmployees = employees.sublist(startIndex, endIndex);

    return Scaffold(
      appBar: AppBar(title: const Text('Список сотрудников')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Top row: search + add + edit/delete
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            'assets/icons/search.svg',
                            width: 24,
                            height: 24,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF0987EC),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
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
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/icons/edit.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
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

                const Divider(thickness: 0.5),
                const SizedBox(height: 16),

                // Fixed Header Row
                Container(
                  color: Colors.grey.shade100,
                  padding: const EdgeInsets.symmetric(vertical: 12),
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
                              fillColor: MaterialStateProperty.resolveWith((
                                states,
                              ) {
                                if (states.contains(MaterialState.selected)) {
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
                      Expanded(
                        child: Row(
                          children: [
                            const Text(
                              'ФИО',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 4),
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
                            const Text(
                              'РОЛИ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 4),
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

                const Divider(height: 1, thickness: 1),

                // Table List
                Expanded(
                  child: ListView.builder(
                    itemCount: paginatedEmployees.length,
                    itemBuilder: (context, index) {
                      int realIndex = startIndex + index;

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      checkboxTheme: CheckboxThemeData(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
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
                                        checkColor: MaterialStateProperty.all(
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
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    child: Text(employees[realIndex]),
                                  ),
                                ),
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    child: Text('Админ'),
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

                // Pagination row with arrows
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Left arrow
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
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),

                    // Page buttons
                    ...List.generate(totalPages, (i) {
                      final page = i + 1;
                      final bool isSelected = currentPage == page;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
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
                                      ? Colors.grey.shade200
                                      : Colors.white,
                              border: Border.all(
                                color:
                                    isSelected
                                        ? Colors.blue
                                        : Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '$page',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),

                    // Right arrow
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
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Record count
                Text(
                  'Показаны с ${startIndex + 1} по $endIndex из ${employees.length} записей',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
