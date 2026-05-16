$pdf_mode = 1;
$interaction = 'nonstopmode';
$synctex = 1;

@default_files = ('template_lettre_motivation.tex');

$pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';

$clean_ext = 'aux fdb_latexmk fls log out synctex.gz xdv';
