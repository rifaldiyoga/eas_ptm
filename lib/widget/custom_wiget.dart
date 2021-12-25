import 'package:flutter/material.dart';
import 'package:shamo/theme.dart';

Widget input(String title, String icon, var controller) {
  return Container(
    margin: EdgeInsets.only(top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${title}",
          style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: backgroundColor2, borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Row(
              children: [
                Image.asset(
                  "assets/${icon}",
                  width: 20,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: TextFormField(
                  controller: controller,
                  style: primaryTextStyle,
                  decoration: InputDecoration.collapsed(
                      hintText: "Your ${title}", hintStyle: subtitleTextStyle),
                ))
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget inputDropdown(String title, List<String> list, String value,
    Function(String?)? onChange) {
  print(list);
  return Container(
    margin: EdgeInsets.only(top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: backgroundColor2, borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Row(
              children: [
                Image.asset(
                  "assets/ic_profile_active.png",
                  width: 20,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: DropdownButtonFormField<String>(
                        dropdownColor: backgroundColor2,
                        value: value,
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            child: Container(
                              child: Column(
                                children: [
                                  Text(
                                    value,
                                    style: primaryTextStyle,
                                  ),
                                ],
                              ),
                            ),
                            value: value,
                          );
                        }).toList(),
                        onChanged: onChange))
              ],
            ),
          ),
        )
      ],
    ),
  );
}
