.PHONY: clean
VERSION=1.2.0

docwrite-${VERSION}.zip: jquery.docwrite.js
	-mkdir docwrite
	cp -a $^ docwrite/jquery.docwrite.${VERSION}.js
	cp -a *.txt *.html nested_docwrite_test.js docwrite/
	java -jar ${CLOSURE_DIR}/compiler.jar --js $^ --js_output_file=docwrite/jquery.docwrite.${VERSION}.min.js
	zip -r $@ docwrite/

clean:
	rm -rf docwrite-${VERSION}.zip docwrite
