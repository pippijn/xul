static void
verify (std::string const &input)
{
  timer const T (__func__);

  validate (input);
  if (input.rfind (".xhtml") == input.length () - (sizeof ".xhtml" - 1))
    xsltproc (input, SRCDIR"/tidy.xsl", input);
}
