import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/yangon/commerical_transformer/ct_form01_rules.dart';
import 'package:flutter_application_1/pages/yangon/commerical_transformer/ct_form02_promise.dart';
import 'package:flutter_application_1/pages/yangon/residential/Overview.dart';
import 'package:flutter_application_1/pages/yangon/residential/r06_household.dart';
import 'package:flutter_application_1/pages/yangon/residential/r07_recommend.dart';
import 'package:flutter_application_1/pages/yangon/residential/r08_ownership.dart';
import 'package:flutter_application_1/pages/yangon/residential/r09_farmland.dart';
import 'package:flutter_application_1/pages/yangon/residential/r10_building.dart';
import 'package:flutter_application_1/pages/yangon/residential/r11_power.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Authentication
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/pages/auth/register.dart';

// division choice
import 'package:flutter_application_1/pages/division_choice.dart';

// Yangon
import 'package:flutter_application_1/pages/yangon/meter_apply_choice.dart';
// Yangon > Residential
import 'package:flutter_application_1/pages/yangon/residential/r01_rules.dart';
import 'package:flutter_application_1/pages/yangon/residential/r02_promise.dart';
import 'package:flutter_application_1/pages/yangon/residential/r03_money.dart';
import 'package:flutter_application_1/pages/yangon/residential/r04_info.dart';
import 'package:flutter_application_1/pages/yangon/residential/r05_nrc.dart';

import 'package:flutter_application_1/pages/mandalay/commerical_power/cp_form01_rules_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/commerical_power/cp_form02_promise_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/commerical_power/cp_form03_money_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/commerical_power/cp_form04_info_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/commerical_power/cp_form05_n_r_c_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/commerical_power/cp_form06_household_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/commerical_power/cp_form07_recommend_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/commerical_power/cp_form09_license_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/commerical_power/cp_form10_y_c_d_c_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/commerical_power/cp_form11_gov_allow_mdy%20copy.dart';
import 'package:flutter_application_1/pages/mandalay/contractor/c_form01_rules_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/contractor/c_form02_promise_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/contractor/c_form03_meter_type_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/contractor/c_form04_info_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/contractor/c_form05_n_r_c_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/contractor/c_form06_household_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/contractor/c_form07_recommend_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/contractor/c_form09_allow_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/contractor/c_form10_live_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/contractor/c_form11_y_c_d_c_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/contractor/c_form12_meter_bill_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/residential/r_form01_rules_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/residential/r_form02_promise_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/residential/r_form03_money_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/residential/r_form04_info_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/residential/r_form05_n_r_c_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/residential/r_form06_household_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/residential/r_form07_recommend_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/residential/r_form08_ownership_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/residential_power/rp_form01_rules_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/residential_power/rp_form02_promise_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/residential_power/rp_form03_money_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/residential_power/rp_form04_info_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/residential_power/rp_form05_n_r_c_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/residential_power/rp_form06_household_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/residential_power/rp_form07_recommend_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/residential_power/rp_form08_ownership_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/transformer/t_form01_rules_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/transformer/t_form02_promise_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/transformer/t_form03_money_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/transformer/t_form04_info_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/transformer/t_form05_n_r_c_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/transformer/t_form06_household_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/transformer/t_form07_recommend_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/transformer/t_form08_ownership_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/transformer/t_form09_license_mdy.dart';
import 'package:flutter_application_1/pages/mandalay/transformer/t_form10_y_c_d_c_mdy.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form01_rules.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form02_promise.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form03_money.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form04_info.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form05_n_r_c.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form06_household.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form07_recommend.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form08_ownership.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form09_license.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form10_power.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form11_current_meter.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form12_farm_land.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form13_building.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form01_rules.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form02_promise.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form03_meter_type.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form04_info.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form05_n_r_c.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form06_household.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form07_recommend.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form08_ownership.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form09_allow.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form10_live.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form11_y_c_d_c.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form12_meter_bill.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form13_farm_land.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form14_building.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form15_apartment.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form16_building_drawing.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form17_location.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form_18_sign.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form01_rules.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form02_promise.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form03_money.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form04_info.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form05_n_r_c.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form06_household.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form07_recommend.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form08_ownership.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form09_power.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form10_current_meter.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form11_farm_land.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form12_building.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form01_rules.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form03_money.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form04_info.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form05_n_r_c.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form06_household.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form07_recommend.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form08_ownership.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form09_license.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form10_y_c_d_c.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form11_farm_land.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form12_zone.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form13_power.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/yangon/commerical_transformer/ct_form03_money.dart';
import 'pages/yangon/commerical_transformer/ct_form04_info.dart';
import 'pages/yangon/commerical_transformer/ct_form05_n_r_c.dart';
import 'pages/yangon/commerical_transformer/ct_form06_household.dart';
import 'pages/yangon/commerical_transformer/ct_form07_recommend.dart';
import 'pages/yangon/commerical_transformer/ct_form08_ownership.dart';
import 'pages/yangon/commerical_transformer/ct_form09_license.dart';
import 'pages/yangon/commerical_transformer/ct_form10_y_c_d_c.dart';
import 'pages/yangon/commerical_transformer/ct_form11_farm_land.dart';
import 'pages/yangon/commerical_transformer/ct_form12_zone.dart';
import 'pages/yangon/commerical_transformer/ct_form13_power.dart';
import 'pages/yangon/transformer/t_form02_promise.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initializePrefs();
  }

  initializePrefs() async {
    // String apiPath = "http://localhost/eform/public/";
    String apiPath = "http://192.168.99.124/eform/public/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('api_path', apiPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Login(),
        '/register': (context) => Register(),
        '/division_choice': (context) => DivisionChoice(),

        // Yangon
        '/yangon/meter': (context) => MeterApplyChoice(),
        // Residential
        '/yangon/residential/r01_rules': (context) => R01Rules(),
        '/yangon/residential/r02_promise': (context) => R02Promise(),
        // '/': (context) => R03Money(),
        '/yangon/residential/r03_money': (context) => R03Money(),
        '/yangon/residential/r04_info': (context) => R04Info(),
        '/yangon/residential/r05_nrc': (context) => R05Nrc(),
        '/yangon/residential/r06_household': (context) => R06HouseHold(),
        '/yangon/residential/r07_recommend': (context) => R07Recommend(),
        '/yangon/residential/r08_ownership': (context) => R08Ownership(),
        '/yangon/residential/r09_farmland': (context) => R09Farmland(),
        '/yangon/residential/r10_building': (context) => R10Building(),
        '/yangon/residential/r11_power': (context) => R11Power(),
        '/yangon/residential/overview': (context) => Overview(),

        ///Yangon Power Residential
        // '/yangon/residential_power/Form01_rules' : (context) => Form01Rules(),
        '/yangon/residential_power/rp_form01_rules': (context) =>
            RpForm01Rules(),
        '/yangon/residential_power/rp_form02_promise': (context) =>
            RpForm02Promise(),
        '/yangon/residential_power/rp_form03_money': (context) =>
            RpForm03Money(),
        '/yangon/residential_power/rp_form04_info': (context) => RpForm04Info(),
        '/yangon/residential_power/rp_form05_n_r_c': (context) => RpForm05NRC(),
        // '/': (context) => RpForm08Ownership(),
        '/yangon/residential_power/rp_form06_household': (context) =>
            RpForm06Household(),
        '/yangon/residential_power/rp_form07_recommend': (context) =>
            RpForm07Recommend(),
        '/yangon/residential_power/rp_form08_ownership': (context) =>
            RpForm08Ownership(),
        '/yangon/residential_power/rp_form09_power': (context) =>
            RpForm09Power(),
        '/yangon/residential_power/rp_form10_meter': (context) =>
            RpForm10CurrentMeter(),
        '/yangon/residential_power/rp_form11_farm_land': (context) =>
            RpForm11FarmLand(),
        '/yangon/residential_power/rp_form12_building': (context) =>
            RpForm12Building(),

        //Yangon COmmerical
        '/yangon/commerical_power/rp_form01_rules': (context) =>
            CpForm01Rules(),
        '/yangon/commerical_power/rp_form02_promise': (context) =>
            CpForm02Promise(),
        '/yangon/commerical_power/rp_form03_money': (context) =>
            CpForm03Money(),
        '/yangon/commerical_power/rp_form04_info': (context) => CpForm04Info(),
        '/yangon/commerical_power/rp_form05_n_r_c': (context) => CpForm05NRC(),
        '/yangon/commerical_power/rp_form06_household': (context) =>
            CpForm06Household(),
        '/yangon/commerical_power/rp_form07_recommend': (context) =>
            CpForm07Recommend(),
        '/yangon/commerical_power/rp_form08_ownership': (context) =>
            CpForm08Ownership(),
        '/yangon/commerical_power/rp_form09_license': (context) =>
            CpForm09License(),
        '/yangon/commerical_power/rp_form10_power': (context) =>
            CpForm10Power(),
        '/yangon/commerical_power/rp_form11_meter': (context) =>
            CpForm11CurrenMeter(),
        '/yangon/commerical_power/rp_form12_farm_land': (context) =>
            CpForm12FarmLand(),
        '/yangon/commerical_power/rp_form13_building': (context) =>
            CpForm13Building(),

        //Yangon Contractor
        '/yangon/contractor/c_form01_rules': (context) => CForm01Rules(),
        '/yangon/contractor/c_form02_promise': (context) => CForm02Promise(),
        '/yangon/contractor/c_form03_money_type': (context) =>
            CForm03MeterType(),
        '/yangon/contractor/c_form04_info': (context) => CForm04Info(),
        '/yangon/contractor/c_form05_n_r_c': (context) => CForm05NRC(),
        '/yangon/contractor/c_form06_household': (context) =>
            CForm06Household(),
        '/yangon/contractor/c_form07_recommend': (context) =>
            CForm07Recommend(),
        '/yangon/contractor/c_form08_ownership': (context) =>
            CForm08Ownership(),
        '/yangon/contractor/c_form09_allow': (context) => CForm09Allow(),
        '/yangon/contractor/c_form10_live': (context) => CForm10Live(),
        '/yangon/contractor/c_form11_y_c_d_c': (context) => CForm11YCDC(),
        '/yangon/contractor/c_form12_meter_bill': (context) =>
            CForm12MeterBill(),
        '/yangon/contractor/c_form13_farm_land': (context) => CForm13FarmLand(),
        '/yangon/contractor/c_form14_building_photo': (context) =>
            CForm14Building(),
        '/yangon/contractor/c_form15_apartment_photo': (context) =>
            CForm15Apartment(),
        '/yangon/contractor/c_form16_building_drawing': (context) =>
            CForm16BuildingDrawing(),
        '/yangon/contractor/c_form17_location': (context) => CForm17Location(),
        '/yangon/contractor/c_form18_sign': (context) => CForm18Sign(),

        //Yangon Transformer
        '/yangon/transformer/t_form01_rules': (context) => TForm01Rules(),
        '/yangon/transformer/t_form02_promise': (context) => TForm02Promise(),
        '/yangon/transformer/t_form03_money_type': (context) => TForm03Money(),
        '/yangon/transformer/t_form04_info': (context) => TForm04Info(),
        '/yangon/transformer/t_form05_n_r_c': (context) => TForm05NRC(),
        '/yangon/transformer/t_form06_household': (context) =>
            TForm06Household(),
        '/yangon/transformer/t_form07_recommend': (context) =>
            TForm07Recommend(),
        '/yangon/transformer/t_form08_ownership': (context) =>
            TForm08Ownership(),
        '/yangon/transformer/t_form09_allow': (context) => TForm09License(),
        '/yangon/transformer/t_form10_live': (context) => TForm10YCDC(),
        '/yangon/transformer/t_form11_y_c_d_c': (context) => TForm11FarmLand(),
        '/yangon/transformer/t_form12_meter_bill': (context) => TForm12Zone(),
        '/yangon/transformer/t_form13_farm_land': (context) => TForm13Power(),

        //Yangon Transformer Commerical
        '/yangon/commerical_transformer/ct_form01_rules': (context) =>
            CtForm01Rules(),
        '/yangon/commerical_transformer/ct_form02_promise': (context) =>
            CtForm02Promise(),
        '/yangon/commerical_transformer/ct_form03_money_type': (context) =>
            CtForm03Money(),
        '/yangon/commerical_transformer/ct_form04_info': (context) =>
            CtForm04Info(),
        '/yangon/commerical_transformer/ct_form05_n_r_c': (context) =>
            CtForm05NRC(),
        '/yangon/commerical_transformer/ct_form06_household': (context) =>
            CtForm06Household(),
        '/yangon/commerical_transformer/ct_form07_recommend': (context) =>
            CtForm07Recommend(),
        '/yangon/commerical_transformer/ct_form08_ownership': (context) =>
            CtForm08Ownership(),
        '/yangon/commerical_transformer/ct_form09_allow': (context) =>
            CtForm09License(),
        '/yangon/commerical_transformer/ct_form10_live': (context) =>
            CtForm10YCDC(),
        '/yangon/commerical_transformer/ct_form11_y_c_d_c': (context) =>
            CtForm11FarmLand(),
        '/yangon/commerical_transformer/ct_form12_meter_bill': (context) =>
            CtForm12Zone(),
        '/yangon/commerical_transformer/ct_form13_farm_land': (context) =>
            CtForm13Power(),

        //Mandalay

        //Residential
        '/mandalay/residential/r_form01_rules_mdy': (context) =>
            RForm01RulesMdy(),
        '/mandalay/residential/r_form02_promise_mdy': (context) =>
            RForm02PromiseMdy(),
        '/mandalay/residential/r_form03_money_mdy': (context) =>
            RForm03MoneyMdy(),
        '/mandalay/residential/r_form04_info_mdy': (context) =>
            RForm04InfoMdy(),
        '/mandalay/residential/r_form05_n_r_c_mdy': (context) =>
            RForm05NRCMdy(),
        '/mandalay/residential/r_form06_household_mdy': (context) =>
            RForm06HouseholdMdy(),
        '/mandalay/residential/r_form07_recommend_mdy': (context) =>
            RForm07RecommendMdy(),
        '/mandalay/residential/r_form08_ownership_mdy': (context) =>
            RForm08OwnershipMdy(),

        //Residential   Power
        '/mandalay/residential_power/rp_form01_rules_mdy': (context) =>
            RpForm01RulesMdy(),
        '/mandalay/residential_power/rp_form02_promise_mdy': (context) =>
            RpForm02PromiseMdy(),
        '/mandalay/residential_power/rp_form03_money_mdy': (context) =>
            RpForm03MoneyMdy(),
        '/mandalay/residential_power/rp_form04_info_mdy': (context) =>
            RpForm04InfoMdy(),
        '/mandalay/residential_power/rp_form05_n_r_c_mdy': (context) =>
            RpForm05NRCMdy(),
        '/mandalay/residential_power/rp_form06_household_mdy': (context) =>
            RpForm06HouseholdMdy(),
        '/mandalay/residential_power/rp_form07_recommend_mdy': (context) =>
            RpForm07RecommendMdy(),
        '/mandalay/residential_power/rp_form08_ownership_mdy': (context) =>
            RpForm08OwnershipMdy(),

        //Residential Commerical Transformer
        '/mandalay/commerical_power/cp_form01_rules_mdy': (context) =>
            CpForm01RulesMdy(),
        '/mandalay/commerical_power/cp_form02_promise_mdy': (context) =>
            CpForm02PromiseMdy(),
        '/mandalay/commerical_power/cp_form03_money_mdy': (context) =>
            CpForm03MoneyMdy(),
        '/mandalay/commerical_power/cp_form04_info_mdy': (context) =>
            CpForm04InfoMdy(),
        '/mandalay/commerical_power/cp_form05_n_r_c_mdy': (context) =>
            CpForm05NRCMdy(),
        '/mandalay/commerical_power/cp_form06_household_mdy': (context) =>
            CpForm06HouseholdMdy(),
        '/mandalay/commerical_power/cp_form07_recommend_mdy': (context) =>
            CpForm07RecommendMdy(),
        '/mandalay/commerical_power/cp_form08_ownership_mdy': (context) =>
            CpForm08Ownership(),
        '/mandalay/commerical_power/cp_form09_license_mdy': (context) =>
            CpForm09LicenseMdy(),
        '/mandalay/commerical_power/cp_form10_y_c_d_c_mdy': (context) =>
            CpForm10YCDCMdy(),
        '/mandalay/commerical_power/cp_form11_gov_allow_mdy': (context) =>
            CpForm11GovAllowMdy(),

        // Mandalay Contractor
        '/mandalay/contractor/c_form01_rules_mdy': (context) =>
            CForm01RulesMdy(),
        '/mandalay/contractor/c_form02_promise_mdy': (context) =>
            CForm02PromiseMdy(),
        '/mandalay/contractor/c_form03_money_type_mdy': (context) =>
            CForm03MeterTypeMdy(),
        '/mandalay/contractor/c_form04_info_mdy': (context) => CForm04InfoMdy(),
        '/mandalay/contractor/c_form05_n_r_c_mdy': (context) => CForm05NRCMdy(),
        '/mandalay/contractor/c_form06_household_mdy': (context) =>
            CForm06HouseholdMdy(),
        '/mandalay/contractor/c_form07_recommend_mdy': (context) =>
            CForm07RecommendMdy(),
        '/mandalay/contractor/c_form08_ownership_mdy': (context) =>
            CForm08Ownership(),
        '/mandalay/contractor/c_form09_allow_mdy': (context) =>
            CForm09AllowMdy(),
        '/mandalay/contractor/c_form10_live_mdy': (context) => CForm10LiveMdy(),
        '/mandalay/contractor/c_form11_y_c_d_c_mdy': (context) =>
            CForm11YCDCMdy(),
        '/mandalay/contractor/c_form12_meter_bill_mdy': (context) =>
            CForm12MeterBillMdy(),

        //Mandalay transformer
        '/mandalay/transformer/t_form01_rules_mdy': (context) =>
            TForm01RulesMdy(),
        '/mandalay/transformer/t_form02_promise_mdy': (context) =>
            TForm02PromiseMdy(),
        '/mandalay/transformer/t_form03_money_type_mdy': (context) =>
            TForm03MoneyMdy(),
        '/mandalay/transformer/t_form04_info_mdy': (context) =>
            TForm04InfoMdy(),
        '/mandalay/transformer/t_form05_n_r_c_mdy': (context) =>
            TForm05NRCMdy(),
        '/mandalay/transformer/t_form06_household_mdy': (context) =>
            TForm06HouseholdMdy(),
        '/mandalay/transformer/t_form07_recommend_mdy': (context) =>
            TForm07RecommendMdy(),
        '/mandalay/transformer/t_form08_ownership_mdy': (context) =>
            TForm08OwnershipMdy(),
        '/mandalay/transformer/t_form09_allow_mdy': (context) =>
            TForm09LicenseMdy(),
        '/mandalay/transformer/t_form10_live_mdy': (context) => TForm10YCDCMdy()
      },
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Pyidaungsu'),
    );
  }
}
