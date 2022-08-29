import 'package:flutter/material.dart';

import 'pages/yangon/meter_apply_choice.dart';
// Residential
import 'pages/yangon/residential/r01_rules.dart';
import 'pages/yangon/residential/r02_promise.dart';
import 'pages/yangon/residential/r03_money.dart';
import 'pages/yangon/residential/r04_info.dart';
import 'pages/yangon/residential/r05_nrc.dart';
import 'pages/yangon/residential/r06_household.dart';
import 'pages/yangon/residential/r07_recommend.dart';
import 'pages/yangon/residential/r08_ownership.dart';
import 'pages/yangon/residential/r09_farmland.dart';
import 'pages/yangon/residential/r10_building.dart';
import 'pages/yangon/residential/r11_power.dart';
import 'pages/yangon/residential/r_overview.dart';
// Residential Power
import 'pages/yangon/residential_power/rp_form01_rules.dart';
import 'pages/yangon/residential_power/rp_form02_promise.dart';
import 'pages/yangon/residential_power/rp_form03_money.dart';
import 'pages/yangon/residential_power/rp_form04_info.dart';
import 'pages/yangon/residential_power/rp_form05_n_r_c.dart';
import 'pages/yangon/residential_power/rp_form06_household.dart';
import 'pages/yangon/residential_power/rp_form07_recommend.dart';
import 'pages/yangon/residential_power/rp_form08_ownership.dart';
import 'pages/yangon/residential_power/rp_form09_power.dart';
import 'pages/yangon/residential_power/rp_form10_current_meter.dart';
import 'pages/yangon/residential_power/rp_form11_farm_land.dart';
import 'pages/yangon/residential_power/rp_form12_building.dart';
import 'pages/yangon/residential_power/rp_overview.dart';
// Commercial Power
import 'pages/yangon/commerical_power/cp_form01_rules.dart';
import 'pages/yangon/commerical_power/cp_form02_promise.dart';
import 'pages/yangon/commerical_power/cp_form03_money.dart';
import 'pages/yangon/commerical_power/cp_form04_info.dart';
import 'pages/yangon/commerical_power/cp_form05_n_r_c.dart';
import 'pages/yangon/commerical_power/cp_form06_household.dart';
import 'pages/yangon/commerical_power/cp_form07_recommend.dart';
import 'pages/yangon/commerical_power/cp_form08_ownership.dart';
import 'pages/yangon/commerical_power/cp_form09_license.dart';
import 'pages/yangon/commerical_power/cp_form10_power.dart';
import 'pages/yangon/commerical_power/cp_form11_current_meter.dart';
import 'pages/yangon/commerical_power/cp_form12_farm_land.dart';
import 'pages/yangon/commerical_power/cp_form13_building.dart';
import 'pages/yangon/commerical_power/cp_overview.dart';
// Contractor
import 'pages/yangon/contractor/c_form01_rules.dart';
import 'pages/yangon/contractor/c_form02_promise.dart';
import 'pages/yangon/contractor/c_form03_meter_type.dart';
import 'pages/yangon/contractor/c_form04_info.dart';
import 'pages/yangon/contractor/c_form05_n_r_c.dart';
import 'pages/yangon/contractor/c_form06_household.dart';
import 'pages/yangon/contractor/c_form07_recommend.dart';
import 'pages/yangon/contractor/c_form08_ownership.dart';
import 'pages/yangon/contractor/c_form09_allow.dart';
import 'pages/yangon/contractor/c_form10_live.dart';
import 'pages/yangon/contractor/c_form11_y_c_d_c.dart';
import 'pages/yangon/contractor/c_form12_meter_bill.dart';
import 'pages/yangon/contractor/c_form13_farm_land.dart';
import 'pages/yangon/contractor/c_form14_building.dart';
import 'pages/yangon/contractor/c_form15_apartment.dart';
import 'pages/yangon/contractor/c_form16_building_drawing.dart';
import 'pages/yangon/contractor/c_form17_location.dart';
import 'pages/yangon/contractor/c_form18_sign.dart';
import 'pages/yangon/contractor/c_overview.dart';
// transformer
import 'pages/yangon/transformer/t_form01_rules.dart';
import 'pages/yangon/transformer/t_form02_promise.dart';
import 'pages/yangon/transformer/t_form03_money.dart';
import 'pages/yangon/transformer/t_form04_info.dart';
import 'pages/yangon/transformer/t_form05_n_r_c.dart';
import 'pages/yangon/transformer/t_form06_household.dart';
import 'pages/yangon/transformer/t_form07_recommend.dart';
import 'pages/yangon/transformer/t_form08_ownership.dart';
import 'pages/yangon/transformer/t_form09_license.dart';
import 'pages/yangon/transformer/t_form10_y_c_d_c.dart';
import 'pages/yangon/transformer/t_form11_farm_land.dart';
import 'pages/yangon/transformer/t_form12_zone.dart';
import 'pages/yangon/transformer/t_form13_power.dart';
import 'pages/yangon/transformer/t_overview.dart';
// commercial transformer
import 'pages/yangon/commerical_transformer/ct_form01_rules.dart';
import 'pages/yangon/commerical_transformer/ct_form02_promise.dart';
import 'pages/yangon/commerical_transformer/ct_form03_money.dart';

class Yangon {
  Map<String, Widget Function(BuildContext)> link(BuildContext context) {
    return {
      // Yangon
      '/yangon/meter': (context) => MeterApplyChoice(),
      // Residential
      '/yangon/residential/r01_rules': (context) => R01Rules(),
      '/yangon/residential/r02_promise': (context) => R02Promise(),
      '/yangon/residential/r03_money': (context) => R03Money(),
      '/yangon/residential/r04_info': (context) => R04Info(),
      '/yangon/residential/r05_nrc': (context) => R05Nrc(),
      '/yangon/residential/r06_household': (context) => R06HouseHold(),
      '/yangon/residential/r07_recommend': (context) => R07Recommend(),
      '/yangon/residential/r08_ownership': (context) => R08Ownership(),
      '/yangon/residential/r09_farmland': (context) => R09Farmland(),
      '/yangon/residential/r10_building': (context) => R10Building(),
      '/yangon/residential/r11_power': (context) => R11Power(),
      '/yangon/residential/overview': (context) => ROverview(),

      // Residential Power
      '/yangon/residential_power/rp_form01_rules': (context) => RpForm01Rules(),
      '/yangon/residential_power/rp_form02_promise': (context) =>
          RpForm02Promise(),
      '/yangon/residential_power/rp_form03_money': (context) => RpForm03Money(),
      '/yangon/residential_power/rp_form04_info': (context) => RpForm04Info(),
      '/yangon/residential_power/rp_form05_n_r_c': (context) => RpForm05NRC(),
      '/yangon/residential_power/rp_form06_household': (context) =>
          RpForm06Household(),
      '/yangon/residential_power/rp_form07_recommend': (context) =>
          RpForm07Recommend(),
      '/yangon/residential_power/rp_form08_ownership': (context) =>
          RpForm08Ownership(),
      '/yangon/residential_power/rp_form09_power': (context) => RpForm09Power(),
      '/yangon/residential_power/rp_form10_meter': (context) =>
          RpForm10CurrentMeter(),
      '/yangon/residential_power/rp_form11_farm_land': (context) =>
          RpForm11FarmLand(),
      '/yangon/residential_power/rp_form12_building': (context) =>
          RpForm12Building(),
      '/yangon/residential_power/overview': (context) => RpOverview(),

      // Yangon Commerical Power
      '/yangon/commerical_power/cp_form01_rules': (context) => CpForm01Rules(),
      '/yangon/commerical_power/cp_form02_promise': (context) =>
          CpForm02Promise(),
      '/yangon/commerical_power/cp_form03_money': (context) => CpForm03Money(),
      '/yangon/commerical_power/cp_form04_info': (context) => CpForm04Info(),
      '/yangon/commerical_power/cp_form05_n_r_c': (context) => CpForm05NRC(),
      '/yangon/commerical_power/cp_form06_household': (context) =>
          CpForm06Household(),
      '/yangon/commerical_power/cp_form07_recommend': (context) =>
          CpForm07Recommend(),
      '/yangon/commerical_power/cp_form08_ownership': (context) =>
          CpForm08Ownership(),
      '/yangon/commerical_power/cp_form09_license': (context) =>
          CpForm09License(),
      '/yangon/commerical_power/cp_form10_power': (context) => CpForm10Power(),
      '/yangon/commerical_power/cp_form11_meter': (context) =>
          CpForm11CurrenMeter(),
      '/yangon/commerical_power/cp_form12_farm_land': (context) =>
          CpForm12FarmLand(),
      '/yangon/commerical_power/cp_form13_building': (context) =>
          CpForm13Building(),
      '/yangon/commerical_power/overview': (context) => CpOverview(),

      // Yangon Contractor
      'ygn_c_form01_rules': (context) => CForm01Rules(),
      'ygn_c_form02_promise': (context) => CForm02Promise(),
      'ygn_c_form03_money_type': (context) => CForm03MeterType(),
      'ygn_c_form04_info': (context) => CForm04Info(),
      'ygn_c_form05_n_r_c': (context) => CForm05NRC(),
      'ygn_c_form06_household': (context) => CForm06Household(),
      'ygn_c_form07_recommend': (context) => CForm07Recommend(),
      'ygn_c_form08_ownership': (context) => CForm08Ownership(),
      'ygn_c_form09_allow': (context) => CForm09Allow(),
      'ygn_c_form10_live': (context) => CForm10Live(),
      'ygn_c_form11_y_c_d_c': (context) => CForm11YCDC(),
      'yng_c_form12_meter_bill': (context) => CForm12MeterBill(),
      'ygn_c_form13_farm_land': (context) => CForm13FarmLand(),
      'ygn_c_form14_building_photo': (context) => CForm14Building(),
      'ygn_c_form15_apartment_photo': (context) => CForm15Apartment(),
      'ygn_c_form16_building_drawing': (context) => CForm16BuildingDrawing(),
      'ygn_c_form17_location': (context) => CForm17Location(),
      'ygn_c_form18_sign': (context) => CForm18Sign(),
      'ygn_c_overview': (context) => COverview(),

      // Yangon Transformer (Residential)
      'ygn_t_form01_rules': (context) => TForm01Rules(),
      'ygn_t_form02_promise': (context) => TForm02Promise(),
      'ygn_t_form03_money_type': (context) => TForm03Money(),
      //Yangon Transformer (Commerical)
      'ygn_ct_form01_rules': (context) => CtForm01Rules(),
      'ygn_ct_form02_promise': (context) => CtForm02Promise(),
      'ygn_ct_form03_money_type': (context) => CtForm03Money(),
      // Yangon Transformer (Residential + Commercial)
      'ygn_t_form04_info': (context) => TForm04Info(),
      'ygn_t_form05_n_r_c': (context) => TForm05NRC(),
      'ygn_t_form06_household': (context) => TForm06Household(),
      'ygn_t_form07_recommend': (context) => TForm07Recommend(),
      'ygn_t_form08_ownership': (context) => TForm08Ownership(),
      'ygn_t_form09_lincense': (context) => TForm09License(),
      'ygn_t_form10_dc': (context) => TForm10YCDC(),
      'ygn_t_form11_farmland': (context) => TForm11FarmLand(),
      'ygn_t_form12_zone': (context) => TForm12Zone(),
      'ygn_t_form13_power': (context) => TForm13Power(),
      'ygn_t_overview': (context) => TOverview(),
    };
  }
}
