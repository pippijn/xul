static std::string const &
transform (std::string const &input, std::string const &mode, std::string const &output)
{
  timer const T (__func__);
  xsltproc (input, SRCDIR"/xsl/" + mode + ".xsl", output);
  tidy (output);

#if PROGRESS
  std::cout << '.' << std::flush;
#endif
  return output;
}
