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
    element (std::string const &identifier, node *node_list);
    ~element ();
    virtual void accept (visitor *v);

    std::string const identifier;
    node *node_list;
  };

  struct attribute
    : node
  {
    attribute (std::string const &identifier, std::string const &string);
    ~attribute ();
    virtual void accept (visitor *v);

    std::string const identifier;
    std::string const string;
  };

  struct text
    : node
  {
    text (std::string const &string);
    ~text ();
    virtual void accept (visitor *v);

    std::string const string;
  };
}
