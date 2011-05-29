#pragma once

#include <cstddef>
#include <string>
#include "yyparse.h"
#ifndef FLEX_SCANNER
#include "yylex.h"
#endif

struct parser;

void yyerror (YYLTYPE const *llocp, parser *parse, char const *msg);
