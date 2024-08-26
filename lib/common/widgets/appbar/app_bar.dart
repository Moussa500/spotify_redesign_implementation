import 'package:flutter/material.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget ? title;
  final Widget ? action;
  final bool ? hidBack;
  final Color ? backgroundColor;
  const BasicAppBar({super.key,this.title,this.hidBack,this.action,this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title??const Text(''),
      actions: [action??Container()],
      centerTitle: true,
      backgroundColor: backgroundColor?? Colors.transparent,
      elevation: 0,
      leading: hidBack==true ? null : IconButton(onPressed: (){Navigator.pop(context);}, icon: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.arrow_back_ios_new,size: 15,color: context.isDarkMode?Colors.white:Colors.black,),
      )),
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}