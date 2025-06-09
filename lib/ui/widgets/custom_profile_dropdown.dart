import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/login_screen.dart';
import '../screens/profile/profile_account_setting.dart';

class CustomProfileDropdown extends StatefulWidget {
  const CustomProfileDropdown({super.key});

  @override
  _CustomProfileDropdownState createState() => _CustomProfileDropdownState();
}

class _CustomProfileDropdownState extends State<CustomProfileDropdown> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isDropdownOpen = false;
  String hoveredLabel = '';

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder:
          (context) => Positioned(
            width: 260,
            top: offset.dy + size.height + 8,
            left: offset.dx - 110,
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFFE8E8E8), width: 0.5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                              'assets/images/profile.png',
                            ),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Мейржан Азатулы",
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff111928),
                                ),
                              ),
                              Text(
                                "+7 776 339 0202",
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff6B7280),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Color(0xFFE8E8E8),
                      thickness: 0.5,
                      height: 20,
                    ),

                    _buildDropdownItem(
                      'assets/icons/user.svg',
                      'Посмотреть профиль',
                      () {
                        print('Посмотреть профиль');
                      },
                    ),
                    SizedBox(height: 10),
                    _buildDropdownItem(
                      'assets/icons/settings.svg',
                      'Настройки аккаунта',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileAccountSetting(),
                          ),
                        );
                        print('Настройки аккаунта');
                      },
                    ),
                    Divider(
                      color: Color(0xFFE8E8E8),
                      thickness: 0.5,
                      height: 20,
                    ),
                    _buildDropdownItem('assets/icons/logout.svg', 'Выйти', () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                        (route) => false,
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildDropdownItem(
    String svgAssetPath,
    String label,
    VoidCallback onTap,
  ) {
    final bool isHovered = hoveredLabel == label;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredLabel = label),
      onExit: (_) => setState(() => hoveredLabel = ''),
      child: GestureDetector(
        onTap: () {
          _closeDropdown();
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFFF5F5F5) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              SvgPicture.asset(
                svgAssetPath,
                width: 20,
                height: 20,
                color: const Color(0xFF374151),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff111928),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Row(
          children: [
            SizedBox(
              height: 36,
              width: 36,
              child: CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Мейіржан',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xff111928),
              ),
            ),
            SizedBox(width: 10),
            SvgPicture.asset(
              _isDropdownOpen
                  ? 'assets/icons/up_arrow.svg'
                  : 'assets/icons/down_arrow.svg',
              width: 8,
              height: 8,
              color: Color(0xff111928),
            ),
          ],
        ),
      ),
    );
  }
}
