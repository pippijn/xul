#include <algorithm>
#include <iostream>
#include "node.h"
#include "xmlvisitor.h"

static bool
selfclosing (std::string const &tag)
{
  return tag == "img"
      || tag == "br"
      ;
}


struct predicate
{
  virtual bool exec (node *n) const = 0;
};

struct not_predicate
  : predicate
{
  not_predicate (std::tr1::shared_ptr<predicate> pred)
    : pred (pred)
  {
  }

  bool exec (node *n) const
  {
    return !pred->exec (n);
  }

  std::tr1::shared_ptr<predicate> pred;
};

std::tr1::shared_ptr<predicate>
NOT (std::tr1::shared_ptr<predicate> pred)
{
  return std::tr1::shared_ptr<predicate> (new not_predicate (pred));
}

template<typename T>
struct isa_predicate
  : predicate
{
  bool exec (node *n) const
  {
    return typeid (*n) == typeid (T);
  }
};

template<typename T>
std::tr1::shared_ptr<predicate>
ISA ()
{
  return std::tr1::shared_ptr<predicate> (new isa_predicate<T> ());
}

struct accept
{
  accept (visitor *v)
    : v (v)
  {
  }

  accept (visitor *v, std::tr1::shared_ptr<predicate> pred)
    : v (v)
    , pred (pred)
  {
  }

  void operator () (node *n)
  {
    if (!pred || pred->exec (n))
      n->accept (v);
  }

  visitor *v;
  std::tr1::shared_ptr<predicate> pred;
};


static std::ostream &os = std::cout;


xmlvisitor::xmlvisitor ()
{
}

xmlvisitor::~xmlvisitor ()
{
}


void
xmlvisitor::visit (nodes::document const *n)
{
  accept (this) (n->element);
  os << "\n";
}

void
xmlvisitor::visit (nodes::node_list const *n)
{
  std::for_each (n->nodes.begin (), n->nodes.end (), accept (this, pred));
}

void
xmlvisitor::visit (nodes::element const *n)
{
  os << "<"  << n->identifier;
  pred = ISA<nodes::attribute> ();
  accept (this) (n->node_list);
  if (selfclosing (n->identifier))
    {
      os << " />";
    }
  else
    {
      os << ">";
      pred = NOT (ISA<nodes::attribute> ());
      accept (this) (n->node_list);
      os << "</" << n->identifier << ">";
    }
  pred.reset ();
}

void
xmlvisitor::visit (nodes::attribute const *n)
{
  os << ' ' << n->identifier << "=\"" << n->string << '"';
}

void
xmlvisitor::visit (nodes::text const *n)
{
  os << n->string;
}
