%{
#include "parser.h"
#define YYLEX_PARAM self->lex.lex
%}

%union {
  struct node *node;
  std::string *string;
}

%define api.pure
%locations
%debug
%error-verbose
%token-table
%glr-parser

%parse-param { parser *self }
%lex-param { lexer *YYLEX_PARAM }

%token<string> TOK_IDENTIFIER	"identifier"
%token<string> TOK_STRING	"string literal"
%token<string> TOK_STRINGNODE	"text node"

%type<node> document
%type<node> node_list
%type<node> node
%type<node> element
%type<node> attribute
%type<node> text

%destructor { delete $$; } <string>

%%
document
	: element		{ $$ = self->document ($1);  }
	;

node_list
	: /* empty */		{ $$ = self->node_list (); }
	| node_list node	{ $$ = self->node_list ($1, $2); }
	;

node
	: element		{ $$ = self->element_node ($1); }
	| attribute		{ $$ = self->attribute_node ($1); }
	| text			{ $$ = self->text_node ($1); }
	;

element
	: TOK_IDENTIFIER '{' node_list '}'
				{ $$ = self->element (*$1, $3); }
	;

attribute
	: TOK_IDENTIFIER ':' TOK_STRING
				{ $$ = self->attribute (*$1, *$3); }
	;

text
	: TOK_STRING		{ $$ = self->text (*$1); }
	| TOK_STRINGNODE	{ $$ = self->text (*$1); }
	;

%%
