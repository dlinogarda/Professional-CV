%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Twenty Seconds Curriculum Vitae in LaTex
% ****************************************
% 
% License: MIT
%
% For further information please visit:
% https://github.com/spagnuolocarmine/TwentySecondsCurriculumVitae-LaTex
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%
% CLASS %
%%%%%%%%%
\ProvidesClass{mycvtemplate}[2015/02/28 CV class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

%%%%%%%%%%%%
% PACKAGES %
%%%%%%%%%%%%
\RequirePackage[sfdefault]{ClearSans}
\RequirePackage[T1]{fontenc}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{ragged2e}
\RequirePackage{etoolbox}
\RequirePackage{ifmtarg}
\RequirePackage{ifthen}
\RequirePackage{pgffor}
\RequirePackage{marvosym}
\RequirePackage{parskip}
\usepackage{mdframed}
\usepackage{lipsum}

%%%%%%%%%%%
% OPTIONS %
%%%%%%%%%%%
% icons
\newbool{icon}
\DeclareOption{icon}{%
  \booltrue{icon}
}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\ifbool{icon}{\RequirePackage{fontawesome5}}{}

\usetikzlibrary{calc}

%%%%%%%%%%
% colors %
%%%%%%%%%%
\definecolor{white}{RGB}{255,255,255} 
\definecolor{darkgray}{HTML}{333333} 
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{sidecolor}{HTML}{E7E7E7}
\definecolor{lightgray}{HTML}{999999}
\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB0B00}
\definecolor{blue}{HTML}{6CE0F1}
\definecolor{mainblue}{HTML}{0E5484}
\definecolor{cerulean}{HTML}{007BA7}
\definecolor{maingray}{HTML}{B9B9B9}
\definecolor{maindarkgray}{HTML}{B3B3B3}

\ifdefined\@cv@print
  \colorlet{green}{gray}
  \colorlet{orange}{gray}
  \colorlet{purple}{gray}
  \colorlet{red}{gray}
  \colorlet{blue}{gray}
  \colorlet{fillheader}{white}
  \colorlet{asidecolor}{sidecolor}
  \colorlet{header}{gray}
\else
  \colorlet{fillheader}{gray}
  \colorlet{header}{white}
  \colorlet{asidecolor}{sidecolor}
\fi

\colorlet{textcolor}{gray}
\colorlet{headercolor}{gray}

%%%%%%%%%%%%%%%%%%%%%%%%
% Profile left SideBar %
%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}

% compute size of profile picture
\newcommand{\imsize}{\linewidth}
\newlength\imagewidth
\newlength\imagescale
\renewcommand{\imsize}{0.618\linewidth}
\pgfmathsetlength{\imagewidth}{5cm}%
\pgfmathsetlength{\imagescale}{\imagewidth/600}%

\newcommand{\profilesection}[2]{{\noindent\color{black!80} \LARGE #1 \rule[0.15\baselineskip]{#2}{1pt} \vspace{1pt}}}
\newcommand{\profilepic}[1]{\renewcommand{\givenprofilepic}{#1}} % picture
\newcommand{\cvjobtitle}[1]{\renewcommand{\givencvjobtitle}{#1}} % job title
\newcommand{\cvname}[1]{\renewcommand{\givencvname}{#1}}    % name
\newcommand{\cvmail}[1]{\renewcommand{\givencvmail}{#1}}    % mail-1
\newcommand{\cvmaill}[1]{\renewcommand{\givencvmaill}{#1}}  % mail-2
\newcommand{\cvsite}[1]{\renewcommand{\givencvsite}{#1}}    % site
\newcommand{\cvgithub}[1]{\renewcommand{\givencvgithub}{#1}}% GitHub
\newcommand{\cvorcid}[1]{\renewcommand{\givencvorcid}{#1}}  % ORC-ID
\newcommand{\cvpublons}[1]{\renewcommand{\givencvpublons}{#1}}  % Publons
\newcommand{\cvrg}[1]{\renewcommand{\givencvrg}{#1}}            % RG
\newcommand{\cvlinkedin}[1]{\renewcommand{\givencvlinkedin}{#1}}% RG
\newcommand{\aboutme}[1]{\renewcommand{\givenaboutme}{  \justifying#1}} % about me

\newcommand{\givencvname}{REQUIRED!} % name
\newcommand{\givenprofilepic}{}      % picture
\newcommand{\givencvjobtitle}{}      % job title
\newcommand{\givencvmail}{}          % mail-1
\newcommand{\givencvmaill}{}         % mail-2
\newcommand{\givencvsite}{}          % site
\newcommand{\givencvgithub}{}        % GitHub
\newcommand{\givencvorcid}{}         % ORC-ID
\newcommand{\givencvpublons}{}       % Publons
\newcommand{\givencvrg}{}     		 % RG
\newcommand{\givencvlinkedin}{}      % cvlinkedin
\newcommand{\givenaboutme}{}         % about me 

% icon in blue circle; #1 -> icon
\newcommand*\icon[1]{\tikz[baseline=(char.base)]{
  \node[shape=circle,draw,inner sep=1pt, fill=mainblue,mainblue,text=white] (char) {#1};}
}

% Text in square node with rounded corners; #1 -> text, #2 -> color
\newcommand*\round[2]{%
\tikz[baseline=(char.base)]\node[anchor=north west, draw,rectangle,
  rounded corners, inner sep=1.6pt, minimum size=5.5mm, text height=3.6mm,
  fill=#2,#2,text=white](char){#1};%
}

% skill bar graphs
\newcommand\skills[1]{
  \renewcommand{\givenskill}{
    \noindent
    \begin{tikzpicture}
    \foreach [count=\i] \x/\y in {#1}
    {
      \draw[fill=maingray,maingray] (0,-\i) rectangle (6,-\i+0.4);
      \draw[fill=white,mainblue](0,-\i) rectangle (1.2*\y,-\i+0.4);
      \node [above right ] at (0,-\i+0.4) {\x};
      \foreach \z in {0,1,2,...,10}
      {
        \coordinate (A\z) at ($(0,-\i)+(1.2*\z*0.5cm,0)$) {};
        \ifodd\z
            \draw[white] ($(A\z)$) -- ($(A\z)+(0,2.5pt)$);
        \else
            \draw[white] ($(A\z)$) -- ($(A\z)+(0,5pt)$);
        \fi
      }
    }
    \end{tikzpicture}
  }
}

% text style skills
\newcommand{\givenskill}{}
  \newcommand\skillstext[1]{
    \renewcommand{\giventextskill}{
    \begin{flushleft}
    \noindent
    \foreach [count=\i] \x/\y in {#1}
    {
      \x$ \star $\y
    }
    \end{flushleft}
  }
}

\newcommand{\giventextskill}{}

\newcommand{\makeprofile}
{
  % grey bar on the left side
  \begin{tikzpicture}[remember picture,overlay]
      \node [rectangle, fill=asidecolor, anchor=north, minimum width=9.90cm, minimum height=\paperheight+1cm] (box) at (-5cm,0.5cm){};
  \end{tikzpicture}

  \begin{textblock}{6}(0.5, 0.2)
    \begin{flushleft}
      \hspace{13pt}

      % profile picture
      \ifthenelse{\equal{\givenprofilepic}{}}{}{\begin{tikzpicture}[x=\imagescale,y=-\imagescale]
          \clip (600/2, 567/2) circle (567/2);
          \node[anchor=north west, inner sep=0pt, outer sep=0pt] at (0,0) {\includegraphics[width=\imagewidth]{\givenprofilepic}};
      \end{tikzpicture}}

      % name
      {\LARGE\color{mainblue}\givencvname}

      % jobtitle
      \begin{flushright}
        {\Large\color{black!80}\givencvjobtitle}
      \end{flushright}
      \renewcommand{\arraystretch}{1.6}

      % table with icons 
      \begin{tabular}{c @{\hskip 0.2cm} p{5cm}}
        % CV mail-1
        \ifthenelse{\equal{\givencvmail1}{}}{}{\href{mailto:\givencvmail}{\textsc{\Large\icon{\faEnvelope}}} & \href{mailto:\givencvmail}{\textcolor{cerulean}\givencvmail}\\}
        % CV mail-2
        \ifthenelse{\equal{\givencvmaill}{}}{}{\href{mailto:\givencvmaill}{\textsc{\Large\icon{\faIcon[regular]{envelope}}}} & \href{mailto:\givencvmaill}{\textcolor{cerulean}\givencvmaill}\\}
        % CV site
        \ifthenelse{\equal{\givencvsite}{}}{}{\href{https://dlinogarda.com/}{\textsc{\Large\icon{\faGlobe}}} & \href{https://dlinogarda.com/}{\textcolor{cerulean}\givencvsite}\\}
        % CV GitHub
        \ifthenelse{\equal{\givencvgithub}{}}{}{\href{\givencvgithub}{\textsc{\Large\icon{\faGithub}}} & \href{\givencvgithub}{\textcolor{cerulean}\givencvgithub}\\}
        % CV ORC-ID
        \ifthenelse{\equal{\givencvorcid}{}}{}{\href{https://orcid.org/0000-0001-5367-5392}{\textsc{\Large\icon{\faOrcid}}} & \href{https://orcid.org/0000-0001-5367-5392}{\textcolor{cerulean}\givencvorcid}\\}
        % CV Publons
        \ifthenelse{\equal{\givencvpublons}{}}{}{\href{https://publons.com/researcher/3605803/lino-garda-denaro/}{\textsc{\Large\icon{\faPinterest}}} & \href{https://publons.com/researcher/3605803/lino-garda-denaro/}{\textcolor{cerulean}\givencvpublons}\\}
        % RG
        \ifthenelse{\equal{\givencvrg}{}}{}{\href{https://www.researchgate.net/profile/Lino-Denaro}{\textsc{\Large\icon{\faResearchgate}}} & \href{https://www.researchgate.net/profile/Lino-Denaro}{\textcolor{cerulean}\givencvrg}\\}
        % CV Linked-In
        \ifthenelse{\equal{\givencvlinkedin}{}}{}{\href{https://www.linkedin.com/in/lino-garda-denaro-\%E6\%9D\%8E\%E8\%AB\%BE-0b070b18a/}{\textsc{\Large\icon{\faLinkedin}}} & \href{https://www.linkedin.com/in/lino-garda-denaro-\%E6\%9D\%8E\%E8\%AB\%BE-0b070b18a/}{\textcolor{cerulean}\givencvlinkedin}\\}
      \end{tabular}

      % about me text
      \profilesection{About me}{3.2cm}
      \givenaboutme

      % skills with scale
      \profilesection{Overall skills}{2.6cm}
      \givenskill
      \giventextskill
      \noindent
      \scriptsize
      \noindent
      [Last updated on: 07th July, 2022]

    \end{flushleft}
  \end{textblock}
  \vspace{-10pt}
}

%%%%%%%%%%%%%%%%%%%%%
% Section Color box %
%%%%%%%%%%%%%%%%%%%%%
\newcounter{colorCounter}
\def\@sectioncolor#1#2#3{
  {%
  % Switch between blue and gray
   \round{#1#2#3}{%
      \ifodd\value{colorCounter}%
        mainblue%
      \else%
        maingray%
      \fi%
    }%
  }%
  \stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{
  \par%
  {%
    \LARGE 
    \color{headercolor}%
    \@sectioncolor #1%
  }
  \par\vspace{\parskip}
}

\newcommand{\sectionicon}[2]{
  \par%
  {%
    \LARGE 
    #1 
    \color{headercolor}%
    \@sectioncolor #2%
  }
  \par\vspace{\parskip}
}

\renewcommand{\subsection}[1]{
  \par\vspace{.5\parskip}%
  {%
  \large\color{headercolor} #1%
  }
  \par\vspace{.25\parskip}%
}

\pagestyle{empty}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% List Table environment %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\setlength{\tabcolsep}{0pt}

\mdfdefinestyle{litem}{
  skipabove=0pt,
  skipbelow=0pt,
  leftmargin=\dimexpr\leftmargini-\fboxrule-4pt\relax,
  rightmargin=0pt,
  innerleftmargin=2pt,
  innerrightmargin=0pt,
  innertopmargin=0pt,
  innerbottommargin=0pt,
  leftline=true,
  rightline=false,
  topline=false,
  bottomline=false,
}

\newenvironment{litemize}{\trivlist\item\relax}{\endtrivlist}
\newenvironment{litem}
  {%
   \par\addvspace{3\itemsep}
   \begin{mdframed}[style=litem]
   \makebox[0pt][r]{\textbullet\hspace{\dimexpr\labelsep+2pt+\fboxrule}}\ignorespaces
  }
  {\\%
   \end{mdframed}
  }

\setlength{\tabcolsep}{0pt}
\newenvironment{TableTemplateList}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}
\renewcommand{\bfseries}{\color{headercolor}}
\newcommand{\TableTemplateListItem}[4]{%
  \hspace{5pt}#1&\parbox[t]{11.5cm}{%
    \textbf{#2}%
    \hfill%
    {\footnotesize#3}\\%
    #4\vspace{\parsep}%
  }\\%
}
\setlength{\tabcolsep}{0pt}






%%%%%%%%%%%%%%%%%%%%%%%%%%%
% List twenty environment %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{longtable}
\setlength{\tabcolsep}{0pt}
\newenvironment{TableTemplate}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}
\renewcommand{\bfseries}{\color{headercolor}}
\newcommand{\TableTemplateItem}[4]{%
  \hspace{5pt}#1&\parbox[t]{11.5cm}{%
    \textbf{#2}%
    \hfill%
    {\footnotesize#3}\\%
    #4\vspace{\parsep}%
  }\\%
}
\setlength{\tabcolsep}{0pt}
\newenvironment{twentyicon}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}
\renewcommand{\bfseries}{\color{headercolor}}
\newcommand{\twentyitemicon}[5]{%
 \hspace{3pt}\faicon{#1}\hspace{2pt}#2&\parbox[t]{11.2cm}{%
    \textbf{#3}%
    \hfill%
    {\footnotesize#4}\\%
    #5\vspace{\parsep}%
  }\\%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Small twenty List environment %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\tabcolsep}{0pt}
\newenvironment{twentyshort}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}
\renewcommand{\bfseries}{\color{headercolor}}
\newcommand{\twentyitemshort}[2]{%
  \hspace{5pt}#1&\parbox[t]{11.5cm}{%
    \textbf{#2}%
  }\\%
}
\setlength{\tabcolsep}{0pt}
\newenvironment{twentyshorticon}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}
\renewcommand{\bfseries}{\color{headercolor}}
\newcommand{\twentyitemshorticon}[3]{%
  \hspace{3pt}\faicon{#1}\hspace{3pt}#2&
      \parbox[t]{11.5cm}{%
    \textbf{#3}%
  }\\%
}

%%%%%%%%%%%%%%%%
% Page Setting %
%%%%%%%%%%%%%%%%
\RequirePackage[left=7.3cm,top=0.1cm,right=0.5cm,bottom=0.2cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}
