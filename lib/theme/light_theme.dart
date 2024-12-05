import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.black,
  primaryColorDark: Color(0xFF39D2C0),
  accentColor: Color(0xFFEE8B60),
  buttonColor: Colors.blue,
  cardColor: Colors.white,
  dividerColor: Colors.black,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.grey[50]!,
    secondary: Colors.grey[100]!,
  ),
  appBarTheme: AppBarTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: Colors.white,
    elevation: 10,
    titleTextStyle: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
    centerTitle: true,
    iconTheme: IconThemeData(
      size: 30,
      color: Colors.black,
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
  ),
  fontFamily: 'RAILWAY',
  expansionTileTheme: ExpansionTileThemeData(
    iconColor: Colors.black,
    collapsedIconColor: Colors.black,
    backgroundColor: Colors.blue.withOpacity(0.5),
    collapsedBackgroundColor: Colors.blue.withOpacity(0.5),
    textColor: Colors.black,
    collapsedTextColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    // закругленные края в нераскрытом виде
    collapsedShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    tilePadding: EdgeInsets.all(5),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 10,
    margin: EdgeInsets.all(5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
      side: BorderSide(color: Colors.black, width: 1),
    ),
  ),
  dialogTheme: DialogTheme(
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
      side: BorderSide(color: Colors.black),
    ),
    backgroundColor: Colors.white,
    alignment: Alignment.center,
  ),

  dataTableTheme: DataTableThemeData(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
    ),
    // отступы по горизонтали между краями DataTable и содержимым
    //horizontalMargin: 20,
    // расстояние по горизонтали между столбцами
    //columnSpacing: 20,
    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue),
    //headingRowColor: myColor,
    headingTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
    dataTextStyle: TextStyle(color: Colors.black),
  ),
);
