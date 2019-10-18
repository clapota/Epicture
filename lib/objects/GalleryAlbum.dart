import 'ImgurTag.dart';

class GalleryAlbum {
	String id;
	String title;
	String description;
	int datetime;
	String cover;
	int coverWidth;
	int coverHeight;
	String accountUrl;
	int accountId;
	String privacy;
	String layout;
	int views;
	String link;
	int ups;
	int downs;
	int points;
	int score;
	bool isAlbum;
	String vote;
	bool favorite;
	bool nsfw;
	String section;
	int commentCount;
	int favoriteCount;
	String topic;
	int topicId;
	int imagesCount;
	bool inGallery;
	bool isAd;
	List<ImgurTag> tags;
	int adType;
	String adUrl;
	bool inMostViral;
	bool includeAlbumAds;
	List<GalleryImages> images;

	GalleryAlbum({this.id, this.title, this.description, this.datetime, this.cover, this.coverWidth, this.coverHeight, this.accountUrl, this.accountId, this.privacy, this.layout, this.views, this.link, this.ups, this.downs, this.points, this.score, this.isAlbum, this.vote, this.favorite, this.nsfw, this.section, this.commentCount, this.favoriteCount, this.topic, this.topicId, this.imagesCount, this.inGallery, this.isAd, this.tags, this.adType, this.adUrl, this.inMostViral, this.includeAlbumAds, this.images});

	GalleryAlbum.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		title = json['title'];
		description = json['description'];
		datetime = json['datetime'];
		cover = json['cover'];
		coverWidth = json['cover_width'];
		coverHeight = json['cover_height'];
		accountUrl = json['account_url'];
		accountId = json['account_id'];
		privacy = json['privacy'];
		layout = json['layout'];
		views = json['views'];
		link = json['link'];
		ups = json['ups'];
		downs = json['downs'];
		points = json['points'];
		score = json['score'];
		isAlbum = json['is_album'];
		vote = json['vote'];
		favorite = json['favorite'];
		nsfw = json['nsfw'];
		section = json['section'];
		commentCount = json['comment_count'];
		favoriteCount = json['favorite_count'];
		topic = json['topic'];
		topicId = json['topic_id'];
		imagesCount = json['images_count'];
		inGallery = json['in_gallery'];
		isAd = json['is_ad'];
		if (json['tags'] != null) {
			tags = new List<ImgurTag>();
			json['tags'].forEach((v) { tags.add(new ImgurTag.fromJson(v)); });
		}
		adType = json['ad_type'];
		adUrl = json['ad_url'];
		inMostViral = json['in_most_viral'];
		includeAlbumAds = json['include_album_ads'];
		if (json['images'] != null) {
			images = new List<GalleryImages>();
			json['images'].forEach((v) { images.add(new GalleryImages.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['title'] = this.title;
		data['description'] = this.description;
		data['datetime'] = this.datetime;
		data['cover'] = this.cover;
		data['cover_width'] = this.coverWidth;
		data['cover_height'] = this.coverHeight;
		data['account_url'] = this.accountUrl;
		data['account_id'] = this.accountId;
		data['privacy'] = this.privacy;
		data['layout'] = this.layout;
		data['views'] = this.views;
		data['link'] = this.link;
		data['ups'] = this.ups;
		data['downs'] = this.downs;
		data['points'] = this.points;
		data['score'] = this.score;
		data['is_album'] = this.isAlbum;
		data['vote'] = this.vote;
		data['favorite'] = this.favorite;
		data['nsfw'] = this.nsfw;
		data['section'] = this.section;
		data['comment_count'] = this.commentCount;
		data['favorite_count'] = this.favoriteCount;
		data['topic'] = this.topic;
		data['topic_id'] = this.topicId;
		data['images_count'] = this.imagesCount;
		data['in_gallery'] = this.inGallery;
		data['is_ad'] = this.isAd;
		if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
		data['ad_type'] = this.adType;
		data['ad_url'] = this.adUrl;
		data['in_most_viral'] = this.inMostViral;
		data['include_album_ads'] = this.includeAlbumAds;
		if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class GalleryImages {
	String id;
	String title;
	String description;
	int datetime;
	String type;
	bool animated;
	int width;
	int height;
	int size;
	int views;
	int bandwidth;
	String vote;
	bool favorite;
	bool nsfw;
	String section;
	String accountUrl;
	int accountId;
	bool isAd;
	bool inMostViral;
	bool hasSound;
	List<ImgurTag> tags;
	int adType;
	String adUrl;
	String edited;
	bool inGallery;
	String link;
	int commentCount;
	int favoriteCount;
	int ups;
	int downs;
	int points;
	int score;

	GalleryImages({this.id, this.title, this.description, this.datetime, this.type, this.animated, this.width, this.height, this.size, this.views, this.bandwidth, this.vote, this.favorite, this.nsfw, this.section, this.accountUrl, this.accountId, this.isAd, this.inMostViral, this.hasSound, this.tags, this.adType, this.adUrl, this.edited, this.inGallery, this.link, this.commentCount, this.favoriteCount, this.ups, this.downs, this.points, this.score});

	GalleryImages.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		title = json['title'];
		description = json['description'];
		datetime = json['datetime'];
		type = json['type'];
		animated = json['animated'];
		width = json['width'];
		height = json['height'];
		size = json['size'];
		views = json['views'];
		bandwidth = json['bandwidth'];
		vote = json['vote'];
		favorite = json['favorite'];
		nsfw = json['nsfw'];
		section = json['section'];
		accountUrl = json['account_url'];
		accountId = json['account_id'];
		isAd = json['is_ad'];
		inMostViral = json['in_most_viral'];
		hasSound = json['has_sound'];
		if (json['tags'] != null) {
			tags = new List<ImgurTag>();
			json['tags'].forEach((v) { tags.add(new ImgurTag.fromJson(v)); });
		}
		adType = json['ad_type'];
		adUrl = json['ad_url'];
		edited = json['edited'];
		inGallery = json['in_gallery'];
		link = json['link'];
		commentCount = json['comment_count'];
		favoriteCount = json['favorite_count'];
		ups = json['ups'];
		downs = json['downs'];
		points = json['points'];
		score = json['score'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['title'] = this.title;
		data['description'] = this.description;
		data['datetime'] = this.datetime;
		data['type'] = this.type;
		data['animated'] = this.animated;
		data['width'] = this.width;
		data['height'] = this.height;
		data['size'] = this.size;
		data['views'] = this.views;
		data['bandwidth'] = this.bandwidth;
		data['vote'] = this.vote;
		data['favorite'] = this.favorite;
		data['nsfw'] = this.nsfw;
		data['section'] = this.section;
		data['account_url'] = this.accountUrl;
		data['account_id'] = this.accountId;
		data['is_ad'] = this.isAd;
		data['in_most_viral'] = this.inMostViral;
		data['has_sound'] = this.hasSound;
		if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
		data['ad_type'] = this.adType;
		data['ad_url'] = this.adUrl;
		data['edited'] = this.edited;
		data['in_gallery'] = this.inGallery;
		data['link'] = this.link;
		data['comment_count'] = this.commentCount;
		data['favorite_count'] = this.favoriteCount;
		data['ups'] = this.ups;
		data['downs'] = this.downs;
		data['points'] = this.points;
		data['score'] = this.score;
		return data;
	}
}