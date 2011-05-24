static void
verify (std::string const &input)
{
  timer const T (__func__);
  validate (input);
  if (input.rfind (".xhtml") == input.length () - 6)
    xsltproc (input, SRCDIR"/tidy.xsl", input);

#if PROGRESS
  std::cout << '.' << std::flush;
#endif
}
