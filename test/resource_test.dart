import 'package:chumaki/models/resources/resource.dart';
import 'package:test/test.dart';

void main() {
  group("JSON Resource object", () {
    test("Can serialize/deserialize Resource object", () {
     var resource = Bread(33);
     var newResource = Resource.fromJson(resource.toJson());
     expect(newResource.amount, equals(resource.amount), reason: "Amount restored");
     expect (newResource, isA<Bread>(), reason: "Class restored.");
     expect (newResource.weightPerPoint, equals(resource.weightPerPoint), reason: "Weight restored.");
    });
  });
}
