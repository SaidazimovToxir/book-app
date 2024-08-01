class FileModels {
  final String title;
  final String description;
  final String category;
  final String fileUrl;
  final String image;
  String savePath;
  double progres;
  bool isLoading;
  bool isLoaded;
  bool isDownloaded;

  FileModels({
    required this.title,
    required this.description,
    required this.category,
    required this.savePath,
    required this.progres,
    required this.image,
    required this.fileUrl,
    required this.isLoading,
    required this.isLoaded,
    required this.isDownloaded,
  });
}
