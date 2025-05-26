enum NoteTag {
  work('Work'),
  personal('Personal'),
  study('Study'),
  shopping('Shopping'),
  health('Health'),
  finance('Finance'),
  travel('Travel'),
  ideas('Ideas');

  final String displayName;
  const NoteTag(this.displayName);

  static NoteTag fromString(String tagString) {
    return NoteTag.values.firstWhere(
      (tag) => tag.name == tagString, // Menggunakan .name untuk membandingkan string enum
      orElse: () => NoteTag.personal, // Fallback jika string tidak cocok
    );
  }
}