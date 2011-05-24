static std::string const &
validate (std::string const &input)
{
  timer const T (__func__);
  XercesDOMParser *parser = new XercesDOMParser;
  parser->setExternalSchemaLocation (
    "http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul      "SRCDIR"/xsd/xul.xsd            "
    "http://www.w3.org/1999/xhtml                                       "SRCDIR"/xsd/xul-html.xsd       "
    "http://www.w3.org/2000/10/xlink-ns                                 "SRCDIR"/xsd/xml/xlink.xsd      "
    "http://www.w3.org/2001/SMIL20/                                     "SRCDIR"/xsd/smil/smil20.xsd    "
    "http://www.w3.org/2001/XInclude                                    "SRCDIR"/xsd/xml/xinclude.xsd   "
    "http://www.w3.org/2002/07/owl#                                     "SRCDIR"/xsd/owl/owl.xsd        "
    "http://www.w3.org/XML/1998/namespace                               "SRCDIR"/xsd/xml/xml.xsd        "
  );
  parser->setCreateEntityReferenceNodes (true);
  parser->setDoNamespaces (true);
  parser->setDoSchema (true);
  parser->setDoXInclude (true);
  parser->setHandleMultipleImports (true);
  parser->setValidationSchemaFullChecking (true);
  parser->setValidationScheme (XercesDOMParser::Val_Always);

  DOMTreeErrorReporter handler;
  parser->setErrorHandler (&handler);

  parser->parse (input.c_str ());
#if PROGRESS
  std::cout << '.' << std::flush;
#endif

  if (handler.failed)
    throw std::runtime_error ("validation failed for " + input);

  std::string const &output = temporary (input, ".valid");
  serialise (parser->getDocument (), output);

  return output;
}
