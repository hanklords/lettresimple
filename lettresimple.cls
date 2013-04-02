% Copyright (c) 2013 Mael Clerambault <mael@clerambault.fr>
% 
% Permission to use, copy, modify, and distribute this software for any
% purpose with or without fee is hereby granted, provided that the above
% copyright notice and this permission notice appear in all copies.
% 
% THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
% WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
% MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
% ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
% WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
% ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
% OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lettresimple}

% a4paper
\setlength\paperheight{297mm}
\setlength\paperwidth{210mm}

% font size options
\newcommand\@ptsize{}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}

% font type options
\DeclareOption{sans}{\renewcommand{\familydefault}{\sfdefault}}
\DeclareOption{roman}{\renewcommand{\familydefault}{\rmdefault}}

% execute default options
\ExecuteOptions{10pt,sans}
\ProcessOptions\relax
\input{size1\@ptsize.clo}

\RequirePackage{etoolbox}
\RequirePackage{graphicx}
\RequirePackage{color}
\RequirePackage[T1]{fontenc}
\RequirePackage{ifthen}
\RequirePackage{marvosym}
\RequirePackage[unicode]{hyperref}
\AtEndPreamble{
  \pagenumbering{arabic}
  \hypersetup{
      pdfborder  = 0 0 0,
      pdfauthor  = \@name,
      pdftitle   = Lettre de \@name,
  }
}

\setlength\lineskip{1\p@}
\setlength{\parindent}{0\p@}
\setlength{\parskip}{6\p@}

\definecolor{addresscolor}{rgb}{0.45,0.45,0.45}% dark grey

\newcommand*{\name}[1]{\def\@name{#1}}
\newcommand*{\location}[1]{\def\@location{#1}}
\newcommand*{\signature}[1]{\def\@signature{#1}}
\newcommand*{\address}[1]{\def\@address{#1}}
\newcommand*{\mobile}[1]{\def\@mobile{#1}}
\newcommand*{\email}[1]{\def\@email{#1}}

\newcommand*{\emaillink}{%
    \href{mailto:\@name <\@email>}{{\@email}}
}

\newcommand*{\recipient}[2]{\def\@recipientname{#1}\def\@recipientaddress{#2}}
\newcommand*{\opening}[1]{\def\@opening{#1}}
\newcommand*{\closing}[1]{\def\@closing{#1}}

% internal maketitle command to issue a new line only when required
\newif\if@firstdetailselement\@firstdetailselementtrue
\newcommand*{\makenewline}{
  \if@firstdetailselement%
    \strut% to ensure baseline alignment, e.g. with when put in the margin vs sections that also contains a \strut
  \else%
    \\\fi%
  \@firstdetailselementfalse}

\newcommand*{\makelettertitle}{%
  \vspace*{-4\baselineskip}
  \hspace*{-2em}
  % address
  \begin{minipage}[t]{.5\textwidth}%
    \textcolor{addresscolor}{%
      \makenewline{\footnotesize\bfseries\upshape\@name}%
      \ifthenelse{\isundefined{\@address}}{}{\makenewline\footnotesize\@address}%
      \ifthenelse{\isundefined{\@mobile}}{}{\makenewline\footnotesize\Mobilefone~\@mobile}%
      \ifthenelse{\isundefined{\@email}}{}{\makenewline\footnotesize\textbf{@}~\emaillink}%
    }%
  \end{minipage}
  % date
  \hfill\hbox{\footnotesize\@location, le \today}\par
  % recipient
  \hfill\begin{minipage}{.5\textwidth}
    \raggedleft%
    {\footnotesize\bfseries\upshape\@recipientname}\\%
    \footnotesize\@recipientaddress%
  \end{minipage}\vspace{6\baselineskip}\par
  % opening
  \@opening\vspace{\baselineskip}\par
}

\newcommand*{\makeletterclosing}{
  %closing
  \@closing\vspace{2\baselineskip}\par
  %signature
  \hfill\@name\hspace{4em}\par
  \ifthenelse{\isundefined{\@signature}}{}{\raggedleft\includegraphics[width=5cm]{\@signature}}%
}
