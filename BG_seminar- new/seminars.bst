% 
% seminars.bst
%

ENTRY
{   address
    author
    booktitle
    chapter
    doi
    edition
    editor
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    url
    volume
    year
  }
  {}
  { label }


% maximal number of authors
% (use et al. for longer author lists)
FUNCTION {maxauthor}
{ global.max$ }
%{ #4 }

% which command to use for
% crossreferences
FUNCTION {cite}
%{ "Ref.~\cite" }
{ "Ref.~\onlinecite" }


% print the title
% #0: no title
% #1: use titles
FUNCTION {printtitle}
{ #1 }

% #0: no backslash used after dots in author name
% #1: use backslash after dots in author name
FUNCTION {backslash}
{ #0 }

INTEGERS { output.state before.all mid.sentence after.sentence after.block 
           bracket no.comma }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
  #0 'bracket :=
  #0 'no.comma :=
}

STRINGS { s t }

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
  { bracket
    { " (" * write$ }
    { ", " * write$ }
    if$
  }
  { output.state after.block =
	{ bracket
    { write$
      newline$
	      " (" s * 's :=
    }
    { no.comma
      { "" }
      { "," }
      if$ 
      * write$
      newline$
      " " s * 's :=
      #0 'no.comma :=
    }
    if$
  }
	{ output.state before.all =
    'write$
    { add.period$ " " * write$ }
    if$
  }
  if$
  mid.sentence 'output.state :=
  }
  if$
  #0 'bracket :=
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.nocomma}
{ 
  output
  #1 'no.comma :=
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {field.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {bra}
{ #1 'bracket := }

FUNCTION {ket}
{ ")" * }

FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ %  after.sentence 'output.state :=
  skip$
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "\/}" * }
  if$
}

FUNCTION {embolden}
{ duplicate$ empty$
    { pop$ "" }
    { "{\bf " swap$ * "}" * }
  if$
}

FUNCTION {paren}
{ duplicate$ empty$
    { pop$ "" }
    { "(" swap$ * ")" * }
  if$
}

FUNCTION {link.open}
{
  doi empty$ 
  url empty$ and
  'skip$
  { doi empty$
    { "\href{"
      url *
      "}{%" 
    }
    { "\href{http://dx.doi.org/" 
      doi *
      "}{%" 
    }
    if$ 
    *
    output.nocomma
    new.block
  }
  if$
}

FUNCTION {link.shut}
{
  doi empty$ 
  url empty$ and
  { "" }
  { "}" }
  if$
  *
}


INTEGERS { nameptr namesleft numnames }

INTEGERS { etal }

FUNCTION {dot.replace}
{ backslash
  { field.or.null
    't :=
    ""
    { t empty$ not }
    { 
      t #1 #2 substring$ ". " = 
      { 
        ".\ " *
        t #3 global.max$ substring$ 't :=
      }
      { 
        t #1 #1 substring$ *
        t #2 global.max$ substring$ 't :=
      }
      if$
    }
    while$
  }
  'skip$
  if$
}


FUNCTION {wiggle.replace}
{ 't :=
  ""
  { t empty$ not }
  { 
    t #1 #2 substring$ ".~" = 
    { 
      backslash
      { "." }
      { ". " }
      if$  *
      t #3 global.max$ substring$ 't :=
    }
    {
      t #1 #1 substring$ *
      t #2 global.max$ substring$ 't :=
    }
    if$
  }
  while$
}

FUNCTION {space.connect}
{ swap$
  backslash
  {
    duplicate$ duplicate$ add.period$ text.length$ swap$ text.length$ =
    { "\ " }
    { " " }
    if$
  }
  { " " }
  if$
  * swap$ *
}


FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  %  s numnames "{ll}" format.name$ "others" = numnames maxauthor > or
  numnames maxauthor >
  'etal :=
  etal
  %   { #1 maxauthor + 'namesleft := }
  { #2 'namesleft := }
  { numnames 'namesleft := }
  if$
  { namesleft #0 > }
  { s nameptr 
    backslash
    { "{f.\ }{vv~}{ll}{, jj}" }
    { "{f. }{vv~}{ll}{, jj}" }
    if$  
    format.name$ wiggle.replace 't :=
    nameptr #1 >
    { namesleft #1 >
      { ", " * t * }
      { t "others" =
        etal or
        { " " * "et~al." emphasize * }
        { nameptr #2 >
          { "," * }
          'skip$
          if$
          " and " * t * 
        }
        if$
      }
      if$
    }
    't
    if$
    nameptr #1 + 'nameptr :=
    namesleft #1 - 'namesleft :=
  }
  while$
}

FUNCTION {format.authors}
{ author empty$
  { "" }
  { author format.names }
  if$
}

FUNCTION {format.editors}
{ editor empty$
  { "" }
  { editor format.names
    editor num.names$ #1 >
    { ", eds." * }
    { ", ed." * }
    if$
  }
  if$
}

FUNCTION {format.edited}
{ editor empty$
  { "" }
  { "edited by " editor format.names * }
  if$
}

FUNCTION {format.title}
{ title empty$
  { "" }
  { title "t" change.case$ }
  if$
}

FUNCTION {output.title}
{
  printtitle
  { format.title "title" output.check
    new.block
  }
  'skip$
  if$
}


FUNCTION {n.dashify}
{ 't :=
  ""
  { t empty$ not }
  { t #1 #1 substring$ "-" =
    { t #1 #2 substring$ "--" = not
      { "--" *
        t #2 global.max$ substring$ 't :=
      }
      {   { t #1 #1 substring$ "-" = }
        { "-" *
          t #2 global.max$ substring$ 't :=
        }
        while$
      }
      if$
    }
    { t #1 #1 substring$ *
      t #2 global.max$ substring$ 't :=
    }
    if$
  }
  while$
}

FUNCTION {first.page}
{ 't :=
  ""
  {  t empty$ not t #1 #1 substring$ "-" = not and }
  { t #1 #1 substring$ *
    t #2 global.max$ substring$ 't :=
  }
  while$
}

FUNCTION {format.date}
{ year empty$
  { "" }
  'year
  if$
}

FUNCTION {format.btitle}
{ 
  title emphasize
}


FUNCTION {tie.or.space.connect}
{ backslash
  {
    duplicate$ text.length$ #3 <
    { "~" swap$ * * }
    { swap$ space.connect }
    if$
  }
  { " " swap$ * * }
  if$
}

FUNCTION {either.or.check}
{ empty$
  'pop$
  { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
  { "" }
  { "vol." volume tie.or.space.connect
    series empty$
    'skip$
    { " of " * series dot.replace emphasize * }
    if$
    "volume and number" number either.or.check
  }
  if$
}


FUNCTION {format.number.series}
{ volume empty$
  { number empty$
    { series field.or.null dot.replace }
    { output.state mid.sentence =
      { "number" }
      { "Number" }
      if$
      number tie.or.space.connect
      series empty$
      { "there's a number but no series in " cite$ * warning$ }
      { " in " * series * }
      if$
    }
    if$
  }
  { "" }
  if$
}

FUNCTION {format.edition}
{ edition empty$
  { "" }
  { output.state mid.sentence =
    { edition "l" change.case$ "~edition" *}
    { edition "t" change.case$ "~edition" *}
    if$
  }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
  { multiresult not
    t empty$ not
    and
  }
  { t #1 #1 substring$
    duplicate$ "-" =
    swap$ duplicate$ "," =
    swap$ "+" =
    or or
    { #1 'multiresult := }
    { t #2 global.max$ substring$ 't := }
    if$
  }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
  { "" }
  { pages multi.page.check
    { "pp." pages n.dashify tie.or.space.connect }
    { "p." pages tie.or.space.connect }
    if$
  }
  if$
}

FUNCTION {format.pages.a}
{ pages empty$
  { "" }
  { "p." pages first.page tie.or.space.connect }
  if$
}

FUNCTION {format.vol.num.pages}
{ volume field.or.null embolden
  number empty$
  'skip$
  { " (" number * ")" * *
    volume empty$
    { "there's a number but no volume in " cite$ * warning$ }
    'skip$
    if$
  }
  if$
  pages empty$
  'skip$
  { duplicate$ empty$
    { pop$ format.pages }
    { ", " * pages first.page * }
    if$
  }
  if$
}


FUNCTION {format.chapter.pages}
{ chapter empty$
  'format.pages
  { type empty$
    { "chapter" }
    { type "l" change.case$ }
    if$
    chapter tie.or.space.connect
    pages empty$
    'skip$
    { ", " * format.pages * }
    if$
  }
  if$
}

FUNCTION {format.inproceeding}
{ number empty$ series empty$ not and pages empty$ not and
  { series dot.replace format.vol.num.pages space.connect }
  { format.bvolume
    format.number.series *
    format.pages * }
  if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
  { "" }
  { editor empty$
    { "in " booktitle emphasize * }
    { "in " booktitle emphasize * ", " * format.edited * }
    if$
  }
  if$
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
  { "all relevant fields are empty in " cite$ * warning$ }
  'skip$
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
  'skip$
  { pop$
    type "t" change.case$
  }
  if$
}

FUNCTION {format.tr.number}
{ type empty$
  { "Technical Report" }
  'type
  if$
  number empty$
  { "t" change.case$ }
  { number tie.or.space.connect }
  if$
}

FUNCTION {format.article.crossref}
{ key empty$
  { journal empty$
    { "need key or journal for " cite$ * " to crossref " * crossref *
      warning$
      ""
    }
    { "in " journal dot.replace * }
    if$
  }
  { "in " key * }
  if$
  space.connect cite * "{" * crossref * "}" *
}

FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
  editor num.names$ duplicate$
  #2 >
  { pop$ " et~al." emphasize * }
  { #2 <
    'skip$
    { editor #2 "{ff }{vv~}{ll}{ jj}" format.name$ "others" =
      { " et~al." emphasize * }
      { " and " * editor #2 "{vv~}{ll}" format.name$ * }
      if$
    }
    if$
  }
  if$
}

FUNCTION {format.book.crossref}
{ volume empty$
  { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
    "in "
  }
  { "vol." volume tie.or.space.connect
    " of " *
  }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
  { key empty$
    { series empty$
      { "need editor, key, or series for " cite$ * " to crossref " *
        crossref * warning$
        "" *
      }
      { series emphasize }
      if$
    }
    { key * }
    if$
  }
  { format.crossref.editor * }
  if$
  " " * cite * "{" * crossref * "}" *
}

FUNCTION {format.incoll.inproc.crossref}
{ editor empty$
  editor field.or.null author field.or.null =
  or
  { key empty$
    { booktitle empty$
      { "need editor, key, or booktitle for " cite$ * " to crossref " *
        crossref * warning$
        ""
      }
      { "in " booktitle emphasize * }
      if$
    }
    { "in " key * }
    if$
  }
  { "in " }
  if$
  cite * "{" * crossref * "}" *
}

FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  new.block
  output.title
  crossref missing$
  { link.open
    journal field.or.null dot.replace 
    format.vol.num.pages 
    format.date empty$
    'skip$
    { duplicate$ empty$
      { pop$ format.date paren }
      { " " * format.date paren * }
      if$
    }
    if$
    space.connect
    link.shut  
    output
  }
  { format.article.crossref output.nonnull
    format.pages output
  }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  author empty$
  { format.editors "author and editor" output.check }
  { format.authors output.nonnull
    crossref missing$
    { "author and editor" editor either.or.check }
    'skip$
    if$
  }
  if$
  new.block
  link.open format.btitle link.shut "title" output.check
  crossref missing$
  { format.bvolume output
    new.block
    format.number.series output
    format.edition output
    bra
    publisher dot.replace "publisher" output.check
    address output
    format.date  "year" output.check
    ket
  }
  { new.block
    format.book.crossref output.nonnull
    format.edition output
    format.date "year" output.check
  }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors output
  title howpublished new.block.checkb
  format.title output
  howpublished new.block.checka
  howpublished output
  new.block
  link.open
  note
  link.shut
  format.date paren space.connect output
  fin.entry
  empty.misc.check
}

MACRO {jan} {"Jan."}

MACRO {feb} {"Feb."}

MACRO {mar} {"Mar."}

MACRO {apr} {"Apr."}

MACRO {may} {"May"}

MACRO {jun} {"June"}

MACRO {jul} {"July"}

MACRO {aug} {"Aug."}

MACRO {sep} {"Sept."}

MACRO {oct} {"Oct."}

MACRO {nov} {"Nov."}

MACRO {dec} {"Dec."}

READ

STRINGS { longest.label }

INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
  { label 'longest.label :=
    label width$ 'longest.label.width :=
  }
  'skip$
  if$
}


EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
  'skip$
  { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
  "\makeatletter" write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
