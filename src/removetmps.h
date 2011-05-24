struct removetmps
{
  std::string const &operator () (std::string const &file, char const *mode)
  {
    std::string &temp = add (file);

    size_t point     = temp.rfind ('.');
    size_t tmp_point = temp.rfind ('.', point - 1);
    if (tmp_point == std::string::npos)
      temp.insert (point, mode);
    else
      temp.replace (temp.begin () + tmp_point, temp.begin () + point, mode);
    return temp;
  }

  void remove ()
  {
    std::for_each (files.begin (), files.end (), remove_one);
  }

  //~removetmps () { remove (); }

private:
  std::string &add (std::string const &file)
  {
    files.push_back (file);
    return files.back ();
  }

  static void remove_one (std::string const &file)
  {
    std::remove (file.c_str ());
  }

  std::vector<std::string> files;
} temporary;
