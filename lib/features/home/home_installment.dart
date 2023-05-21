import 'package:flutter/material.dart';
import 'package:utility/util/app_util.dart';
import 'package:utility/widgets/thousands_separator_formatter.dart';

class HomeInstallment extends StatefulWidget {
  const HomeInstallment({super.key});

  @override
  State<HomeInstallment> createState() => _HomeInstallmentState();
}

class _HomeInstallmentState extends State<HomeInstallment> {
  final _frm = GlobalKey<FormState>();
  final TextEditingController homePrice = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget buildTextFormLeftRight(Widget left, Widget right) => Row(
        children: [
          Expanded(
            child: left,
          ),
          Expanded(
            child: right,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    const vd = VisualDensity(
      horizontal: -2,
      vertical: -4,
    );

    final headStyle = theme.textTheme.bodyMedium?.copyWith(
      fontSize: 14.5,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('ผ่อนบ้าน'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _frm,
            child: Column(
              children: [
                buildTextFormLeftRight(
                  Text(
                    'ราคาบ้าน',
                    style: headStyle,
                  ),
                  TextFormField(
                    controller: homePrice,
                    inputFormatters: [
                      AppUtil.numberOnly,
                      ThousandsSeparatorInputFormatter(),
                    ],
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      suffixIconConstraints: BoxConstraints(),
                      suffixIcon: Text('บาท'),
                    ),
                    //onSaved: (newValue) => model = model.copyWith(
                    //  carPrice: NumberFormat().parse(newValue!) as double,
                    //),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
