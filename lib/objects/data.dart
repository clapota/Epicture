
class Data {

  final String id;
  final Object title;
  final Object description;
  final int datetime;
  final String type;
  final bool animated;
  final int width;
  final int height;
  final int size;
  final int views;
  final int bandwidth;
  final Object vote;
  final bool favorite;
  final Object nsfw;
  final Object section;
  final Object account_url;
  final int account_id;
  final bool is_ad;
  final bool in_most_viral;
  final List<Object> tags;
  final int ad_type;
  final String ad_url;
  final bool in_gallery;
  final String deletehash;
  final String name;
  final String link;

	Data.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		title = map["title"],
		description = map["description"],
		datetime = map["datetime"],
		type = map["type"],
		animated = map["animated"],
		width = map["width"],
		height = map["height"],
		size = map["size"],
		views = map["views"],
		bandwidth = map["bandwidth"],
		vote = map["vote"],
		favorite = map["favorite"],
		nsfw = map["nsfw"],
		section = map["section"],
		account_url = map["account_url"],
		account_id = map["account_id"],
		is_ad = map["is_ad"],
		in_most_viral = map["in_most_viral"],
		tags = map["tags"],
		ad_type = map["ad_type"],
		ad_url = map["ad_url"],
		in_gallery = map["in_gallery"],
		deletehash = map["deletehash"],
		name = map["name"],
		link = map["link"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['title'] = title;
		data['description'] = description;
		data['datetime'] = datetime;
		data['type'] = type;
		data['animated'] = animated;
		data['width'] = width;
		data['height'] = height;
		data['size'] = size;
		data['views'] = views;
		data['bandwidth'] = bandwidth;
		data['vote'] = vote;
		data['favorite'] = favorite;
		data['nsfw'] = nsfw;
		data['section'] = section;
		data['account_url'] = account_url;
		data['account_id'] = account_id;
		data['is_ad'] = is_ad;
		data['in_most_viral'] = in_most_viral;
		data['tags'] = tags;
		data['ad_type'] = ad_type;
		data['ad_url'] = ad_url;
		data['in_gallery'] = in_gallery;
		data['deletehash'] = deletehash;
		data['name'] = name;
		data['link'] = link;
		return data;
	}
}
