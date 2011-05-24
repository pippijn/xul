struct tempFILE
{
  tempFILE (std::string const &file)
    : fh (fopen (file.c_str (), "w"))
  {
    if (!fh)
      throw std::runtime_error ("could not open " + file + " for writing: " + strerror (errno));
  }

  ~tempFILE ()
  {
    if (fh)
      fclose (fh);
  }

  operator FILE * () { return fh; }

private:
  FILE *const fh;
};
