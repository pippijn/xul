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


int
main (int argc, char *argv[])
try
{
  if (argc < 4)
    return EXIT_FAILURE;

  std::string const mode   = argv[1] + 1;
  std::string const input  = argv[2];
  std::string const output = argv[3];

#if PROGRESS
  std::cout << output << ": " << std::flush;
#endif

  xmlInitParser ();
  xsltInit ();

  defaultEntityLoader = xmlGetExternalEntityLoader ();
  xmlSetExternalEntityLoader (xsltprocExternalEntityLoader);

  XMLPlatformUtils::Initialize ();
  verify (transform (validate (preprocess (input)), mode, output));
  XMLPlatformUtils::Terminate ();

  xsltCleanupGlobals ();
  xmlCleanupParser ();

#if PROGRESS
  std::cout << "done" << std::endl;
#endif

  // if everything went well, remove temporary files
  temporary.remove ();

  return EXIT_SUCCESS;
}
catch (SAXNotRecognizedException const &e)
{
  std::cerr << "Xerces-C exception caught: " << strx (e.getMessage ()) << "\n";
  return EXIT_FAILURE;
}
catch (XMLException const &e)
{
  std::cerr << "Xerces-C exception caught: " << strx (e.getMessage ()) << "\n";
  return EXIT_FAILURE;
}
catch (std::exception const &e)
{
  std::cerr << "Runtime exception caught: " << e.what () << "\n";
  return EXIT_FAILURE;
}
