class ReviewModel{
  final String scribeId;
  final String studentId;
  final String reviewText;
  final int rating;

  ReviewModel({
    required this.scribeId,
    required this.studentId,
    required this.reviewText,
    required this.rating
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json){
    return ReviewModel(
        scribeId: json['scribeId'],
        studentId: json['studentId'],
        reviewText: json['reviewText'],
        rating: json['rating']
    );
  }
}