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
  node *element (std::string const &identifier, node *node_list);
  node *attribute (std::string const &identifier, std::string const &string);
  node *text (std::string const &string);

  lexer &lex;
  node *doc;
};
