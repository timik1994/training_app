import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.white,
  primaryColorDark: Color(0xFF39D2C0),
  accentColor: Color(0xFFEE8B60),
  buttonColor: Colors.blue,
  cardColor: Colors.grey[800]!,
  dividerColor: Colors.white,
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.grey[900]!,
    secondary: Colors.grey[800]!,
  ),
  appBarTheme: AppBarTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: Colors.black,
    elevation: 10,
    titleTextStyle:
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
    centerTitle: true,
    iconTheme: IconThemeData(
      size: 30,
      color: Colors.white,
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
  ),
  fontFamily: 'RAILWAY',
  expansionTileTheme: ExpansionTileThemeData(
    iconColor: Colors.white,
    collapsedIconColor: Colors.white,
    backgroundColor: Colors.blue.withOpacity(0.5),
    collapsedBackgroundColor: Colors.blue.withOpacity(0.5),
    textColor: Colors.white,
    collapsedTextColor: Colors.white,
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
    color: Colors.grey[800]!,
    elevation: 10,
    margin: EdgeInsets.all(5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
      side: BorderSide(color: Colors.white, width: 1),
    ),
  ),

  dialogTheme: DialogTheme(
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0),
      ),
      side: BorderSide(color: Colors.white),
    ),
    backgroundColor: Colors.grey[800]!,
    alignment: Alignment.center,
  ),

  dataTableTheme: DataTableThemeData(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
    ),
    // отступы по горизонтали между краями DataTable и содержимым
    //horizontalMargin: 20,
    // расстояние по горизонтали между столбцами
    //columnSpacing: 20,
    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue),
    //headingRowColor: myColor,
    headingTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    dataRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[800]!),
    dataTextStyle: TextStyle(color: Colors.white),
  ),
);
