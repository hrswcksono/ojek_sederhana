import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app/routes/app_pages.dart';
import 'utils/themes/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: Routes.BASE,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            titleMedium: GoogleFonts.poppins(),
          ),
          inputDecorationTheme: InputDecorationTheme(
            errorMaxLines: 1,
            // iconColor: CustomColor.disable,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: const Color.fromRGBO(245, 246, 250, 1),
            hintStyle: GoogleFonts.inter(
              fontSize: 15,
              color: const Color.fromRGBO(143, 149, 158, 1),
            ),
            // errorStyle: CustomFonts.poppinsRegular12.copyWith(
            //   color: CustomColor.red,
            // ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(
                double.infinity,
                48,
              ),
              elevation: 0,
              textStyle: GoogleFonts.inter(),
              backgroundColor: CustomColor.mainGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )),
    );
  }
}
