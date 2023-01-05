import 'package:flutter/material.dart';
import 'package:thewarehouse/config/theme/colors.dart';

class DatabaseWidget extends StatelessWidget {
  final Function onRequestAction;
  final String title;
  final bool isActive;
  const DatabaseWidget({required this.title, required this.isActive, Key? key, required this.onRequestAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16),
        title: Text(title),
        subtitle: Text(
          isActive ? 'Active' : 'InActive',
          style: TextStyle(color: isActive ? AppColors.approvedColor : AppColors.rejectedColor, fontWeight: FontWeight.w600),
        ),
        trailing: PopupMenuButton(
            onSelected: (value) {
              if (value == 1) {
                onRequestAction();
              }
            },
            itemBuilder: (tx) => [
                  const PopupMenuItem(
                    value: 1,
                    child: Text('Request Action'),
                  ),
                ]),
      ),
    );
  }
}
