static void
process (std::string const &cmd, std::string const &input)
{
  std::string line = cmd + " " + input;
#if TRACE
  std::cout << "TRACE: " << line << "\n";
#endif
  int status = std::system (line.c_str ());
  if (status == -1 || WEXITSTATUS (status) != EXIT_SUCCESS)
    throw std::runtime_error (line);
}
