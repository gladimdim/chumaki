import 'package:chumaki/models/resources/resource.dart';

class Event {
  final List<Resource> requirements;
  final String localizedKey;
  final String iconPath;
  final Money payment;

  Event({
    required this.iconPath,
    required this.payment,
    required this.requirements,
    required this.localizedKey,
  });

  bool isDone() {
    return requirements.isEmpty;
  }

  String get localizedKeyTitle {
    return localizedKey + "Title";
  }

  String get localizedKeyText {
    return localizedKey + "Text";
  }

  Map<String, dynamic> toJson() {
    return {
      "requirements": requirements.map((res) => res.toJson()).toList(),
      "localizedKey": localizedKey,
      "iconPath": iconPath,
      "payment": payment.amount,
    };
  }

  static Event fromJson(Map<String, dynamic> input) {
    List requirements = input["requirements"];
    double payment = input["payment"] ?? 0.0;
    return Event(
      localizedKey: input["localizedKey"],
      requirements: requirements.map((e) => Resource.fromJson(e)).toList(),
      iconPath: input["iconPath"],
      payment: Money(payment),
    );
  }

  void decreaseResource(Resource res) {
    final resource =
        requirements.firstWhere((element) => element.sameType(res));
    resource.amount = resource.amount - res.amount;
    if (resource.amount <= 0) {
      requirements.remove(resource);
    }
  }
}
