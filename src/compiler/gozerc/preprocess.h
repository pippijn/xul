static std::string const &
preprocess (std::string const &input)
{
  timer const T (__func__);

  std::string const &output = temporary (input, ".xinclude");

  process ("xmllint --path "SRCDIR"/xsd --dtdattr --dropdtd --xinclude --nofixup-base-uris --output " + output, input);
  tidy (output);

  return output;
}
