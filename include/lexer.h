#pragma once

#include "ylcode.h"

struct lexer
{
  lexer (char const *file);
  ~lexer ();

  void *lex;
};
