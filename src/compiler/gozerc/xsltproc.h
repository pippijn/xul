static xmlExternalEntityLoader defaultEntityLoader;
static xmlParserInputPtr
xsltprocExternalEntityLoader (char const *URL, char const *ID, xmlParserCtxtPtr ctxt)
{
  std::string url = URL;
  if (url.rfind (".dtd") == url.length () - 4)
    url = SRCDIR"/xsl" + url.substr (url.rfind ('/'));

  xmlParserInputPtr entity = defaultEntityLoader (url.c_str (), ID, ctxt);
  if (entity)
    return entity;
  die ("unable to load external entity: " + url);
}

static void
xsltproc (std::string const &input, std::string const &xslt, std::string const &output)
try
{
  timer const T (__func__);

  xsltStylesheetPtr const cur = xsltParseStylesheetFile (reinterpret_cast<xmlChar const *> (xslt.c_str ()));
  xmlDocPtr const doc = xmlParseFile (input.c_str ());
  xmlDocPtr const res = xsltApplyStylesheet (cur, doc, NULL);

  xsltSaveResultToFile (tempFILE (output.c_str ()), res, cur);

  xsltFreeStylesheet (cur);
  xmlFreeDoc (res);
  xmlFreeDoc (doc);
}
catch (std::exception const &e)
{
  die ("while processing " + input + " with " + xslt + ":\n   " + e.what ());
}
