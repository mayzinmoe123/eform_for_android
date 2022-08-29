import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

// Authentication
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/pages/auth/register.dart';

// division choice
import 'package:flutter_application_1/pages/division_choice.dart';

import 'yangon.dart';
import 'mandalay.dart';
import 'other.dart';

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

  Map<String, Widget Function(BuildContext)> getAllLinks(BuildContext context) {
    Map<String, Widget Function(BuildContext)> allLink = {};
    Map<String, Widget Function(BuildContext)> initialLink = {
      '/': (context) => Login(),
      '/register': (context) => Register(),
      '/division_choice': (context) => DivisionChoice(),
    };
    allLink.addAll(initialLink);

    Yangon yangon = Yangon();
    Map<String, Widget Function(BuildContext)> yangonLink =
        yangon.link(context);
    allLink.addAll(yangonLink);

    Mandalay mandalay = Mandalay();
    Map<String, Widget Function(BuildContext)> mandalayLink =
        mandalay.link(context);
    allLink.addAll(mandalayLink);

    Other other = Other();
    Map<String, Widget Function(BuildContext)> otherLink = other.link(context);
    allLink.addAll(otherLink);

    return allLink;
  }

  @override
  Widget build(BuildContext context) {
    var allLinks = getAllLinks(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      routes: {
        // '/': (context) => Login(),
        '/register': (context) => Register(),
        '/division_choice': (context) => DivisionChoice(),


        // Yangon
        '/yangon/meter': (context) => Yangon.MeterApplyChoice(),
        // Residential
        '/yangon/residential/r01_rules': (context) => Yangon.R01Rules(),
        '/yangon/residential/r02_promise': (context) => Yangon.R02Promise(),
        '/yangon/residential/r03_money': (context) => Yangon.R03Money(),
        '/yangon/residential/r04_info': (context) => Yangon.R04Info(),
        '/yangon/residential/r05_nrc': (context) => Yangon.R05Nrc(),
        '/yangon/residential/r06_household': (context) => Yangon.R06HouseHold(),
        '/yangon/residential/r07_recommend': (context) => Yangon.R07Recommend(),
        '/yangon/residential/r08_ownership': (context) => Yangon.R08Ownership(),
        '/yangon/residential/r09_farmland': (context) => Yangon.R09Farmland(),
        '/yangon/residential/r10_building': (context) => Yangon.R10Building(),
        '/yangon/residential/r11_power': (context) => Yangon.R11Power(),
        '/yangon/residential/overview': (context) => Yangon.ROverview(),
        

        // Residential Power
        '/yangon/residential_power/rp_form01_rules': (context) =>
            Yangon.RpForm01Rules(),
        '/yangon/residential_power/rp_form02_promise': (context) =>
            Yangon.RpForm02Promise(),
        '/yangon/residential_power/rp_form03_money': (context) =>
            Yangon.RpForm03Money(),
        '/yangon/residential_power/rp_form04_info': (context) =>
            Yangon.RpForm04Info(),
        '/yangon/residential_power/rp_form05_n_r_c': (context) =>
            Yangon.RpForm05NRC(),
        '/yangon/residential_power/rp_form06_household': (context) =>
            Yangon.RpForm06Household(),
        '/yangon/residential_power/rp_form07_recommend': (context) =>
            Yangon.RpForm07Recommend(),
        '/yangon/residential_power/rp_form08_ownership': (context) =>
            Yangon.RpForm08Ownership(),
        '/yangon/residential_power/rp_form09_power': (context) =>
            Yangon.RpForm09Power(),
        '/yangon/residential_power/rp_form10_meter': (context) =>
            Yangon.RpForm10CurrentMeter(),
        '/yangon/residential_power/rp_form11_farm_land': (context) =>
            Yangon.RpForm11FarmLand(),
        '/yangon/residential_power/rp_form12_building': (context) =>
            Yangon.RpForm12Building(),
        '/yangon/residential_power/overview': (context) => Yangon.RpOverview(),
       

        // Yangon Commerical Power
        '/yangon/commerical_power/cp_form01_rules': (context) =>
            Yangon.CpForm01Rules(),
        '/yangon/commerical_power/cp_form02_promise': (context) =>
            Yangon.CpForm02Promise(),
        '/yangon/commerical_power/cp_form03_money': (context) =>
            Yangon.CpForm03Money(),
        '/yangon/commerical_power/cp_form04_info': (context) =>
            Yangon.CpForm04Info(),
        '/yangon/commerical_power/cp_form05_n_r_c': (context) =>
            Yangon.CpForm05NRC(),
        '/yangon/commerical_power/cp_form06_household': (context) =>
            Yangon.CpForm06Household(),
        '/yangon/commerical_power/cp_form07_recommend': (context) =>
            Yangon.CpForm07Recommend(),
        '/yangon/commerical_power/cp_form08_ownership': (context) =>
            Yangon.CpForm08Ownership(),
        '/yangon/commerical_power/cp_form09_license': (context) =>
            Yangon.CpForm09License(),
        '/yangon/commerical_power/cp_form10_power': (context) =>
            Yangon.CpForm10Power(),
        '/yangon/commerical_power/cp_form11_meter': (context) =>
            Yangon.CpForm11CurrenMeter(),
        '/yangon/commerical_power/cp_form12_farm_land': (context) =>
            Yangon.CpForm12FarmLand(),
        '/yangon/commerical_power/cp_form13_building': (context) =>
            Yangon.CpForm13Building(),
        '/yangon/commerical_power/overview': (context) => Yangon.CpOverview(),
         

        // Yangon Contractor
        'ygn_c_form01_rules': (context) => Yangon.CForm01Rules(),
        'ygn_c_form02_promise': (context) => Yangon.CForm02Promise(),
        'ygn_c_form03_money_type': (context) => Yangon.CForm03MeterType(),
        'ygn_c_form04_info': (context) => Yangon.CForm04Info(),
        'ygn_c_form05_n_r_c': (context) => Yangon.CForm05NRC(),
        'ygn_c_form06_household': (context) => Yangon.CForm06Household(),
        'ygn_c_form07_recommend': (context) => Yangon.CForm07Recommend(),
        'ygn_c_form08_ownership': (context) => Yangon.CForm08Ownership(),
        'ygn_c_form09_allow': (context) => Yangon.CForm09Allow(),
        'ygn_c_form10_live': (context) => Yangon.CForm10Live(),
        'ygn_c_form11_y_c_d_c': (context) => Yangon.CForm11YCDC(),
        'yng_c_form12_meter_bill': (context) => Yangon.CForm12MeterBill(),
        'ygn_c_form13_farm_land': (context) => Yangon.CForm13FarmLand(),
        'ygn_c_form14_building_photo': (context) => Yangon.CForm14Building(),
        'ygn_c_form15_apartment_photo': (context) => Yangon.CForm15Apartment(),
        'ygn_c_form16_building_drawing': (context) =>
            Yangon.CForm16BuildingDrawing(),
        'ygn_c_form17_location': (context) => Yangon.CForm17Location(),
        'ygn_c_form18_sign': (context) => Yangon.CForm18Sign(),
        'ygn_c_overview': (context) => Yangon.COverview(),
        

        // Yangon Transformer (Residential)
        'ygn_t_form01_rules': (context) => Yangon.TForm01Rules(),
        'ygn_t_form02_promise': (context) => Yangon.TForm02Promise(),
        'ygn_t_form03_money_type': (context) => Yangon.TForm03Money(),
        //Yangon Transformer (Commerical)
        'ygn_ct_form01_rules': (context) => Yangon.CtForm01Rules(),
        'ygn_ct_form02_promise': (context) => Yangon.CtForm02Promise(),
        'ygn_ct_form03_money_type': (context) => Yangon.CtForm03Money(),
        // Yangon Transformer (Residential + Commercial)
        'ygn_t_form04_info': (context) => Yangon.TForm04Info(),
        'ygn_t_form05_n_r_c': (context) => Yangon.TForm05NRC(),
        'ygn_t_form06_household': (context) => Yangon.TForm06Household(),
        'ygn_t_form07_recommend': (context) => Yangon.TForm07Recommend(),
        'ygn_t_form08_ownership': (context) => Yangon.TForm08Ownership(),
        'ygn_t_form09_lincense': (context) => Yangon.TForm09License(),
        'ygn_t_form10_dc': (context) => Yangon.TForm10YCDC(),
        'ygn_t_form11_farmland': (context) => Yangon.TForm11FarmLand(),
        'ygn_t_form12_zone': (context) => Yangon.TForm12Zone(),
        'ygn_t_form13_power': (context) => Yangon.TForm13Power(),
        'ygn_c_overview': (context) => Yangon.TOverview(),
        '/': (context) => Yangon.TOverview(),

        //Mandalay
        //Residential
        '/mandalay/residential/r_form01_rules_mdy': (context) =>
            Mandalay.RForm01RulesMdy(),
        '/mandalay/residential/r_form02_promise_mdy': (context) =>
            Mandalay.RForm02PromiseMdy(),
        '/mandalay/residential/r_form03_money_mdy': (context) =>
            Mandalay.RForm03MoneyMdy(),
        '/mandalay/residential/r_form04_info_mdy': (context) =>
            Mandalay.RForm04InfoMdy(),
        '/mandalay/residential/r_form05_n_r_c_mdy': (context) =>
            Mandalay.RForm05NRCMdy(),
        '/mandalay/residential/r_form06_household_mdy': (context) =>
            Mandalay.RForm06HouseholdMdy(),
        '/mandalay/residential/r_form07_recommend_mdy': (context) =>
            Mandalay.RForm07RecommendMdy(),
        '/mandalay/residential/r_form08_ownership_mdy': (context) =>
            Mandalay.RForm08OwnershipMdy(),

        //Residential   Power
        '/mandalay/residential_power/rp_form01_rules_mdy': (context) =>
            Mandalay.RpForm01RulesMdy(),
        '/mandalay/residential_power/rp_form02_promise_mdy': (context) =>
            Mandalay.RpForm02PromiseMdy(),
        '/mandalay/residential_power/rp_form03_money_mdy': (context) =>
            Mandalay.RpForm03MoneyMdy(),
        '/mandalay/residential_power/rp_form04_info_mdy': (context) =>
            Mandalay.RpForm04InfoMdy(),
        '/mandalay/residential_power/rp_form05_n_r_c_mdy': (context) =>
            Mandalay.RpForm05NRCMdy(),
        '/mandalay/residential_power/rp_form06_household_mdy': (context) =>
            Mandalay.RpForm06HouseholdMdy(),
        '/mandalay/residential_power/rp_form07_recommend_mdy': (context) =>
            Mandalay.RpForm07RecommendMdy(),
        '/mandalay/residential_power/rp_form08_ownership_mdy': (context) =>
            Mandalay.RpForm08OwnershipMdy(),

        //Residential Commerical Transformer
        '/mandalay/commerical_power/cp_form01_rules_mdy': (context) =>
            Mandalay.CpForm01RulesMdy(),
        '/mandalay/commerical_power/cp_form02_promise_mdy': (context) =>
            Mandalay.CpForm02PromiseMdy(),
        '/mandalay/commerical_power/cp_form03_money_mdy': (context) =>
            Mandalay.CpForm03MoneyMdy(),
        '/mandalay/commerical_power/cp_form04_info_mdy': (context) =>
            Mandalay.CpForm04InfoMdy(),
        '/mandalay/commerical_power/cp_form05_n_r_c_mdy': (context) =>
            Mandalay.CpForm05NRCMdy(),
        '/mandalay/commerical_power/cp_form06_household_mdy': (context) =>
            Mandalay.CpForm06HouseholdMdy(),
        '/mandalay/commerical_power/cp_form07_recommend_mdy': (context) =>
            Mandalay.CpForm07RecommendMdy(),
        '/mandalay/commerical_power/cp_form08_ownership_mdy': (context) =>
            Mandalay.CpForm08OwnershipMdy(),
        '/mandalay/commerical_power/cp_form09_license_mdy': (context) =>
            Mandalay.CpForm09LicenseMdy(),
        '/mandalay/commerical_power/cp_form10_y_c_d_c_mdy': (context) =>
            Mandalay.CpForm10YCDCMdy(),
        '/mandalay/commerical_power/cp_form11_gov_allow_mdy': (context) =>
            Mandalay.CpForm11GovAllowMdy(),

        // Mandalay Contractor
        '/mandalay/contractor/c_form01_rules_mdy': (context) =>
            Mandalay.CForm01RulesMdy(),
        '/mandalay/contractor/c_form02_promise_mdy': (context) =>
            Mandalay.CForm02PromiseMdy(),
        '/mandalay/contractor/c_form03_money_type_mdy': (context) =>
            Mandalay.CForm03MeterTypeMdy(),
        '/mandalay/contractor/c_form04_info_mdy': (context) =>
            Mandalay.CForm04InfoMdy(),
        '/mandalay/contractor/c_form05_n_r_c_mdy': (context) =>
            Mandalay.CForm05NRCMdy(),
        '/mandalay/contractor/c_form06_household_mdy': (context) =>
            Mandalay.CForm06HouseholdMdy(),
        '/mandalay/contractor/c_form07_recommend_mdy': (context) =>
            Mandalay.CForm07RecommendMdy(),
        '/mandalay/contractor/c_form08_ownership_mdy': (context) =>
            Mandalay.CForm08Ownership(),
        '/mandalay/contractor/c_form09_allow_mdy': (context) =>
            Mandalay.CForm09AllowMdy(),
        '/mandalay/contractor/c_form10_live_mdy': (context) =>
            Mandalay.CForm10LiveMdy(),
        '/mandalay/contractor/c_form11_y_c_d_c_mdy': (context) =>
            Mandalay.CForm11YCDCMdy(),
        '/mandalay/contractor/c_form12_meter_bill_mdy': (context) =>
            Mandalay.CForm12MeterBillMdy(),

        //Mandalay transformer
        '/mandalay/transformer/t_form01_rules_mdy': (context) =>
            Mandalay.TForm01RulesMdy(),
        '/mandalay/transformer/t_form02_promise_mdy': (context) =>
            Mandalay.TForm02PromiseMdy(),
        '/mandalay/transformer/t_form03_money_type_mdy': (context) =>
            Mandalay.TForm03MoneyMdy(),
        '/mandalay/transformer/t_form04_info_mdy': (context) =>
            Mandalay.TForm04InfoMdy(),
        '/mandalay/transformer/t_form05_n_r_c_mdy': (context) =>
            Mandalay.TForm05NRCMdy(),
        '/mandalay/transformer/t_form06_household_mdy': (context) =>
            Mandalay.TForm06HouseholdMdy(),
        '/mandalay/transformer/t_form07_recommend_mdy': (context) =>
            Mandalay.TForm07RecommendMdy(),
        '/mandalay/transformer/t_form08_ownership_mdy': (context) =>
            Mandalay.TForm08OwnershipMdy(),
        '/mandalay/transformer/t_form09_allow_mdy': (context) =>
            Mandalay.TForm09LicenseMdy(),
        '/mandalay/transformer/t_form10_live_mdy': (context) =>
            Mandalay.TForm10YCDCMdy()
      },
=======
      routes: allLinks,
>>>>>>> 3b72083c0ab9ddfe32af3a1d3211cb46738910dc
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Pyidaungsu'),
    );
  }
}
