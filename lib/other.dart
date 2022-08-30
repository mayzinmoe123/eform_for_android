//  Choose Meter Type
import 'package:flutter/material.dart';

import 'pages/other/meter_apply_choice.dart';
// Residential
import 'pages/other/residential/r01_rules.dart';
import 'pages/other/residential/r02_promise.dart';
import 'pages/other/residential/r03_money.dart';
import 'pages/other/residential/r04_info.dart';
import 'pages/other/residential/r05_nrc.dart';
import 'pages/other/residential/r06_household.dart';
import 'pages/other/residential/r07_recommend.dart';
import 'pages/other/residential/r08_ownership.dart';
import 'pages/other/residential/r_overview.dart';
// Residential Power Meter
import 'pages/other/residential_power/rp01_rules.dart';
import 'pages/other/residential_power/rp02_promise.dart';
import 'pages/other/residential_power/rp03_money.dart';
import 'pages/other/residential_power/rp04_info.dart';
import 'pages/other/residential_power/rp05_nrc.dart';
import 'pages/other/residential_power/rp06_household.dart';
import 'pages/other/residential_power/rp07_recommend.dart';
import 'pages/other/residential_power/rp08_ownership.dart';
import 'pages/other/residential_power/rp_overview.dart';
// Commercial Power Meter
import 'pages/other/commerical_power/cp01_rules.dart';
import 'pages/other/commerical_power/cp02_promise.dart';
import 'pages/other/commerical_power/cp03_money.dart';
import 'pages/other/commerical_power/cp04_info.dart';
import 'pages/other/commerical_power/cp05_nrc.dart';
import 'pages/other/commerical_power/cp06_household.dart';
import 'pages/other/commerical_power/cp07_recommend.dart';
import 'pages/other/commerical_power/cp08_ownership.dart';
import 'pages/other/commerical_power/cp09_license.dart';
import 'pages/other/commerical_power/cp10_dc.dart';
import 'pages/other/commerical_power/cp11_gov_allow.dart';
import 'pages/other/commerical_power/cp_overview.dart';
// Contractor Meter
import 'pages/other/contractor/c01_rules.dart';
import 'pages/other/contractor/c02_promise.dart';
import 'pages/other/contractor/c03_meter_type.dart';
import 'pages/other/contractor/c04_info.dart';
import 'pages/other/contractor/c05_nrc.dart';
import 'pages/other/contractor/c06_household.dart';
import 'pages/other/contractor/c07_recommend.dart';
import 'pages/other/contractor/c08_ownership.dart';
import 'pages/other/contractor/c09_allow.dart';
import 'pages/other/contractor/c10_live.dart';
import 'pages/other/contractor/c11_dc.dart';
import 'pages/other/contractor/c12_meter_bill.dart';
import 'pages/other/contractor/c_overview.dart';
// Transformer Meter
import 'pages/other/transformer/t01_rules.dart';
import 'pages/other/transformer/t02_promise.dart';
import 'pages/other/transformer/t03_money.dart';
import 'pages/other/transformer/t04_info.dart';
import 'pages/other/transformer/t05_nrc.dart';
import 'pages/other/transformer/t06_household.dart';
import 'pages/other/transformer/t07_recommend.dart';
import 'pages/other/transformer/t08_ownership.dart';
import 'pages/other/transformer/t09_license.dart';
import 'pages/other/transformer/t10_dc.dart';
import 'pages/other/transformer/t_overview.dart';

class Other {
  Map<String, Widget Function(BuildContext)> link(BuildContext context) {
    return {
      //Mandalay
      'other_meter': (context) => MeterApplyChoice(),
      //Residential
      'other_r01_rules': (context) => R01Rules(),
      'other_r02_promise': (context) => R02Promise(),
      'other_r03_money': (context) => R03Money(),
      'other_r04_info': (context) => R04Info(),
      'other_r05_nrc': (context) => R05Nrc(),
      'other_r06_household': (context) => R06Household(),
      'other_r07_recommend': (context) => R07Recommend(),
      'other_r08_ownership': (context) => R08Ownership(),
      'other_r_overview': (context) => ROverview(),
       

      //Residential Power
      'other_rp01_rules': (context) => Rp01Rules(),
      'other_rp02_promise': (context) => Rp02Promise(),
      'other_rp03_money': (context) => Rp03Money(),
      'other_rp04_info': (context) => Rp04Info(),
      'other_rp05_nrc': (context) => Rp05Nrc(),
      'other_rp06_household': (context) => Rp06Household(),
      'other_rp07_recommend': (context) => Rp07Recommend(),
      'other_rp08_ownership': (context) => Rp08Ownership(),
      'other_rp_overview': (context) => RpOverview(),

      // Commerical Transformer
      'other_cp01_rules': (context) => Cp01Rules(),
      'other_cp02_promise': (context) => Cp02Promise(),
      'other_cp03_money': (context) => Cp03Money(),
      'other_cp04_info': (context) => Cp04Info(),
      'other_cp05_nrc': (context) => Cp05Nrc(),
      'other_cp06_household': (context) => Cp06Household(),
      'other_cp07_recommend': (context) => Cp07Recommend(),
      'other_cp08_ownership': (context) => Cp08Ownership(),
      'other_cp09_license': (context) => Cp09License(),
      // 'other_cp10_dc': (context) => Cp10Dc(),
      // 'other_cp11_gov_allow': (context) => Cp11GovAllow(),
      'other_cp_overview': (context) => CpOverview(),

      // Contractor
      'other_c01_rules': (context) => C01Rules(),
      'other_c02_promise': (context) => C02Promise(),
      'other_c03_money_type': (context) => C03MeterType(),
      'other_c04_info': (context) => C04Info(),
      'other_c05_nrc': (context) => C05NRC(),
      'other_c06_household': (context) => C06Household(),
      'other_c07_recommend': (context) => C07Recommend(),
      'other_c08_ownership': (context) => C08Ownership(),
      'other_c09_allow': (context) => C09Allow(),
      'other_c10_live': (context) => C10Live(),
      'other_c11_dc': (context) => C11Dc(),
      'other_c12_meter_bill': (context) => C12MeterBill(),
      'other_c_overview': (context) => COverview(),
      '/': (context) => TOverview(),

      // transformer
      'other_t01_rules': (context) => TForm01Rules(),
      'other_t02_promise': (context) => TForm02Promise(),
      'other_t03_money_type': (context) => TForm03Money(),
      'other_t04_info': (context) => TForm04Info(),
      'other_t05_nrc': (context) => TForm05NRC(),
      'other_t06_household': (context) => TForm06Household(),
      'other_t07_recommend': (context) => TForm07Recommend(),
      'other_t08_ownership': (context) => TForm08Ownership(),
      'other_t09_license': (context) => TForm09License(),
      'other_t10_dc': (context) => TForm10Dc(),
      'other_t_overview': (context) => TOverview()
    };
  }
}
