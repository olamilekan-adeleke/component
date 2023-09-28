// ignore_for_file: unnecessary_this

extension StringExtension on String {
  String capitalizeFirstWords() {
    final List<String> words = this.split("");

    for (int i = 0; i < this.length - 1; i++) {
      if (i == 0 || this[i - 1] == " ") {
        words[i] = words[i].toUpperCase();
      }
    }

    return words.join("");
  }

  String capitalizeFirstWord() {
    final List<String> words = this.split("");
    words[0] = words[0].toUpperCase();

    return words.join("");
  }
}
