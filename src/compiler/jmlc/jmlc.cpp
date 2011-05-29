#include <clocale>
#include <cstdlib>

#include "lexer.h"
#include "parser.h"
#include "xmlvisitor.h"

int
main (int argc, char *argv[])
{
  if (argc < 2)
    return EXIT_FAILURE;

  setlocale (LC_ALL, "");

  lexer lex (argv[1]);
  parser parse (lex);

  if (node *doc = parse ())
    {
      xmlvisitor xml;
      doc->accept (&xml);
    }
  else
    {
      return EXIT_FAILURE;
    }

  return EXIT_SUCCESS;
}
