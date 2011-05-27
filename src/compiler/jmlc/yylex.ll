%{
#include <cassert>
#include <climits>
#include "yyparse.h"

void
update_lloc (YYLTYPE *yylloc, int lineno, int column, int leng)
{
  assert (yylloc != NULL);
  assert (lineno >= 1);
  assert (column >= 0);
  assert (leng >= 1);
  assert (UINT_MAX - column - leng > INT_MAX);

  yylloc->first_line = lineno;
  yylloc->first_column = column;
  yylloc->last_column = column + leng;
  yylloc->last_line = lineno;
}

#define YY_USER_ACTION					\
  {							\
    update_lloc (yylloc, yylineno, yycolumn, yyleng);	\
    if (*yytext == '\n')				\
      yycolumn = 1;					\
    else						\
      yycolumn += yyleng;				\
  }

#define Return(TOK)					\
  do {							\
    yylval->string.text = yytext;			\
    yylval->string.leng = yyleng;			\
    return TOK;						\
  } while (0)						\

%}

%option prefix="yy"
%option header-file="yylex.h"
%option bison-locations
%option reentrant
%option yylineno
%option noyywrap nounput noinput nounistd
%option never-interactive

ID	[a-zA-Z_-][a-zA-Z0-9_-]*
WS	[ \t\v\n\r]

%%
{ID}(":"{ID})*				{ Return (TOK_IDENTIFIER); }
\"[^"]*\"				{ Return (TOK_STRING); }
\'[^']*\'				{ Return (TOK_STRING); }
^"#".*					{ }
{WS}+					{ }
","					{ }
"("					{ return '{'; }
")"					{ return '}'; }
.					{ return yytext[0]; }
%%
