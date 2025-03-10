class SliderImage {
  String? image;

  SliderImage({this.image});

  factory SliderImage.fromJson(Map<String, dynamic> json) => SliderImage(
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'image': image,
      };
}
