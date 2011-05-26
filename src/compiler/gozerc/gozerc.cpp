#include <cerrno>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include <algorithm>
#include <iomanip>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <string>
#include <vector>

#include <sys/time.h>

#include <boost/foreach.hpp>

#include <libxslt/transform.h>
#include <libxslt/xsltutils.h>

#include <tidy/buffio.h>
#include <tidy/tidy.h>

#include <xercesc/dom/DOM.hpp>
#include <xercesc/framework/LocalFileFormatTarget.hpp>
#include <xercesc/framework/StdOutFormatTarget.hpp>
#include <xercesc/parsers/XercesDOMParser.hpp>
#include <xercesc/sax2/SAX2XMLReader.hpp>
#include <xercesc/sax2/XMLReaderFactory.hpp>
#include <xercesc/sax/ErrorHandler.hpp>
#include <xercesc/sax/SAXParseException.hpp>
#include <xercesc/util/PlatformUtils.hpp>

using namespace xercesc;

#define die(args...) throw std::runtime_error (std::string (__func__) + ": " + args)

#include "tempFILE.h"
#include "strx.h"
#include "DOMTreeErrorReporter.h"
#include "removetmps.h"
#include "timer.h"
#include "launch.h"
#include "tidy.h"
#include "preprocess.h"
#include "serialise.h"
#include "validate.h"
#include "xsltproc.h"
#include "transform.h"
#include "verify.h"


static std::string
extension (std::string const &filename)
{
  size_t point = filename.rfind ('.');
  if (point == std::string::npos)
    die ("file `" + filename + "' has no extension");
  return filename.substr (point + 1);
}


int
main (int argc, char *argv[])
try
{
  if (argc < 3)
    return EXIT_FAILURE;

  std::string const input  = argv[1];
  std::string const output = argv[2];
  std::string const mode   = extension (output);

  std::cout << output << ": \n";

  xmlInitParser ();
  xsltInit ();

  defaultEntityLoader = xmlGetExternalEntityLoader ();
  xmlSetExternalEntityLoader (xsltprocExternalEntityLoader);

  XMLPlatformUtils::Initialize ();
  verify (transform (validate (preprocess (input)), mode, output));
  XMLPlatformUtils::Terminate ();

  xsltCleanupGlobals ();
  xmlCleanupParser ();

  // if everything went well, remove temporary files
  temporary.remove ();

  return EXIT_SUCCESS;
}
catch (SAXNotRecognizedException const &e)
{
  std::cerr << "Xerces-C exception caught:\n   " << strx (e.getMessage ()) << "\n";
  return EXIT_FAILURE;
}
catch (XMLException const &e)
{
  std::cerr << "Xerces-C exception caught:\n   " << strx (e.getMessage ()) << "\n";
  return EXIT_FAILURE;
}
catch (std::exception const &e)
{
  std::cerr << "Runtime exception caught:\n   " << e.what () << "\n";
  return EXIT_FAILURE;
}
