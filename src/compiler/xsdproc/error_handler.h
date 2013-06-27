struct error_handler
  : ErrorHandler
{
  error_handler ()
    : failed (false)
  {
  }

  static char const *notdir (strx const &name)
  {
    if (strncmp (name.local, SRCDIR, sizeof SRCDIR - 1) == 0)
      return name.local + sizeof SRCDIR;
    return name.local;
  }

  void fail (char const *how, SAXParseException const &e)
  {
    failed = true;
    std::cerr << notdir (strx (e.getSystemId ()))
              << ':' << e.getLineNumber ()
              << ':' << e.getColumnNumber ()
              << ": " << how
              << ": " << strx (e.getMessage ())
              << '\n';
  }

  void warning    (SAXParseException const &e) { fail ("warning", e); }
  void error      (SAXParseException const &e) { fail ("error"  , e); }
  void fatalError (SAXParseException const &e) { fail ("fatal"  , e); }
  void resetErrors () { failed = false; }

  bool failed;
};
