import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';

class Event {
  final List<Resource> requirements;
  final List<Resource> outcome;
  final String localizedTitleKey;
  final String localizedTextKey;
  final String iconPath;

  Event(
      {required this.outcome,
      required this.iconPath,
      required this.requirements,
      required this.localizedTitleKey,
      required this.localizedTextKey});

  Map<String, dynamic> toJson() {
    return {
      "requirements": requirements.map((res) => res.toJson()).toList(),
      "outcome": outcome.map((res) => res.toJson()).toList(),
      "localizedTextKey": localizedTextKey,
      "localizedTitleKey": localizedTitleKey,
      "iconPath": iconPath,
    };
  }

  static Event fromJson(Map<String, dynamic> input) {
    List requirements = input["requirements"];
    List outcome = input["outcome"];
    return Event(
      localizedTextKey: input["localizedTextKey"],
      localizedTitleKey: input["localizedTitleKey"],
      requirements: requirements.map((e) => Resource.fromJson(e)).toList(),
      outcome: outcome.map((e) => Resource.fromJson(e)).toList(),
      iconPath: input["iconPath"],
    );
  }
}
