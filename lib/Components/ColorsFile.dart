import 'package:flutter/material.dart';

class appColors {

  static Color backgroundWhite =Colors.white;
  static Color appOrange =Color.fromRGBO(255, 94, 0, 1);
  static Color textBrown =Color.fromRGBO(127, 78, 29, 1);
  static Color lightPurple =Color.fromRGBO(237, 208, 255, 1);
  static Color lightOrange =Color.fromRGBO(255, 230, 204, 1);
  static Color lightMaroon =Color.fromRGBO(250, 204, 204, 1);
  static Color lightBrown =Color.fromRGBO(251, 193, 189, 1);
  static Color lightYellow =Color.fromRGBO(255, 226 ,153, 1);
  static Color skyBlue =Color.fromRGBO(218, 242 ,252, 1);
  static Color lightGreen =Color.fromRGBO(211, 229 ,196, 1);
  static Color lightPink =Color.fromRGBO(255, 222 ,246, 1);
  static Color cakeYellow =Color.fromRGBO(254, 202 ,151, 1);
  static Color  medMaroon =Color.fromRGBO(255, 192 ,192, 1);
  static Color  textBrown2 =Color.fromRGBO(109, 56 ,5, 1);
  static Color  brownshadow =Color.fromRGBO(109, 56 ,5, 0.2);
  static Color  brownshadow01 =Color.fromRGBO(109, 56 ,5, 0.09);
  static Color  textBrown257 =Color.fromRGBO(109, 56 ,5, 0.57);
  static Color  borderGrey =Color.fromRGBO(243, 243 ,243, 1);
  static Color  hint =Color.fromRGBO(172, 142 ,113, 1);
  static Color darkGrey =Color.fromRGBO(146, 146 ,146, 1);
  static Color  transparent1 =Color.fromRGBO(0,0 ,0, 0);
  static Color  shadow =Color.fromRGBO(196,196 ,196, 1);
  static Color  Ishadow =Color.fromRGBO(243,243 ,243, 1);
  static Color  bgreen =Color.fromRGBO(58,161 ,76, 1);
  static Color  maroon =Color.fromRGBO(164,43 ,50, 1);
  static Color  red =Color.fromRGBO(255, 0, 14, 1.0);

}

class apiIp {
  static String ipAddress = "waywebsolution.com";
}

class myText extends StatelessWidget {
  myText({this.title,this.textAlign, this.depline,this.myStyle,this.maxLines,this.textColor,this.fontWeight,this.fontSize, this.fontfamily, this.lineheight, this.textOverflow});
  final String? title;
  final int? maxLines;
  final TextStyle? myStyle;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;
  final TextDecoration? depline;
  final String? fontfamily;
  final double? lineheight;
  final TextOverflow? textOverflow;



  @override
  Widget build(BuildContext context) {
    final customStyle=TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: depline!=null?TextDecoration.lineThrough:TextDecoration.none,
        fontFamily: fontfamily,
        height: lineheight,
        color: textColor
    );
    return  Text(
      title ?? "",
      overflow: TextOverflow.ellipsis,
      textAlign:(textAlign!=null)?textAlign: TextAlign.start,
      maxLines: (maxLines != null) ? maxLines : 1,
      textScaleFactor: 1.0,
      style: myStyle!=null?myStyle:customStyle,
    );
  }
}