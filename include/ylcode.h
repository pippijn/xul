#pragma once

#include <cstddef>
#include "yyparse.h"
#include "yylex.h"

struct parser;

void yyerror (YYLTYPE const *llocp, parser *parse, char const *msg);
