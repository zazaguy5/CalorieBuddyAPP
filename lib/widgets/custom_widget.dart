import 'package:flutter/material.dart';

class CustomWidget {
  // UI โหลดข้อมูล
  Future loadingWidget(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.5), // พื้นหลังโปร่งใส
      builder: (context) {
        return Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(20),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 6.0,
            ),
          ),
        );
      },
    );
  }

  Widget titleExpand(BuildContext context, String title, Widget page) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextTheme.of(
            context,
          ).headlineSmall!.copyWith(color: Colors.white),
        ),
        TextButton(
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ทั้งหมด',
                style: TextTheme.of(
                  context,
                ).titleMedium!.copyWith(color: Colors.white),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 20,
              )
              // BlocBuilder<ThemeBloc, ThemeState>(
              //   builder: (context, themeState) {
              //     return Icon(
              //       Icons.keyboard_arrow_down,
              //       color: themeState.themeApp ? Colors.black : Colors.white,
              //       size: 20,
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ],
    );
  }

  AppBar appBarCustom(BuildContext context, String title, List<Widget>? actions, PreferredSize? buttom) {
    return AppBar(centerTitle: true, leading: Padding(
      padding: const EdgeInsets.only(left: 12),
        child: IconButton(
          padding: EdgeInsets.zero,
          iconSize: 20,
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ), title: Text(title, style: TextTheme.of(context).headlineSmall!.copyWith(color: Colors.white)),
      actions: actions,
      bottom: buttom
    );
  }
}
