import 'package:flutter/material.dart';


class ToggleSwitch extends StatelessWidget {
 final bool value;
 final Function(bool) onToggle;
 final double width;
 final double height;
 final Color activeColor;
 final Color inactiveColor;
 final Duration duration;


 const ToggleSwitch({
   Key? key,
   required this.value,
   required this.onToggle,
   this.width = 57,
   this.height = 26,
   this.activeColor = const Color(0xFFB2C48D),
   this.inactiveColor = const Color(0xFFEAEAEA),
   this.duration = const Duration(milliseconds: 300),
 }) : super(key: key);


 @override
 Widget build(BuildContext context) {
   return GestureDetector(
     onTap: () => onToggle(!value),
     child: AnimatedContainer(
       duration: duration,
       width: width,
       height: height,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(height / 2),
         color: value ? activeColor : inactiveColor,
       ),
       child: Stack(
         children: [
           AnimatedPositioned(
             duration: duration,
             curve: Curves.easeInOut,
             left: value ? width - height + 2 : 2,
             top: 2,
             child: Container(
               width: height - 4,
               height: height - 4,
               decoration: const BoxDecoration(
                 shape: BoxShape.circle,
                 color: Colors.white,
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black12,
                     blurRadius: 3,
                     offset: Offset(0, 1),
                   ),
                 ],
               ),
             ),
           ),
         ],
       ),
     ),
   );
 }
}


