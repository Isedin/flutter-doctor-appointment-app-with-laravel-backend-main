import 'package:doctor_appointment_app_with_laravel_backend/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppbar(
      {Key? key, this.appTitle, this.route, this.icon, this.actions})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  final String? appTitle;
  final String? route;
  final FaIcon? icon;
  final List<Widget>? actions;

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.white, // background color of this app is white
      elevation: 0,
      title: Text(
        widget.appTitle!,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      // if icon is not set, return null
      leading: widget.icon != null
          ? Container(
              margin: const EdgeInsetsDirectional.symmetric(
                  horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Config.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  // if route is given, then this icon button will naivgate to that route
                  if (widget.route != null) {
                    Navigator.of(context).pushNamed(widget.route!);
                  } else {
                    // else, it will pop the current screen
                    Navigator.of(context).pop();
                  }
                },
                icon: widget.icon!,
                iconSize: 16,
                color: Colors.white,
              ),
            )
          : null,
      // if actions is not set, return null
      actions: widget.actions ?? null,
    );
  }
}
