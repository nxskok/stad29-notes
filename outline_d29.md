---
title: "STAD29: Statistics for the Life and Social Sciences"
author: "Lecture notes"
header-includes:
   - \usepackage{multicol}
output: 
  beamer_presentation:
    latex_engine: lualatex
    slide_level: 2
    df_print: kable
    theme: "AnnArbor"
    colortheme: "dove"
---










```
## Installing package into '/home/ken/R/x86_64-pc-linux-gnu-library/3.6'
## (as 'lib' is unspecified)
```

```
## Warning in install.packages("mgcv", type =
## "source"): installation of package 'mgcv' had non-
## zero exit status
```





# Course Outline

## Course and instructor


*  Lecture: Wednesday 14:00-16:00 in HW 215. Optional computer
lab Monday 16:00-17:00 in BV 498.

*  Instructor: Ken Butler

*  Office: IC 471.

*  E-mail: `butler@utsc.utoronto.ca`

* Office hours: Wednesday 11:00-12:00. Or make an appointment. E-mail always
good.

* Course website:
[link](http://ritsokiguess.site/STAD29/).

* Using Quercus for assignments/grades only; using website for
everything else.




## Texts



* There is no official text for this course. 

* You may find "R for Data Science", 
[**link**](http://r4ds.had.co.nz/) helpful for R background.

* I will refer frequently to my book of Problems and Solutions in Applied Statistics (PASIAS), [**link**](http://ritsokiguess.site/pasias/).

* Both of these resources are and will remain free.



## Programs, prerequisites and exclusions


* Prerequisites:


* For undergrads: STAC32. Not negotiable.

*  For grad students,
a first course in statistics, and some training in
regression and ANOVA. The less you know, the more you'll have to
catch up!


* This course is a required part of Applied Statistics minor.

* Exclusions: **this course is not for Math/Statistics/CS majors/minors**. 
It is for students in other
fields who wish to learn some more advanced statistical
methods. The exclusions in the Calendar reflect this. 

* If you
are in one of those programs, you won't get program credit for
this course, **or for any future STA courses you take.**


## Computing


* Computing: big part of the course, **not**
optional. You will need to demonstrate that you can use 
R to analyze data, and can
critically interpret the output.

* For grad students who have not come through STAC32, I am happy
to offer extra help to get you up to speed.


## Assessment 1/2


* Grading: (2 hour) midterm, (3 hour) final exam. Assignments most
weeks, due Tuesday at 11:59pm. 
Graduate students (STA 1007) also required to
complete a project using one or more of the techniques learned in
class, on a dataset from their field of study.    Projects due on
the last day of classes.


* Assessment:
\begin{tabular}{lcc}
& STAD29 & STA 1007\\
Assignments & 20\% & 20\%\\
Midterm exam & 30\%  & 20\% \\
Project & - & 20\%\\
Final exam & 50\% & 40\%
\end{tabular}

## Assessment 2/2

* Assessments missed *with documentation* will cause a
re-weighting of other assessments of same type. No make-ups.

* You **must pass the final exam** to guarantee passing the course. If you
fail the final exam but would otherwise have passed the course, you
receive a grade of 45.




## Plagiarism


* [**This link**](http://www.utoronto.ca/academicintegrity/academicoffenses.html)
defines academic offences at this university. Read it. You are bound by it. 

* Plagiarism defined (at the end) as

> The wrongful appropriation and purloining, and publication as one’s own, of the ideas, 
> or the expression of the ideas ... of another.

* The code and
explanations  that
you write and hand in must be *yours and yours alone*.

* When you hand in work, it is implied that it is
*your* work. Handing in work, with your name on it, that was actually done by
someone else is an *academic offence*.

* If I am suspicious
that anyone's work is plagiarized, I will take action.



## Getting help


* The English Language Development Centre supports all students
in developing better Academic English and critical thinking skills
needed in academic communication. Make use of the personalized
support in academic writing skills development. Details and sign-up information:
[link](http://www.utsc.utoronto.ca/eld/).

* Students with diverse learning styles and needs are welcome in this
course. In particular, if you have a disability/health consideration
that may require accommodations, please feel free to approach the AccessAbility Services Office as soon as possible. I will
work with you and AccessAbility Services to ensure you can achieve
your learning goals in this course. Enquiries are confidential. The
UTSC AccessAbility Services staff are available by
appointment to assess specific needs, provide referrals and arrange
appropriate accommodations: (416) 287-7560 or by e-mail: `ability@utsc.utoronto.ca`.


## Course material 

- Dates and times
- Regression-like things 
  - review of (multiple) regression
  - logistic regression (including multi-category responses)
  - survival analysis
- ANOVA-like things
  - more ANOVA
  - multivariate ANOVA
  - repeated measures
- Multivariate methods
  - discriminant analysis
  - cluster analysis
  - (multidimensional scaling)
  - principal components
  - factor analysis
- Miscellanea
  - (time series), multiway frequency tables

  

