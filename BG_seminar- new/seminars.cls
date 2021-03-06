\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{seminars} % seminar style (2020, Fabian Hassler)


\LoadClass[11pt,a4paper,twoside]{report}

% Layout
\RequirePackage[top=12mm,bottom=12mm,left=35mm,right=25mm,head=12mm,includeheadfoot]{geometry}


% Unicode characters
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

% Appendix after each chapter
\RequirePackage[title,titletoc,header]{appendix}
\let\appendix\subappendices
\renewcommand\appendixname{App.}
\renewcommand{\figurename}{Fig.}

% Math formulas and symbols
\RequirePackage{amsmath,amssymb}
\RequirePackage{bm}
\renewcommand\Re{\mathop{\rm Re}}
\renewcommand\Im{\mathop{\rm Im}}
\newcommand\Tr{\mathop{\rm Tr}}


% Hyperrefs
%\PassOptionsToPackage{backref}{hyperref}
\RequirePackage{hyperref}
\hypersetup{colorlinks=true,%
  allcolors=blue%
}

% BibTeX style
\bibliographystyle{seminars}

% header and footer
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{\theauthor}{}}
\fancyhf{}
\fancyhead[LE,RO]{\thepage}
\fancyhead[LO]{\rightmark}
\fancyhead[RE]{\leftmark}
\fancypagestyle{plain}{%
  \fancyhead{} % get rid of headers
  \renewcommand{\headrulewidth}{0pt} % and the line
}

% comments package
\RequirePackage{comment}


\RequirePackage{xcolor}

\RequirePackage{graphicx}

\RequirePackage{cite}

% new chapter command
\RequirePackage{titletoc}

\titlecontents{chapter}
              [1.3em] 
              {\addvspace{2ex}}
              {\bf\contentslabel{1em}} 
              {}
              {\hfill\contentspage\hspace*{-1em}\\*\hspace*{1em}\em%
              \theauthor\ (under the supervision %
              of \thesupervisor)\vspace{.5ex}}
              
              


% title commands
\renewcommand\author[1]{\def\theauthor{#1}}
\newcommand\supervisor[1]{\def\thesupervisor{#1}}
\newcommand\topic[1]{\def\thetopic{#1}%
  \addtocontents{toc}{\def\protect\theauthor{\theauthor}}%
  \addtocontents{toc}{\def\protect\thesupervisor{\thesupervisor}}%
  \chapter{\thetopic}%
  \addvspace{-2em}%
  \hspace*{2em}{\bf\Large\theauthor}\\[1ex]%
  \hspace*{2em}{\large Supervisor: \thesupervisor}}

% abstract
\renewenvironment{abstract}{\vspace{4ex}\begin{quote}\em}{\end{quote}\vspace{4ex}}

% table of contents
\let\oldtoc\tableofcontents
\def\tableofcontents{{\hypersetup{linkcolor=black}\oldtoc}}

%\ProcessOptions\relax

