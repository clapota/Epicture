import 'data.dart';

class ImgurImage {

  final Data data;
  final bool success;
  final int status;

	ImgurImage.fromJsonMap(Map<String, dynamic> map): 
		data = Data.fromJsonMap(map["data"]),
		success = map["success"],
		status = map["status"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['data'] = this.data == null ? null : this.data.toJson();
		data['success'] = success;
		data['status'] = status;
		return data;
	}
}
