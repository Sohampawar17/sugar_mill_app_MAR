import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:sugar_mill_app/models/agri_cane_model.dart';
import '../constants.dart';
import '../models/agri.dart';
import '../models/agri_masters.dart';
import '../models/cane_farmer.dart';
import '../models/dose_type.dart';
import '../models/item.dart';
import '../models/tripsheet_water_supplier.dart';

class AddAgriServices {
  Future<List<Village>> fetchVillages() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/resource/Village?limit_page_length=999999&fields=["name","circle_office","taluka"]',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getToken()},
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<Village> dataList = List.from(jsonData['data'])
            .map<Village>((data) => Village.fromJson(data))
            .toList();

        return dataList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch Villages");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg:
            'Error: ${e.response?.data["exception"].toString().split(":").elementAt(1).trim()}',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),
      );
      Logger().e(e.response?.data.toString());
    }
    return [];
  }

  Future<List<caneFarmer>> fetchFarmerListWithFilter(String village) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/resource/Farmer List?fields=["supplier_name","existing_supplier_code","village","name"]&limit_page_length=999999&filters=[["village","like","$village%"],["workflow_state","=","approved"]]',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getToken()},
        ),
      );
      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap['data'];
        List<caneFarmer> farmerList = dataList
            .map<caneFarmer>((data) => caneFarmer.fromJson(data))
            .toList();
        Logger().i(farmerList);
        return farmerList;
      } else {
        Logger().e(response.statusCode);
        Logger().e(response.statusMessage);
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg:
            'Error: ${e.response?.data["exception"].toString().split(":").elementAt(1).trim()}',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),
      );
      Logger().e(e.response?.data.toString());
    }
    return [];
  }

  Future<bool> updateAgri(Agri agri) async {
    try {
      // var data = json.encode({farmer});
      Logger().i(agri.name.toString());
      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/resource/Agriculture Development/${agri.name}',
        options: Options(
          method: 'PUT',
          headers: {'Authorization': await getToken()},
        ),
        data: agri.toJson(),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Agriculture development Updated");
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "UNABLE TO UPDATE Agriculture development!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg:
            'Error: ${e.response?.data["exception"].toString().split(":").elementAt(1).trim()}',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),
      );
      Logger().e(e.response?.data.toString());
    }
    return false;
  }

  Future<Agri?> getAgri(String id) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/resource/Agriculture Development/$id',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getToken()},
        ),
      );

      if (response.statusCode == 200) {
        Logger().i(response.data["data"]);
        return Agri.fromJson(response.data["data"]);
      } else {
        // print(response.statusMessage);
        return null;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg:
            'Error: ${e.response?.data["exception"].toString().split(":").elementAt(1).trim()}',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),
      );
      Logger().e(e.response?.data.toString());
    }
    return null;
  }

  Future<bool> addAgri(Agri agri) async {
    var data = json.encode({
      "data": agri,
    });
    Logger().i(agri.toString());
    try {
      var dio = Dio();
      var response = await dio.request(
        apiListagri,
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getToken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Agriculture Development Registerted Successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO Agriculture Development!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg:
            'Error: ${e.response?.data["exception"].toString().split(":").elementAt(1).trim()}',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),
      );
      Logger().e(e.response?.data.toString());
    }
    return false;
  }

  Future<AgriMasters?> getMasters() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/method/sugar_mill.sugar_mill.doctype.agriculture_development.agriculture_development.agriMasters',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getToken()},
        ),
      );

      if (response.statusCode == 200) {
        Logger().i(response.data["message"]);
        return AgriMasters.fromJson(response.data["message"]);
      } else {
        // print(response.statusMessage);
        return null;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response?.data["message"].toString()} ',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),
      );
      Logger().e(e.response?.data.toString());
    }
    return null;
  }

  Future<List<String>> fetchSeason() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        apifetchSeason,
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getToken()},
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap["data"];
        Logger().i(dataList);
        List<String> namesList =
            dataList.map((item) => item["name"].toString()).toList();
        return namesList;
      }

      if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: "Unauthorized Access!");
        return ["401"];
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch Villages");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg:
            'Error: ${e.response?.data["exception"].toString().split(":").elementAt(1).trim()}',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),
      );
      Logger().e(e.response?.data.toString());
    }
    return [];
  }

  Future<List<DoseTypeModel>> fetchDoseType(
      String basel,
      String preEarth,
      String earth,
      String rainy,
      String ratoon1,
      String ratoon2,
      String cropType,
      String cropVariety,
      double developmentArea,
      double areaFixed,
      double areaGunta) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/method/sugar_mill.sugar_mill.doctype.agriculture_development.agriculture_development.calculation?self=AgricultureDevelopment(new-agriculture-development-1)&doctype=Agriculture Development&basel=$basel&preeathing=$preEarth&earth=$earth&rainy=$rainy&ratoon1=$ratoon1&ratoon2=$ratoon2&area=$developmentArea&croptype=$cropType&cropvariety=$cropVariety&areafixed=$areaFixed&areagunta=$areaGunta',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getToken()},
        ),
      );
      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap['message'];
        List<DoseTypeModel> doseList = dataList
            .map<DoseTypeModel>((data) => DoseTypeModel.fromJson(data))
            .toList();
        return doseList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch dose type");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response?.data["message"].toString()} ',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),
      );
    }
    return [];
  }

  Future<List<AgriCane>> fetchCaneListWithFilter(
      String season, String village, String farmerCode) async {
    try {

      var dio = Dio();
      String url =
          '$apiBaseUrl/api/resource/Cane Master?fields=["vendor_code","plot_no","route_km","grower_name","grower_code","area","crop_type","crop_variety","plantattion_ratooning_date","area_acrs","plant_name","name","soil_type","season"]&filters=[["season","like","$season%"],["village","like","$village%"],["grower_code","like","$farmerCode%"]]&limit_page_length=99999';
      Logger().i(url);
      var response = await dio.request(
        url,
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getToken()},
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap['data'];
        List<AgriCane> canelistwithfilter =
            dataList.map<AgriCane>((data) => AgriCane.fromJson(data)).toList();
        Logger().i(canelistwithfilter);
        return canelistwithfilter;
      } else {
        Logger().e(response.statusCode);
        Logger().e(response.statusMessage);
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg:
            'Error: ${e.response?.data["exception"].toString().split(":").elementAt(1).trim()}',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),
      );
      Logger().e(e.response?.data.toString());
    }
    return [];
  }

  Future<List<WaterSupplierList>> fetchSupplierList(String salestype) async {
    try {

      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/resource/Farmer List?fields=["name","supplier_name","existing_supplier_code"]&limit_page_length=99999&filters=[["workflow_state","=","approved"],["$salestype","=",1]]',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getToken()},
        ),
      );
      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap['data'];
        List<WaterSupplierList> farmerList = dataList
            .map<WaterSupplierList>((data) => WaterSupplierList.fromJson(data))
            .toList();
        farmerList.toSet();

        return farmerList;
      } else {
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg:
            'Error: ${e.response?.data["exception"].toString().split(":").elementAt(1).trim()}',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),
      );
      Logger().e(e.response?.data.toString());
    }
    return [];
  }

  Future<List<Item>> fetchItem() async {
    try {

      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/resource/Item?fields=["item_code","item_name","standard_rate"]&limit_page_length=999999',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getToken()},
        ),
      );
      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap['data'];
        List<Item> farmerList =
            dataList.map<Item>((data) => Item.fromJson(data)).toList();
        Logger().i(farmerList);
        return farmerList;
      } else {
        Logger().e(response.statusCode);
        Logger().e(response.statusMessage);
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg:
            'Error: ${e.response?.data["exception"].toString().split(":").elementAt(1).trim()}',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),
      );
      Logger().e(e.response?.data.toString());
    }
    return [];
  }

  Future<List<FertilizerItemList>> fetchItemwithfilter() async {
    try {

      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/method/sugar_mill.sugar_mill.doctype.agriculture_development.agriculture_development.get_fertilizeritem_list',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getToken()},
        ),
      );
      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap['message'];
        List<FertilizerItemList> farmerList = dataList
            .map<FertilizerItemList>(
                (data) => FertilizerItemList.fromJson(data))
            .toList();
        Logger().i(farmerList);
        return farmerList;
      } else {
        Logger().e(response.statusCode);
        Logger().e(response.statusMessage);
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg:
            'Error: ${e.response?.data["exception"].toString().split(":").elementAt(1).trim()}',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),
      );
      Logger().e(e.response?.data.toString());
    }
    return [];
  }

  Future<List<ItemList>> fetchItemlist() async {
    try {

      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/method/sugar_mill.sugar_mill.doctype.agriculture_development.agriculture_development.get_item_list',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getToken()},
        ),
      );
      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap['message'];
        List<ItemList> farmerList =
            dataList.map<ItemList>((data) => ItemList.fromJson(data)).toList();
        Logger().i(farmerList);
        return farmerList;
      } else {
        Logger().e(response.statusCode);
        Logger().e(response.statusMessage);
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response?.data["message"].toString()} ',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),
      );
      Logger().e(e.response?.data.toString());
    }
    return [];
  }
}
