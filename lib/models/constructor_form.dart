class ConstructorForm {
  String id;
  String applicationFormId;
  String roomCount;
  String pMeter10;
  String pMeter20;
  String pMeter30;
  String meter;
  String waterMeter;
  String elevatorMeter;
  String apartmentCount;
  String floorCount;
  String createdAt;
  String updatedAt;

  ConstructorForm.mapToObject(Map map)
      : id = map["id"].toString(),
        applicationFormId = map["application_form_id"].toString(),
        roomCount = map["room_count"].toString(),
        pMeter10 = map["pMeter10"].toString(),
        pMeter20 = map["pMeter20"].toString(),
        pMeter30 = map["pMeter30"].toString(),
        meter = map["meter"].toString(),
        waterMeter = map["water_meter"].toString(),
        elevatorMeter = map["elevator_meter"].toString(),
        apartmentCount = map["apartment_count"].toString(),
        floorCount = map["floor_count"].toString(),
        createdAt = map["created_at"].toString(),
        updatedAt = map["updated_at"].toString();
}
