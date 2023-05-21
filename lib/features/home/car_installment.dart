import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:utility/models/car_installment_model.dart';
import 'package:utility/util/app_util.dart';
import 'package:utility/widgets/thousands_separator_formatter.dart';

class CarInstallment extends StatefulWidget {
  const CarInstallment({super.key});

  @override
  State<CarInstallment> createState() => _CarInstallmentState();
}

class _CarInstallmentState extends State<CarInstallment> {
  final _frm = GlobalKey<FormState>();

  final TextEditingController carPrice = TextEditingController();
  final TextEditingController dispositPercent = TextEditingController();
  final TextEditingController dispositAmount = TextEditingController();

  final TextEditingController interestFixed = TextEditingController();
  final TextEditingController interestReduceFlawer = TextEditingController();

  final TextEditingController totalPerMonth = TextEditingController();

  Deposit disposit = Deposit.amount;
  Interest interest = Interest.fixed;

  CarInstallmentModel model = CarInstallmentModel(
    carPrice: 0,
    crditTotal: 0,
    interestTotal: 0,
    totalPaymentPerMonth: 0,
    totalPerMonth: 0,
    dispositAmount: 0,
    dispositPercent: 0,
    interestFixed: 0,
    interestReduceFlawers: 0,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onChangeDisposit(Deposit? v) {
    setState(() {
      disposit = v!;
    });
  }

  void onChanageInterest(Interest? v) {
    setState(() {
      interest = v!;
    });
  }

  void discountInterest() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    const vd = VisualDensity(
      horizontal: -2,
      vertical: -4,
    );

    final headStyle = theme.textTheme.bodyMedium?.copyWith(
      fontSize: 14.5,
      fontWeight: FontWeight.bold,
    );
    Widget subDescription(String title, String value) {
      return Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(value),
          ],
        ),
      );
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

    double toPercent(String v1, String v2) {
      return NumberFormat().parse(v1) * 100 / NumberFormat().parse(v2).round();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('ผ่อนรถ'),
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
                    'ราคารถ',
                    style: headStyle,
                  ),
                  TextFormField(
                    controller: carPrice,
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
                    onSaved: (newValue) => model = model.copyWith(
                      carPrice: NumberFormat().parse(newValue!) as double,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'เงินดาวน์',
                    style: headStyle,
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              contentPadding: const EdgeInsets.only(left: 5),
                              visualDensity: vd,
                              dense: true,
                              value: Deposit.amount,
                              title: const Text('จำนวนเงิน'),
                              groupValue: disposit,
                              onChanged: onChangeDisposit,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: dispositAmount,
                              enabled: disposit == Deposit.amount,
                              inputFormatters: [
                                AppUtil.numberOnly,
                                ThousandsSeparatorInputFormatter(),
                              ],
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              textAlign: TextAlign.right,
                              decoration: const InputDecoration(
                                suffixIconConstraints: BoxConstraints(),
                                suffixIcon: Text('บาท'),
                              ),
                              onSaved: (newValue) => disposit == Deposit.amount
                                  ? model = model.copyWith(
                                      dispositAmount: NumberFormat()
                                          .parse(newValue!) as double,
                                      dispositPercent: NumberFormat()
                                              .parse(dispositPercent.text)
                                          as double,
                                    )
                                  : null,
                              onChanged: (v) {
                                if (v != '') {
                                  dispositPercent.text = AppUtil.format2Disgit
                                      .format(toPercent(v, carPrice.text));
                                }
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              visualDensity: vd,
                              contentPadding: const EdgeInsets.only(left: 5),
                              dense: true,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: Deposit.percen,
                              title: const Text('เปอร์เซ็น'),
                              groupValue: disposit,
                              onChanged: onChangeDisposit,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: dispositPercent,
                              enabled: disposit == Deposit.percen,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              inputFormatters: [
                                AppUtil.allowDecimal,
                              ],
                              textAlign: TextAlign.right,
                              decoration: const InputDecoration(
                                suffixIconConstraints: BoxConstraints(),
                                suffixIcon: Text('%'),
                              ),
                              onSaved: (newValue) => disposit == Deposit.percen
                                  ? model = model.copyWith(
                                      dispositPercent: NumberFormat()
                                          .parse(newValue!) as double,
                                      dispositAmount: NumberFormat()
                                          .parse(dispositAmount.text) as double,
                                    )
                                  : null,
                              onChanged: (v) {
                                if (v != '' && carPrice.text != '') {
                                  double per =
                                      NumberFormat().parse(v) as double;

                                  dispositAmount.text = AppUtil.format2Disgit
                                      .format((per / 100) *
                                          AppUtil.format2Disgit
                                              .parse(carPrice.text));
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'อัตราดอกเบี้ย/ต่อปี',
                    style: headStyle,
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              contentPadding: const EdgeInsets.only(left: 5),
                              dense: true,
                              value: Interest.fixed,
                              title: const Text('คงที่'),
                              groupValue: interest,
                              onChanged: onChanageInterest,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: interestFixed,
                              enabled: interest == Interest.fixed,
                              inputFormatters: [
                                AppUtil.allowDecimal,
                              ],
                              textAlign: TextAlign.right,
                              decoration: const InputDecoration(
                                suffixIconConstraints: BoxConstraints(),
                                suffixIcon: Text('%'),
                              ),
                              onSaved: (newValue) => interest == Interest.fixed
                                  ? model = model.copyWith(
                                      interestTotal: NumberFormat()
                                          .parse(newValue!) as double,
                                    )
                                  : null,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              contentPadding: const EdgeInsets.only(left: 5),
                              dense: true,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: Interest.reduceFlawers,
                              title: const Text('ลดต้น/ดอก'),
                              groupValue: interest,
                              onChanged: onChanageInterest,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: interestReduceFlawer,
                              enabled: interest == Interest.reduceFlawers,
                              textAlign: TextAlign.right,
                              decoration: const InputDecoration(
                                suffixIconConstraints: BoxConstraints(),
                                suffixIcon: Text('%'),
                              ),
                              inputFormatters: [
                                AppUtil.numberOnly,
                              ],
                              onSaved: (newValue) =>
                                  interest == Interest.reduceFlawers
                                      ? model = model.copyWith(
                                          interestTotal: NumberFormat()
                                              .parse(newValue!) as double,
                                        )
                                      : null,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                buildTextFormLeftRight(
                  Text(
                    'จำนวนงวด',
                    style: headStyle,
                  ),
                  TextFormField(
                    controller: totalPerMonth,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      suffixIconConstraints: BoxConstraints(),
                      suffixIcon: Text('เดือน'),
                    ),
                    inputFormatters: [
                      AppUtil.numberOnly,
                    ],
                    onSaved: (newValue) => model = model.copyWith(
                      totalPerMonth: int.tryParse(newValue!),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: size.width,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(.4),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Summary',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        ListTile(
                          visualDensity: vd,
                          dense: true,
                          title: const Text('ราคารถ'),
                          trailing: Text(
                            '${AppUtil.format2Disgit.format(model.carPrice)} บาท',
                          ),
                          minVerticalPadding: 1,
                        ),
                        ListTile(
                          visualDensity: vd,
                          dense: true,
                          title: const Text('เงินดาวน์'),
                          trailing: Text(
                            '${AppUtil.format2Disgit.format(model.dispositAmount)} บาท',
                          ),
                          minVerticalPadding: 1,
                        ),
                        ListTile(
                          visualDensity: vd,
                          dense: true,
                          title: const Text('ยอดจัดสินเชื่อ'),
                          trailing: Text(
                            '${AppUtil.format2Disgit.format(model.carPrice - model.dispositAmount)} บาท',
                          ),
                          minVerticalPadding: 1,
                        ),
                        ListTile(
                          visualDensity: vd,
                          dense: true,
                          title: const Text('ดอกเบี้ย'),
                          minVerticalPadding: 1,
                          subtitle: Column(
                            children: [
                              subDescription(
                                'ดอกเบี้ยคงที่',
                                '${model.interestTotal}%',
                              ),
                              subDescription(
                                'ดอกเบี้ยลดต้น/ดอก',
                                '%',
                              ),
                              subDescription(
                                'ดอกเบี้ยทั้งหมด',
                                'บาท',
                              ),
                            ],
                          ),
                        ),
                        const ListTile(
                          visualDensity: vd,
                          dense: true,
                          title: Text('สินเชื่อรวมดอกเบี้ย'),
                          trailing: Text('บาท'),
                          minVerticalPadding: 1,
                        ),
                        const ListTile(
                          visualDensity: vd,
                          dense: true,
                          title: Text('จ่ายค่างวด'),
                          trailing: Text('บาท/เดือน'),
                          minVerticalPadding: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black87,
                ),
                onPressed: () {
                  _frm.currentState?.reset();
                  setState(() {});
                },
                child: const Text('ล้าง'),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (!_frm.currentState!.validate()) {
                    return;
                  }

                  _frm.currentState?.save();
                  setState(() {});
                  //model = model.copyWith();

                  debugPrint(model.toString());
                },
                child: const Text('คำนวณ'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
