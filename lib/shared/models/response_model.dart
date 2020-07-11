import 'dart:convert';

ResponseModel responseModelFromJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  bool sucess;
  dynamic data;
  List<dynamic> errors;

  ResponseModel({
    this.sucess,
    this.data,
    this.errors,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        sucess: json["sucess"],
        data: Data.fromJson(json["data"]),
        errors: List<dynamic>.from(json["Errors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sucess": sucess,
        "data": data.toJson(),
        "Errors": List<dynamic>.from(errors.map((x) => x)),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
