#include <algorithm>
#include "node.h"
#include "visitor.h"

node::~node ()
{
}

static void
destroy (node *node)
{
  delete node;
}

namespace nodes
{
  document::document (node *element)
    : element (element)
  {
  }

  document::~document ()
  {
    destroy (element);
  }

  void
  document::accept (visitor *v)
  {
    v->visit (this);
  }


  node_list::node_list ()
  {
  }

  node_list::~node_list ()
  {
    std::for_each (nodes.begin (), nodes.end (), destroy);
  }

  void
  node_list::accept (visitor *v)
  {
    v->visit (this);
  }

  node_list *
  node_list::add (node *node)
  {
    nodes.push_back (node);
    return this;
  }

  void
  node_list::reverse ()
  {
    //std::reverse (nodes.begin (), nodes.end ());
  }


  element::element (std::string const &identifier, node *node_list)
    : identifier (identifier)
    , node_list (node_list)
  {
  }

  element::~element ()
  {
    destroy (node_list);
  }

  void
  element::accept (visitor *v)
  {
    v->visit (this);
  }


  attribute::attribute (std::string const &identifier, std::string const &string)
    : identifier (identifier)
    , string (string)
  {
  }

  attribute::~attribute ()
  {
  }

  void
  attribute::accept (visitor *v)
  {
    v->visit (this);
  }


  text::text (std::string const &string)
    : string (string)
  {
  }

  text::~text ()
  {
  }

  void
  text::accept (visitor *v)
  {
    v->visit (this);
  }
}
