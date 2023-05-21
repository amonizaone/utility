import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:utility/features/home/car_installment.dart';
import 'package:utility/features/home/home_installment.dart';
import 'package:utility/widgets/app_keyboard_hider_utility.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      //minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return AppKeyboardHiderWrapper(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Utility',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                primary: const Color(0xFFE57C23),
                seedColor: Colors.deepPurple,
              ),
              useMaterial3: true,
            ),
            home: const MyHomePage(title: 'My Utility'),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void gotoPage(Widget page) async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> itemsMenu = [
      _buildMenu(
        icon: const FaIcon(FontAwesomeIcons.house),
        label: 'ผ่อนบ้าน',
        onTab: () => gotoPage(const HomeInstallment()),
      ),
      _buildMenu(
        icon: const FaIcon(FontAwesomeIcons.car),
        label: 'ผ่อนรถ',
        onTab: () => gotoPage(const CarInstallment()),
      ),
      _buildMenu(
        icon: const FaIcon(FontAwesomeIcons.moneyBill),
        label: 'ค่างวดเงินกู้',
      ),
      _buildMenu(
        icon: const FaIcon(FontAwesomeIcons.house),
        label: 'ดอกเบี้ยทบต้น',
      ),
      _buildMenu(
        icon: const FaIcon(FontAwesomeIcons.house),
        label: 'เงินที่มีใช้ได้กี่ปี',
      ),
      _buildMenu(
        icon: const FaIcon(FontAwesomeIcons.moneyBillTransfer),
        label: 'เงินที่มีใช้ได้ปีละ',
      ),
      _buildMenu(
        icon: const FaIcon(FontAwesomeIcons.personCane),
        label: 'วางแผนเกษียณ',
      ),
      _buildMenu(
        icon: const FaIcon(FontAwesomeIcons.house),
        label: 'กองทุนสำรองเลี้ยงชีพ',
      ),
      _buildMenu(
        icon: const FaIcon(FontAwesomeIcons.cartArrowDown),
        label: 'เรียบเทียบเวลา',
      ),
      _buildMenu(
        icon: const FaIcon(FontAwesomeIcons.house),
        label: 'จุดคุ้มทุน',
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, i) {
          return itemsMenu[i];
        },
        separatorBuilder: (context, index) => Divider(
          indent: 10,
          endIndent: 10,
          color: Colors.grey.shade200,
        ),
        itemCount: itemsMenu.length,
      ),
    );
  }

  Widget _buildMenu({
    required Widget icon,
    required String label,
    Function()? onTab,
  }) {
    return ListTile(
      leading: icon,
      title: Text(label),
      iconColor: Theme.of(context).colorScheme.primary,
      onTap: onTab,
    );
  }
}
