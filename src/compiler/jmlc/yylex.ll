%{
#include "lexer.h"

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
    parse_string (yylval->string, yytext, yyleng);	\
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
\"(\\.|[^\\"])*\"			{ Return (TOK_STRING); }
\'(\\.|[^\\'])*\'			{ Return (TOK_STRING); }
^"#".*					{ }
{WS}+					{ }
","					{ }
"("					{ return '{'; }
")"					{ return '}'; }
.					{ return yytext[0]; }
%%
