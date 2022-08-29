//  Choose Meter Type
import 'package:flutter/material.dart';

import 'pages/mandalay/meter_apply_choice.dart';
// Residential Meter
import 'pages/mandalay/residential/r_form01_rules_mdy.dart';
import 'pages/mandalay/residential/r_form02_promise_mdy.dart';
import 'pages/mandalay/residential/r_form03_money_mdy.dart';
import 'pages/mandalay/residential/r_form04_info_mdy.dart';
import 'pages/mandalay/residential/r_form05_n_r_c_mdy.dart';
import 'pages/mandalay/residential/r_form06_household_mdy.dart';
import 'pages/mandalay/residential/r_form07_recommend_mdy.dart';
import 'pages/mandalay/residential/r_form08_ownership_mdy.dart';
import 'pages/mandalay/residential/r_overview.dart';
// Residential Power Meter
import 'pages/mandalay/residential_power/rp_form01_rules_mdy.dart';
import 'pages/mandalay/residential_power/rp_form02_promise_mdy.dart';
import 'pages/mandalay/residential_power/rp_form03_money_mdy.dart';
import 'pages/mandalay/residential_power/rp_form04_info_mdy.dart';
import 'pages/mandalay/residential_power/rp_form05_n_r_c_mdy.dart';
import 'pages/mandalay/residential_power/rp_form06_household_mdy.dart';
import 'pages/mandalay/residential_power/rp_form07_recommend_mdy.dart';
import 'pages/mandalay/residential_power/rp_form08_ownership_mdy.dart';
import 'pages/mandalay/residential_power/rp_overview.dart';
// Commercial Power Meter
import 'pages/mandalay/commerical_power/cp_form01_rules_mdy.dart';
import 'pages/mandalay/commerical_power/cp_form02_promise_mdy.dart';
import 'pages/mandalay/commerical_power/cp_form03_money_mdy.dart';
import 'pages/mandalay/commerical_power/cp_form04_info_mdy.dart';
import 'pages/mandalay/commerical_power/cp_form05_n_r_c_mdy.dart';
import 'pages/mandalay/commerical_power/cp_form06_household_mdy.dart';
import 'pages/mandalay/commerical_power/cp_form07_recommend_mdy.dart';
import 'pages/mandalay/commerical_power/cp_form08_ownership_mdy.dart';
import 'pages/mandalay/commerical_power/cp_form09_license_mdy.dart';
import 'pages/mandalay/commerical_power/cp_form10_y_c_d_c_mdy.dart';
import 'pages/mandalay/commerical_power/cp_form11_gov_allow_mdy.dart';
import 'pages/mandalay/commerical_power/cp_overview.dart';
// Contractor Meter
import 'pages/mandalay/contractor/c_form01_rules_mdy.dart';
import 'pages/mandalay/contractor/c_form02_promise_mdy.dart';
import 'pages/mandalay/contractor/c_form03_meter_type_mdy.dart';
import 'pages/mandalay/contractor/c_form04_info_mdy.dart';
import 'pages/mandalay/contractor/c_form05_n_r_c_mdy.dart';
import 'pages/mandalay/contractor/c_form06_household_mdy.dart';
import 'pages/mandalay/contractor/c_form07_recommend_mdy.dart';
import 'pages/mandalay/contractor/c_form08_ownership.dart';
import 'pages/mandalay/contractor/c_form09_allow_mdy.dart';
import 'pages/mandalay/contractor/c_form10_live_mdy.dart';
import 'pages/mandalay/contractor/c_form11_y_c_d_c_mdy.dart';
import 'pages/mandalay/contractor/c_form12_meter_bill_mdy.dart';
import 'pages/mandalay/contractor/c_overview.dart';
// Transformer Meter
import 'pages/mandalay/transformer/t_form01_rules_mdy.dart';
import 'pages/mandalay/transformer/t_form02_promise_mdy.dart';
import 'pages/mandalay/transformer/t_form03_money_mdy.dart';
import 'pages/mandalay/transformer/t_form04_info_mdy.dart';
import 'pages/mandalay/transformer/t_form05_n_r_c_mdy.dart';
import 'pages/mandalay/transformer/t_form06_household_mdy.dart';
import 'pages/mandalay/transformer/t_form07_recommend_mdy.dart';
import 'pages/mandalay/transformer/t_form08_ownership_mdy.dart';
import 'pages/mandalay/transformer/t_form09_license_mdy.dart';
import 'pages/mandalay/transformer/t_form10_y_c_d_c_mdy.dart';
import 'pages/mandalay/transformer/t_overview.dart';

class Mandalay {
  Map<String, Widget Function(BuildContext)> link(BuildContext context) {
    return {
      //Mandalay
      'mdy_meter': (context) => MeterApplyChoice(),
      //Residential
      'mdy_r_form01_rules': (context) => RForm01RulesMdy(),
      'mdy_r_form02_promise': (context) => RForm02PromiseMdy(),
      'mdy_r_form03_money': (context) => RForm03MoneyMdy(),
      'mdy_r_form04_info': (context) => RForm04InfoMdy(),
      'mdy_r_form05_n_r_c': (context) => RForm05NRCMdy(),
      'mdy_r_form06_household': (context) => RForm06HouseholdMdy(),
      'mdy_r_form07_recommend': (context) => RForm07RecommendMdy(),
      'mdy_r_form08_ownership': (context) => RForm08OwnershipMdy(),
      'mdy_r_overview': (context) => ROverview(),
      

      //Residential Power
      'mdy_rp_form01_rules': (context) => RpForm01RulesMdy(),
      'mdy_rp_form02_promise': (context) => RpForm02PromiseMdy(),
      'mdy_rp_form03_money': (context) => RpForm03MoneyMdy(),
      'mdy_rp_form04_info': (context) => RpForm04InfoMdy(),
      'mdy_rp_form05_n_r_c': (context) => RpForm05NRCMdy(),
      'mdy_rp_form06_household': (context) => RpForm06HouseholdMdy(),
      'mdy_rp_form07_recommend': (context) => RpForm07RecommendMdy(),
      'mdy_rp_form08_ownership': (context) => RpForm08OwnershipMdy(),
      'mdy_rp_overview': (context) => RpOverview(),

      // Commerical Transformer
      'mdy_cp_form01_rules': (context) => CpForm01RulesMdy(),
      'mdy_cp_form02_promise': (context) => CpForm02PromiseMdy(),
      'mdy_cp_form03_money': (context) => CpForm03MoneyMdy(),
      'mdy_cp_form04_info': (context) => CpForm04InfoMdy(),
      'mdy_cp_form05_n_r_c': (context) => CpForm05NRCMdy(),
      'mdy_cp_form06_household': (context) => CpForm06HouseholdMdy(),
      'mdy_cp_form07_recommend': (context) => CpForm07RecommendMdy(),
      'mdy_cp_form08_ownership': (context) => CpForm08OwnershipMdy(),
      'mdy_cp_form09_license': (context) => CpForm09LicenseMdy(),
      'mdy_cp_form10_y_c_d_c': (context) => CpForm10YCDCMdy(),
      'mdy_cp_form11_gov_allow': (context) => CpForm11GovAllowMdy(),
      'mdy_cp_overview': (context) => CpOverview(),

      // Contractor
      'mdy_c_form01_rules': (context) => CForm01RulesMdy(),
      'mdy_c_form02_promise': (context) => CForm02PromiseMdy(),
      'mdy_c_form03_money_type': (context) => CForm03MeterTypeMdy(),
      'mdy_c_form04_info': (context) => CForm04InfoMdy(),
      'mdy_c_form05_n_r_c': (context) => CForm05NRCMdy(),
      'mdy_c_form06_household': (context) => CForm06HouseholdMdy(),
      'mdy_c_form07_recommend': (context) => CForm07RecommendMdy(),
      'mdy_c_form08_ownership': (context) => CForm08Ownership(),
      'mdy_c_form09_allow': (context) => CForm09AllowMdy(),
      'mdy_c_form10_live': (context) => CForm10LiveMdy(),
      'mdy_c_form11_y_c_d_c': (context) => CForm11YCDCMdy(),
      'mdy_c_form12_meter_bill': (context) => CForm12MeterBillMdy(),
      'mdy_c_overview': (context) => COverview(),

      // transformer
      'mdy_t_form01_rules': (context) => TForm01RulesMdy(),
      'mdy_t_form02_promise': (context) => TForm02PromiseMdy(),
      'mdy_t_form03_money_type': (context) => TForm03MoneyMdy(),
      'mdy_t_form04_info': (context) => TForm04InfoMdy(),
      'mdy_t_form05_n_r_c': (context) => TForm05NRCMdy(),
      'mdy_t_form06_household': (context) => TForm06HouseholdMdy(),
      'mdy_t_form07_recommend': (context) => TForm07RecommendMdy(),
      'mdy_t_form08_ownership': (context) => TForm08OwnershipMdy(),
      'mdy_t_form09_allow': (context) => TForm09LicenseMdy(),
      'mdy_t_form10_live': (context) => TForm10YCDCMdy(),
      'mdy_t_overview': (context) => TOverview(),
      '/': (context) => TOverview(),
    };
  }
}
