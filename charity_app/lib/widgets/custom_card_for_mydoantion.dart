import 'package:charity_app/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyCustomCard extends StatelessWidget {
  final snap;
  const MyCustomCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final f = DateFormat('yyyy-MM-dd');
    return Padding(
      padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 16.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          color: Colors.black.withOpacity(0.02),
          width: Get.width * 1,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snap["title"],
                        style: subHeadingStyle,
                      ),
                      Text(
                        DateFormat.yMd()
                            .add_jm()
                            .format((snap["date"] as Timestamp).toDate()),
                        style: textHeadingStyle.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        snap["status"],
                        style: textHeadingStyle.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
