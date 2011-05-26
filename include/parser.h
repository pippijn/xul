#pragma once

#include "lexer.h"
#include "node.h"

struct parser
{
  parser (lexer &lex);
  ~parser ();

  node *operator () ();

  node *document (node *element);
  node *node_list ();
  node *node_list (node *node_list, node *node);
  node *element_node (node *element);
  node *attribute_node (node *attribute);
  node *text_node (node *text);
  node *element (YYSTYPE::token identifier, node *node_list);
  node *attribute (YYSTYPE::token identifier, YYSTYPE::token string);
  node *text (YYSTYPE::token string);

  lexer &lex;
  node *doc;
};
