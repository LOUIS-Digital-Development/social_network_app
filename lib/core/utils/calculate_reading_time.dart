int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;

  // time = distance / speed
  final double readingTime = wordCount / 225;

  return readingTime.ceil();
}
