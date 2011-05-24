static void
serialise (DOMDocument const *doc, std::string const &output)
{
  timer const T (__func__);
  XMLCh const LS[] = { chLatin_L, chLatin_S, chNull };

  DOMImplementationLS &impl = dynamic_cast<DOMImplementationLS &> (*DOMImplementationRegistry::getDOMImplementation (LS));
  DOMLSSerializer *writer = impl.createLSSerializer ();
  DOMLSOutput *desc = impl.createLSOutput ();

  LocalFileFormatTarget target (output.c_str ());
  desc->setByteStream (&target);

  writer->write (doc, desc);

#if PROGRESS
  std::cout << '.' << std::flush;
#endif
}
