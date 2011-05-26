build: $(shell ./retrieve)

URL = 'https://developer.mozilla.org/@api/deki/pages/$(shell ./retrieve $@)/contents?include=true&mode=raw&format=xhtml'

%.xml: #retrieve pageids.pm
	@echo "  GET   " $(URL)
	@#wget -O $@ -q $(URL)
	@curl -o $@ -s $(URL)
