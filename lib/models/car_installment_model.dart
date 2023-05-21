// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum Deposit { amount, percen }

enum Interest { fixed, reduceFlawers }

class CarInstallmentModel {
  final double carPrice;
  final double dispositAmount;
  final double dispositPercent;
  final double crditTotal;
  final double interestFixed;
  final double interestReduceFlawers;
  final double interestTotal;
  final double totalPaymentPerMonth;
  final int totalPerMonth;
  CarInstallmentModel({
    required this.carPrice,
    required this.dispositAmount,
    required this.dispositPercent,
    required this.crditTotal,
    required this.interestFixed,
    required this.interestReduceFlawers,
    required this.interestTotal,
    required this.totalPaymentPerMonth,
    required this.totalPerMonth,
  });

  final Deposit disposit = Deposit.amount;
  final Interest interest = Interest.fixed;

  CarInstallmentModel copyWith({
    double? carPrice,
    double? dispositAmount,
    double? dispositPercent,
    double? crditTotal,
    double? interestFixed,
    double? interestReduceFlawers,
    double? interestTotal,
    double? totalPaymentPerMonth,
    int? totalPerMonth,
  }) {
    return CarInstallmentModel(
      carPrice: carPrice ?? this.carPrice,
      dispositAmount: dispositAmount ?? this.dispositAmount,
      dispositPercent: dispositPercent ?? this.dispositPercent,
      crditTotal: crditTotal ?? this.crditTotal,
      interestFixed: interestFixed ?? this.interestFixed,
      interestReduceFlawers:
          interestReduceFlawers ?? this.interestReduceFlawers,
      interestTotal: interestTotal ?? this.interestTotal,
      totalPaymentPerMonth: totalPaymentPerMonth ?? this.totalPaymentPerMonth,
      totalPerMonth: totalPerMonth ?? this.totalPerMonth,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'carPrice': carPrice,
      'dispositAmount': dispositAmount,
      'dispositPercent': dispositPercent,
      'crditTotal': crditTotal,
      'interestFixed': interestFixed,
      'interestReduceFlawers': interestReduceFlawers,
      'interestTotal': interestTotal,
      'totalPaymentPerMonth': totalPaymentPerMonth,
      'totalPerMonth': totalPerMonth,
    };
  }

  factory CarInstallmentModel.fromMap(Map<String, dynamic> map) {
    return CarInstallmentModel(
      carPrice: map['carPrice'] as double,
      dispositAmount: map['dispositAmount'] as double,
      dispositPercent: map['dispositPercent'] as double,
      crditTotal: map['crditTotal'] as double,
      interestFixed: map['interestFixed'] as double,
      interestReduceFlawers: map['interestReduceFlawers'] as double,
      interestTotal: map['interestTotal'] as double,
      totalPaymentPerMonth: map['totalPaymentPerMonth'] as double,
      totalPerMonth: map['totalPerMonth'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarInstallmentModel.fromJson(String source) =>
      CarInstallmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CarInstallmentModel(carPrice: $carPrice, dispositAmount: $dispositAmount, dispositPercent: $dispositPercent, crditTotal: $crditTotal, interestFixed: $interestFixed, interestReduceFlawers: $interestReduceFlawers, interestTotal: $interestTotal, totalPaymentPerMonth: $totalPaymentPerMonth, totalPerMonth: $totalPerMonth)';
  }

  @override
  bool operator ==(covariant CarInstallmentModel other) {
    if (identical(this, other)) return true;

    return other.carPrice == carPrice &&
        other.dispositAmount == dispositAmount &&
        other.dispositPercent == dispositPercent &&
        other.crditTotal == crditTotal &&
        other.interestFixed == interestFixed &&
        other.interestReduceFlawers == interestReduceFlawers &&
        other.interestTotal == interestTotal &&
        other.totalPaymentPerMonth == totalPaymentPerMonth &&
        other.totalPerMonth == totalPerMonth;
  }

  @override
  int get hashCode {
    return carPrice.hashCode ^
        dispositAmount.hashCode ^
        dispositPercent.hashCode ^
        crditTotal.hashCode ^
        interestFixed.hashCode ^
        interestReduceFlawers.hashCode ^
        interestTotal.hashCode ^
        totalPaymentPerMonth.hashCode ^
        totalPerMonth.hashCode;
  }
}
