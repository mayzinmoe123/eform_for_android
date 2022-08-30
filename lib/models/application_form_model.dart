class ApplicationFormModel {
  // user_id: 6, apply_type: 1, apply_sub_type: 3, apply_division: 1, date: 2022-08-10, updated_at: 2022-08-10 14:10:34, created_at: 2022-08-10 14:10:34, id: 1440

  String id;
  String userId;
  String applyType;
  String applySubType;
  String applyDivision;
  String isReligion;
  String serialCode;
  String fullname;
  String nrc;
  String appliedPhone;
  String jobType;
  String position;
  String department;
  String salary;
  String appliedBuildingType;
  String appliedHomeNo;
  String appliedBuilding;
  String appliedLane;
  String appliedStreet;
  String appliedQuarter;
  String appliedTown;
  String townshipId;
  String districtId;
  String divStateId;
  String date;
  String businessName;
  String isLight;
  String applyTsfType;
  String poleType;
  String createdAt;
  String updatedAt;

  // ApplicationFormModel({
  //   required this.id,
  //   required this.userId,
  //   required this.applyType,
  //   required this.applySubType,
  //   required this.applyDivision,
  //   required this.isReligion,
  //   required this.serialCode,
  //   required this.fullname,
  //   required this.nrc,
  //   required this.appliedPhone,
  //   required this.jobType,
  //   required this.position,
  //   required this.department,
  //   required this.salary,
  //   required this.appliedBuildingType,
  //   required this.appliedHomeNo,
  //   required this.appliedBuilding,
  //   required this.appliedLane,
  //   required this.appliedStreet,
  //   required this.appliedQuarter,
  //   required this.appliedTown,
  //   required this.townshipId,
  //   required this.districtId,
  //   required this.divStateId,
  //   required this.date,
  //   required this.businessName,
  //   required this.isLight,
  //   required this.applyTsfType,
  //   required this.poleType,
  //   required this.createdAt,
  //   required this.updatedAt,
  // });

  ApplicationFormModel.mapToObject(Map map)
      : id = map["id"].toString(),
        userId = map["user_id"].toString(),
        applyType = map["apply_type"].toString(),
        applySubType = map["apply_sub_type"].toString(),
        applyDivision = map["apply_division"].toString(),
        isReligion = map["apply_division"].toString(),
        serialCode = map["serial_code"].toString(),
        fullname = map["fullname"].toString(),
        nrc = map["nrc"].toString(),
        appliedPhone = map["applied_phone"].toString(),
        jobType = map["job_type"].toString(),
        position = map["position"].toString(),
        department = map["department"].toString(),
        salary = map["salary"].toString(),
        appliedBuildingType = map["applied_building_type"].toString(),
        appliedHomeNo = map["applied_home_no"].toString(),
        appliedBuilding = map["applied_building"].toString(),
        appliedLane = map["applied_lane"].toString(),
        appliedStreet = map["applied_street"].toString(),
        appliedQuarter = map["applied_quarter"].toString(),
        appliedTown = map["applied_town"].toString(),
        townshipId = map["township_id"].toString(),
        districtId = map["district_id"].toString(),
        divStateId = map["div_state_id"].toString(),
        date = map["date"].toString(),
        businessName = map["business_name"].toString(),
        isLight = map["is_light"].toString(),
        applyTsfType = map["apply_tsf_type"].toString(),
        poleType = map["pole_type"].toString(),
        createdAt = map["created_at"].toString(),
        updatedAt = map["updated_at"].toString();
}
