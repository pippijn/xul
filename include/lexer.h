#pragma once

#include "ylcode.h"

struct lexer
{
  lexer (char const *file);
  ~lexer ();

  void *lex;
};

void update_lloc (YYLTYPE *yylloc, int lineno, int column, int leng);
void parse_string (std::string *&string, char const *text, int leng);
