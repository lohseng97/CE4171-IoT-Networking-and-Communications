class RemotePrediction {
  final String predictedClass;
  final String score;
  final String title;
  final String timeStamp;

  RemotePrediction(
      {this.title, this.predictedClass, this.score, this.timeStamp});

  factory RemotePrediction.fromJson(Map<String, dynamic> json) {
    return RemotePrediction(
      title: json['Title'],
      predictedClass: json['Prediction'],
      score: json['Confidence'],
      timeStamp: json['Upload_Time'],
    );
  }
}
