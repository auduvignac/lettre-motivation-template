$pdf_mode = 1;
$interaction = 'nonstopmode';
$synctex = 1;

@default_files = ('template_lettre_motivation.tex');

$pdflatex = 'if [ %S = "descriptif.tex" ]; then xelatex -interaction=nonstopmode -halt-on-error -file-line-error -synctex=1 %O %S; else pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S; fi';

$clean_ext = 'aux fdb_latexmk fls log out synctex.gz xdv';
