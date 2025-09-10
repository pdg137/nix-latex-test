all: output/hello.pdf output/mla_example.pdf

clean:
	rm output -r

output/%.pdf: %.tex
	mkdir -p output
	pdflatex -output-directory=output $<

shell: default.nix
	nix-build -o shell
