TITLE="Jelly Documentation"

default: doc

clean:
	rm -r html README.html

# This only works with the Ruby ronn at time of writing, which is really fine
# because the JS one is pretty bare-bones.
RONN=ronn --pipe

CODE=lib/backend.js lib/server.js lib/helpers.js lib/packageParser.js	\
     lib/sexpParser.js lib/sexp.js lib/util.js

html/code.html: ${CODE}
	mkdir -p html
	dox --title ${TITLE} $^ > $@

html/jelly.7.html: README.md
	mkdir -p html
	${RONN} -5 $^ > $@

html/jelly-api.7.html: doc/jelly-api.7.md
	mkdir -p html
	${RONN} -5 $^ > $@

README.html: html/jelly.7.html
	ln -sf $^ $@

html: README.html html/code.html html/jelly.7.html html/jelly-api.7.html


man/jelly.7.man: README.md
	mkdir -p man
	${RONN} -r $^ > $@

man/jelly-api.7.man: doc/jelly-api.7.md
	mkdir -p man
	${RONN} -r $^ > $@

man: man/jelly.7.man man/jelly-api.7.man


doc: html man
