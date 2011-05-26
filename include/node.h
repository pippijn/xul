#pragma once

#include <string>
#include <vector>

#include "parser.h"

struct visitor;

struct node
{
  virtual ~node ();
  virtual void accept (visitor *v) = 0;
};

namespace nodes
{
  struct document
    : node
  {
    document (node *element);
    ~document ();
    virtual void accept (visitor *v);

    node *element;
  };

  struct node_list
    : node
  {
    node_list ();
    ~node_list ();
    virtual void accept (visitor *v);

    node_list *add (node *node);
    void reverse ();

    std::vector<node *> nodes;
  };

  struct element
    : node
  {
    element (YYSTYPE::token const &identifier, node *node_list);
    ~element ();
    virtual void accept (visitor *v);

    std::string const identifier;
    node *node_list;
  };

  struct attribute
    : node
  {
    attribute (YYSTYPE::token const &identifier, YYSTYPE::token const &string);
    ~attribute ();
    virtual void accept (visitor *v);

    std::string const identifier;
    std::string const string;
  };

  struct text
    : node
  {
    text (YYSTYPE::token const &string);
    ~text ();
    virtual void accept (visitor *v);

    std::string const string;
  };
}
