#include <cstdio>
#include <cstdlib>

#include <iostream>
#include <stdexcept>
#include <string>

#include <xercesc/dom/DOM.hpp>
#include <xercesc/framework/LocalFileFormatTarget.hpp>
#include <xercesc/parsers/XercesDOMParser.hpp>
#include <xercesc/sax/ErrorHandler.hpp>
#include <xercesc/sax/SAXParseException.hpp>
#include <xercesc/util/PlatformUtils.hpp>

using namespace xercesc;

#include "strx.h"
#include "error_handler.h"

static void
serialise (DOMDocument const *doc, std::string const &output)
{
  XMLCh const LS[] = { chLatin_L, chLatin_S, chNull };

  DOMImplementationLS &impl = dynamic_cast<DOMImplementationLS &> (*DOMImplementationRegistry::getDOMImplementation (LS));
  DOMLSSerializer *writer = impl.createLSSerializer ();
  DOMLSOutput *desc = impl.createLSOutput ();

  LocalFileFormatTarget target (output.c_str ());
  desc->setByteStream (&target);

  writer->write (doc, desc);
}

static void
xsdproc (std::string const &schemadir, std::string const &input, std::string const &output)
{
  XercesDOMParser parser;
  parser.setExternalSchemaLocation ((
    "http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul " + schemadir + "/xul.xsd          "
    "http://www.w3.org/1999/xhtml                                  " + schemadir + "/xul-html.xsd     "
    "http://www.w3.org/2000/10/xlink-ns                            " + schemadir + "/xml/xlink.xsd    "
    //"http://www.w3.org/2001/SMIL20/                                " + schemadir + "/smil/smil20.xsd  "
    "http://www.w3.org/2001/XInclude                               " + schemadir + "/xml/xinclude.xsd "
    "http://www.w3.org/2002/07/owl#                                " + schemadir + "/owl/owl.xsd      "
    "http://www.w3.org/XML/1998/namespace                          " + schemadir + "/xml/xml.xsd      "
  ).c_str ());
  parser.setCreateEntityReferenceNodes (true);
  parser.setDoNamespaces (true);
  parser.setDoSchema (true);
  parser.setDoXInclude (true);
  parser.setHandleMultipleImports (true);
  parser.setValidationSchemaFullChecking (true);
  parser.setValidationScheme (XercesDOMParser::Val_Always);

  error_handler handler;
  parser.setErrorHandler (&handler);

  parser.parse (input.c_str ());

  if (handler.failed)
    throw std::runtime_error ("validation failed for " + input);

  serialise (parser.getDocument (), output);
}


int
main (int argc, char *argv[])
try
{
  if (argv[1])
    if (!strcmp (argv[1], "--help"))
      {
        puts ("usage: xsdproc <input.xul|xhtml>");
        return EXIT_SUCCESS;
      }
    else if (!strcmp (argv[1], "--version"))
      {
        puts (PACKAGE_NAME " v" PACKAGE_VERSION);
        return EXIT_SUCCESS;
      }

  if (argc < 4)
    return EXIT_FAILURE;

  std::string const schemadir = argv[1];
  std::string const input     = argv[2];
  std::string const output    = argv[3];

  XMLPlatformUtils::Initialize ();
  xsdproc (schemadir, input, output);
  XMLPlatformUtils::Terminate ();

  return EXIT_SUCCESS;
}
catch (SAXNotRecognizedException const &e)
{
  std::cerr << "Xerces-C exception caught:\n " << strx (e.getMessage ()) << "\n";
  return EXIT_FAILURE;
}
catch (XMLException const &e)
{
  std::cerr << "Xerces-C exception caught:\n " << strx (e.getMessage ()) << "\n";
  return EXIT_FAILURE;
}
catch (std::exception const &e)
{
  std::cerr << "Runtime exception caught:\n " << e.what () << "\n";
  return EXIT_FAILURE;
}
