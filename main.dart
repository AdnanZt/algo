class Box {
  static int capacity = 10;

  Box({this.articles = const []});

  List<int> articles;

  void add(int article) {
    articles = [...articles, article];
  }

  @override
  String toString() => articles.join();

  int sum() => articles.fold(0, (prev, cur) => prev + cur);

  int get availableSpace => capacity - sum();

  bool get isFull => availableSpace == 0;
}

void main() {
  Box.capacity = 10;

  final List<int> articles = [1, 6, 3, 8, 4, 1, 6, 8, 9, 5, 2, 5, 7, 7, 3];

  final boxes = fillBoxes(articles);

  print(boxes.join('/'));
}

List<Box> fillBoxes(List<int> articles) {
  final List<Box> openBoxes = [Box()];
  final List<Box> fullBoxes = [];

  for (final article in articles) {
    if (openBoxes.isEmpty) {
      openBoxes.add(Box(articles: [article]));
      continue;
    }
    for (var i = 0; i < openBoxes.length; i++) {
      final box = openBoxes[i];

      if (box.availableSpace >= article) {
        box.add(article);

        if (box.isFull) {
          fullBoxes.add(box);
          openBoxes.removeAt(i);
        }
        break;
      }

      if (i == (openBoxes.length - 1)) {
        // Last box does not have available space
        // Meaning we have to open a new box for our article
        openBoxes.add(Box(articles: [article]));
        break;
      }
    }
  }

  return fullBoxes + openBoxes;
}
