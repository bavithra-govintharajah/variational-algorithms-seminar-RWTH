
This is the readme for the seminar writeup:

1) make sure that the "seminar_template.tex" compiles without problems. In
particular, you should have the files

   seminar_template.tex      (source file)
   seminarbib.bib            (bibliography)
   CB_fig1.pdf               (vector graphics)
   seminars.cls              (LaTeX style file)
   seminars.bst              (BibTeX style file)

initially. The last two files (seminars.cls, seminars.bst) must not be
edited. 

To compile, you should execute 
  pdflatex seminar_template.tex
  bibtex seminar_template.aux
  pdflatex seminar_template.tex
  pdflatex seminar_template.tex

then you can view seminar_template.pdf that is produced. Read the source
code seminar_template.tex after "EDIT FROM HERE ON" and the pdf-file carefully.

2) make a copy of seminar_template.tex and name it
"<your_initials>_seminar.tex". For Charlie Brown this would be
"CB_seminar.tex". You can write your text in "CB_seminar.tex".

3) Please respect the following guidelines:
   a) do not define own commands (via \newcommand or similar)
   b) only load packages if needed and make sure that are compatible with the
      the packages that are loaded by default
   c) add your initials to all the labels, filenames of the figures, ...
   d) make sure that the code compiles without errors and undefined
      references. Make sure to also investigate potential Warnings. You find
      all these in the log file (e.g., CB_seminar.log for Charlie Brown)
   e) use vectorgraphics (in the pdf-format) for figures whenever possible.
      You can easily identify vectorgraphics by zooming (you should not see
      pixelation). In particular, the text in all the figures has to be in
      vectorgraphics. Colormaps can be in png-format to save space (but the
      text on top of the colormap should be vectorgraphics).
      For pictures you can use jpg but that should be the exception rather
      than the rule.
   
4) For the bibliography, add your references to the file seminarbib.bib
   Read the example bibliography carefully and respect the following
   guidelines:
   a) only use the @article, @book, @misc BibTeX type. The label has to be in
   the form "firstauthor + year". Make sure that the first author is lowercase
   without any diacritics. The year is the full 4 digit year. For Schrödingers
   article about quantum mechanics, this would be "schrodinger1926"

   b) for each entry, add either the doi or the url field. If available you
   should use the doi field! (in particular, doi is provided for all articles)

   c) @article is for scientific publications. This should be the most used
   entry. You have to use the following fields: author, journal, volume,
   pages, year, title, doi

   additionally, you can use the field number (only if necessary to identify
   the paper correctly)

   d) @book is for references to books. You should add the fields: author,
   address, title, year, doi/url

   e) @misc is for everything else. Here the fields author, note, year, doi/url
   are required. This can be used for example for lecture notes, PhD theses,
   ...

   f) the author field has to be of the form 
            <Last name>, <First name1> <First name2> and  <Last name>, <First
            name1> <First name2> and ...
      the first names can be abbreviated.

   g) for the naming of the journals, please follow the ISO 4 rules. You can
   find them e.g. on wikipedia (see
   https://en.wikipedia.org/wiki/Annals_of_Physics in the box on the right).

If in doubts, ask your supervisor.

