import 'package:json_annotation/json_annotation.dart';
part 'banner.g.dart';
@JsonSerializable()
class Banner{
  String desc;
  int id;
  String imagePath;
  String url;

  Banner(this.desc, this.id, this.imagePath, this.url);

  factory Banner.fromJson(Map<String,dynamic> json) =>_$BannerFromJson(json);
  Map<String,dynamic> toJson()=>_$BannerToJson(this);

}