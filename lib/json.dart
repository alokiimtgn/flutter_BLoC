//Step 3
class Post {
  final int id;
  final String url;
  final String thumbnailUrl;
  final String title;

  Post({ this.id, this.url, this.thumbnailUrl, this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(

        id: json['id'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl'],
        title:  json['title']
    );
  }
  @override
  String toString() {
    return 'Post{ id: $id, url: $url, thumbnailUrl: $thumbnailUrl, title: $title}';
  }
}
