import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_profile_dropdown.dart';

Widget customTopBar(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Color(0xffE8E8E8),
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xffE5E7EB), width: 1.0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Builder(
                builder:
                    (context) => IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: SvgPicture.asset(
                        'assets/icons/menu.svg',
                        width: 36,
                        height: 36,
                        fit: BoxFit.scaleDown,
                      ),
                      onPressed: () {
                        Scaffold.of(
                          context,
                        ).openDrawer(); // works if drawer is defined in Scaffold
                      },
                    ),
              ),
            ),
            SizedBox(width: 15),
            SvgPicture.asset('assets/images/logo.svg', height: 30),
          ],
        ),

        CustomProfileDropdown(),
      ],
    ),
  );
}
