#include "lexer.h"

lexer::lexer (char const *file)
{
  yylex_init (&lex);
  yyset_extra (this, lex);

  FILE *fh = fopen (file, "r");
  if (!fh)
    throw;

  yyset_in (fh, lex);
}

lexer::~lexer ()
{
  fclose (yyget_in (lex));
  yylex_destroy (lex);
}
