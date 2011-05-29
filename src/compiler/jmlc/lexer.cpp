#include "lexer.h"

#include <cassert>
#include <climits>
#include <cwchar>
#include <iomanip>
#include <sstream>
#include <vector>

lexer::lexer (char const *file)
{
  yylex_init (&lex);
  yyset_extra (this, lex);

  FILE *fh = fopen (file, "r");
  if (!fh)
    throw;

  yyset_in (fh, lex);
}

lexer::~lexer ()
{
  fclose (yyget_in (lex));
  yylex_destroy (lex);
}

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

struct out
{
  out (wchar_t c)
    : c (c)
  {
  }

  static bool printable (char c)
  {
    return isprint (c) || isspace (c);
  }

  friend std::ostream &operator << (std::ostream &os, out const &o)
  {
    if (o.c < CHAR_MAX && printable (o.c))
      os << char (o.c);
    else
      os << "&#x" << std::setfill ('0') << std::setw (4) << std::hex << int (o.c) << ';';
    return os;
  }

  wchar_t const c;
};


static bool
is_entity (std::vector<wchar_t>::const_iterator it, std::vector<wchar_t>::const_iterator et)
{
#define NEXT() do { if (++it == et) return false; } while (0)

  if (*it != '&')
    return false;

  NEXT ();

  // numeric entities
  if (*it == L'#')
    {
      NEXT (); // skip over '#'
      // hex entities
      if (*it == L'x')
        {
          do
            NEXT ();
          while (isxdigit (*it));
        }
      else
        {
          do
            NEXT ();
          while (isdigit (*it));
        }
      return *it == L';';
    }

  // named entities
  if (isalpha (*it))
    {
      do
        NEXT ();
      while (isalpha (*it));
      return *it == L';';
    }

#undef NEXT

  return false;
}

void
parse_string (std::string *&string, char const *text, int leng)
{
  std::ostringstream s;
  std::vector<wchar_t> wcs (leng);

  size_t wcsleng = mbstowcs (&wcs[0], *text == '"' ? text + 1 : text, leng);
  if (wcsleng == -1)
    {
      printf ("invalid multibyte sequence in: %s\n", text);
      abort ();
    }
  wcs.resize (wcsleng);

  if (*text == '"')
    wcs.pop_back ();

  std::vector<wchar_t>::const_iterator it = wcs.begin ();
  std::vector<wchar_t>::const_iterator et = wcs.end ();
  for (; it != et; ++it)
    switch (wchar_t c = *it)
      {
      case L'\\':
        s << out (*++it);
        break;
      case L'<':
        s << "&lt;";
        break;
      case L'>':
        s << "&gt;";
        break;
      case L'&':
        if (is_entity (it, et))
          s << '&';
        else
          s << "&amp;";
        break;
      case L'"':
        printf ("found unescaped double quote in string:\n%s\n%*c\n", text, it - wcs.begin () + 1, '^');
        abort ();
        break;
      default:
        s << out (c);
        break;
      }

  string = new std::string (s.str ());
}
