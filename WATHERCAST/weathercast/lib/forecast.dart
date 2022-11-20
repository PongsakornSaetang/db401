/*
eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjEwMjY5Y2VkZjk0MjQ2MGQyNjFjMzhhNDI4YTY2MGRjMDRlMGM3MzA1ZTlkYmQ5MWFlYTBlZGJhZGE1ZTdmYmIxNzRiZTM5MGNmYjY2OTdkIn0.eyJhdWQiOiIyIiwianRpIjoiMTAyNjljZWRmOTQyNDYwZDI2MWMzOGE0MjhhNjYwZGMwNGUwYzczMDVlOWRiZDkxYWVhMGVkYmFkYTVlN2ZiYjE3NGJlMzkwY2ZiNjY5N2QiLCJpYXQiOjE2Njg5MzM1MTEsIm5iZiI6MTY2ODkzMzUxMSwiZXhwIjoxNzAwNDY5NTExLCJzdWIiOiIyMjg1Iiwic2NvcGVzIjpbXX0.G__kCpNPzFQPVPiKQf5uAbQUsl52Ch3U54uqdt-5vA53i2KqMUXZaMJzpgya1Z9G6F79hBva1a0kt2DTVZAut-PFHYcv7HojhhgiOiLLPpIEpiChnWPjDKep-zFghIFVHSzSDpkeuWn_mLZyJJnYdEs9wag_YsUhaU2XYsECs8E3EKw6_QjYuhbN0-ebGGn1hzI8o0SpPdR-kDemzane3rSbaWkQgtU6gnQFKQh49gM-gFeuGpezukv6-aBZanZDmiBCsqBNa8KL_Y8ABZ6jur_ccCJpg02LuQI_LqvYxrZdUxt-Upv_BsUu3Zhnlnf6xjyN1BULuBAAHOwKrn-BZenPbLMP2GmHRqyw0yJWlLj6BCzUFmf2wza1QvpQn5eyWPdx_cJYd96YN9Mju1uabcVSjXzPvTzUhd26boMDSAVPMlpZ_fDyRxv8Uc8lKzqmTXxROR-X98kuHVMHX3kxvk8X8DEnfzYc2Z_3mXURti9S3s8c5PWy6AEmwjE0FbAZWyT5up8SlQMR5zsU4FD3hHEfe7TUAzp3VnHhW36MpJu1QtuqnAjFdaaqf4N9rDR8jtWg9OdIPM9dN_u9mcelS91JBDgbUPx-sH9rme8UVs0x9MkuqdinQJIGTaRfToqfMFCilwesu8E_USXvicNoo66-evkKwiPdB2ksip12JGY
*/
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import 'location.dart';
import 'weather.dart';

Future<Weather> forecast() async {
  const url = 'https://data.tmd.go.th/nwpapi/v1/forecast/location/hourly/at';
  const token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjEwMjY5Y2VkZjk0MjQ2MGQyNjFjMzhhNDI4YTY2MGRjMDRlMGM3MzA1ZTlkYmQ5MWFlYTBlZGJhZGE1ZTdmYmIxNzRiZTM5MGNmYjY2OTdkIn0.eyJhdWQiOiIyIiwianRpIjoiMTAyNjljZWRmOTQyNDYwZDI2MWMzOGE0MjhhNjYwZGMwNGUwYzczMDVlOWRiZDkxYWVhMGVkYmFkYTVlN2ZiYjE3NGJlMzkwY2ZiNjY5N2QiLCJpYXQiOjE2Njg5MzM1MTEsIm5iZiI6MTY2ODkzMzUxMSwiZXhwIjoxNzAwNDY5NTExLCJzdWIiOiIyMjg1Iiwic2NvcGVzIjpbXX0.G__kCpNPzFQPVPiKQf5uAbQUsl52Ch3U54uqdt-5vA53i2KqMUXZaMJzpgya1Z9G6F79hBva1a0kt2DTVZAut-PFHYcv7HojhhgiOiLLPpIEpiChnWPjDKep-zFghIFVHSzSDpkeuWn_mLZyJJnYdEs9wag_YsUhaU2XYsECs8E3EKw6_QjYuhbN0-ebGGn1hzI8o0SpPdR-kDemzane3rSbaWkQgtU6gnQFKQh49gM-gFeuGpezukv6-aBZanZDmiBCsqBNa8KL_Y8ABZ6jur_ccCJpg02LuQI_LqvYxrZdUxt-Upv_BsUu3Zhnlnf6xjyN1BULuBAAHOwKrn-BZenPbLMP2GmHRqyw0yJWlLj6BCzUFmf2wza1QvpQn5eyWPdx_cJYd96YN9Mju1uabcVSjXzPvTzUhd26boMDSAVPMlpZ_fDyRxv8Uc8lKzqmTXxROR-X98kuHVMHX3kxvk8X8DEnfzYc2Z_3mXURti9S3s8c5PWy6AEmwjE0FbAZWyT5up8SlQMR5zsU4FD3hHEfe7TUAzp3VnHhW36MpJu1QtuqnAjFdaaqf4N9rDR8jtWg9OdIPM9dN_u9mcelS91JBDgbUPx-sH9rme8UVs0x9MkuqdinQJIGTaRfToqfMFCilwesu8E_USXvicNoo66-evkKwiPdB2ksip12JGY';
  try{
    Position location = await getCurrentLocation();
    http.Response response = await http.get(
    Uri.parse('$url?lat=${location.latitude}&lon=${location.longitude}&fields=tc,cond'), 
    headers: {
    'accept': 'application/json',
    'authorization': 'Bearer $token',
    }
    );
    if(response.statusCode == 200) {
      var result = jsonDecode(response.body)['WeatherForecasts'][0]['forecasts'][0]['data'];
      Placemark address = (await placemarkFromCoordinates(location.latitude, location.longitude)).first;
      return Weather(
      address: '${address.subLocality}\n${address.administrativeArea}',
      temperature: result['tc'],
      cond: result['cond'],
      );
    } 
    else {
      return Future.error(response.statusCode);
    }
  } 
  catch(e){
    return Future.error(e);
  }
}