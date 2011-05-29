#include "parser.h"

#include <iostream>

parser::parser (lexer &lex)
  : lex (lex)
  , doc (0)
{
}

parser::~parser ()
{
}


node *
parser::operator () ()
{
  extern int yyparse (parser *parse);
  yyparse (this);
  return doc;
}


node *
parser::document (node *element)
{
  //std::cout << "document (" << element << ")\n";
  return doc = new nodes::document (element);
}

node *
parser::node_list ()
{
  //std::cout << "node_list ()\n";
  return new nodes::node_list ();
}

node *
parser::node_list (node *node_list, node *node)
{
  //std::cout << "node_list (" << node_list << ", " << node << ")\n";
  return dynamic_cast<nodes::node_list *> (node_list)->add (node);
}

node *
parser::element_node (node *element)
{
  //std::cout << "element_node (" << element << ")\n";
  return element;
}

node *
parser::attribute_node (node *attribute)
{
  //std::cout << "attribute_node (" << attribute << ")\n";
  return attribute;
}

node *
parser::text_node (node *text)
{
  //std::cout << "text_node (" << text << ")\n";
  return text;
}

node *
parser::element (std::string const &identifier, node *node_list)
{
  //std::cout << "element (" << identifier << ", " << node_list << ")\n";
  dynamic_cast<nodes::node_list *> (node_list)->reverse ();
  return new nodes::element (identifier, node_list);
}

node *
parser::attribute (std::string const &identifier, std::string const &string)
{
  //std::cout << "attribute (" << identifier << ", " << string << ")\n";
  return new nodes::attribute (identifier, string);
}

node *
parser::text (std::string const &string)
{
  //std::cout << "text (" << string << ")\n";
  return new nodes::text (string);
}


void
yyerror (YYLTYPE const *llocp, parser *parser, char const *msg)
{
  printf ("%d:%d: error: %s\n", llocp->first_line, llocp->first_column, msg);
}
