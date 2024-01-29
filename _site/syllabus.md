# Syllabus
Camille Seaberry

At its essence, the aim of data visualization is to move data and its
meaning(s) and context(s) from some origin (spreadsheets, observed
phenomena, etc.) to a larger audience. It’s a spectrum of incredibly
powerful tools for not just understanding and explaining facts, but also
for shaping what those facts are and creating the narrative around them.
By the end of this course, you will have thought through your role and
responsibility in an evolving field, developed a set of best practices
that is likely to continue to change, engaged with larger social
currents toward your own goals, and strengthened your skills in R.

Because this is part of a professional studies program based on open
source software and the ethos behind it, the course will be very
hands-on and require everyone’s willingness to contribute and
participate. Instead of tests and graded homework assignments, we’ll
focus on practice, critique, and revision, building continuously on
individual projects and shared tools. To some extent, the class
structure will mimic a workplace, where you have projects with
checkpoints and meetings to brainstorm and workshop your ideas, with
time to work both in class and on your own at home.

Because data science and data visualization—and the software we use for
both—change so quickly, a lot of the community’s discourse happens in
less formal settings, such as blogs, social media, podcasts, and
workshops, rather than just traditional academic journals and books. Our
readings (defined loosely enough to include videos of talks, podcasts,
and simply browsing through data visualization projects) will likewise
fall along this spectrum, and you’ll have some flexibility in what you
read and share.

**Above all, I want this to be a course that is useful to you as you
build a career of critical engagement with data.** The schedule is
intentionally loose so we can adjust based on skills we may want or need
to build upon, and each student’s goals and interests. Please be willing
to share what you want to learn, contribute resources, and ask for what
you need of me and each other.

## Objectives

The first half of the course will be focused on non-spatial data
visualization; the second half will be focused on spatial data and how
to integrate the two. Some of the principles we go over for non-spatial
and spatial will differ, but objectives remain the same.

By the end of the course, students will:

- Have an understanding of the **basics of visual perception**, and how
  to use that knowledge to design data visualizations well
- Be familiar with the **grammar of graphics** framework to think about
  components and purposes of visual elements
- Be skilled in **programming in R** and using the ggplot2 data
  visualization ecosystem
- Know how to **give and receive constructive feedback** on
  visualizations, both their own and others’, and to revise and improve
  upon their work
- Be able to **identify potential harms** done by inappropriate or
  misleading visualizations, and make corrections
- Be able to make, articulate, and argue for **good decisions** in
  designing charts and maps
- Have made many, many unpolished visualizations and several polished,
  presentation-ready ones

Successful students will finish the course with finished products for
their portfolios of high enough quality to include with applications to
jobs or other academic programs:

- 1–2 completed, **presentation-ready data visualization projects**
- **reproducible, documented code** that can be repurposed at another
  organization
- contributions to an **open source codebase**

## Materials

### Readings

All readings will be available to students for free. Many will be open
source texts and have code available. Readings will be a mix of theory
and practice.

The schedule of the course will roughly follow the structure of the book
*Fundamentals of Data Visualization* \[@Wilke2019\]. Both the book and
the source code used to write it are available for free online.

We’ll also read portions of *R for Data Science* \[@W.C.G2023\] (also
open source), *How Charts Lie* \[@Cairo2019\], and *Data Points*
\[@Yau2013\], as well as a variety of other sources of different media.
I’ll keep a running list of resources in the online class notes with
other tutorials and references.

### Software

This is a rough set of the software and tools we will use, with open
source software in italics:

- *[R programming language](https://cran.r-project.org/)*
- *[ggplot2](https://ggplot2.tidyverse.org/) and [related
  packages](https://exts.ggplot2.tidyverse.org/gallery/)*
- *[RStudio](https://posit.co/downloads/)* or another integrated
  development environment
- *[Quarto](https://quarto.org/),* a markdown-based publishing system
  from the same team as RStudio
- *[git](https://git-scm.com/)* for version control,
  [GitHub](https://github.com/) for storage of version-controlled
  materials, and GitHub Classroom for discussions and submitting code
- Blackboard for assignments and announcements

I’m open to suggestions on any other tools you all think would be
useful.

### Tools

If at all possible, **you should have a laptop of your own** for this
class. All the software we’re using is free and open source, so you
should be able to install everything on your computer. If you do not
have a laptop, you can borrow one from the library, or, because we will
be using git for version tracking and GitHub for storage, you can use a
lab computer and make sure to upload your work regularly.

We’ll be doing a lot of sketching by hand (you don’t have to be good at
drawing), so you’ll need **a notebook and pens or pencils** that are
nice to doodle with. I highly, *highly* recommend finding a graph paper
or dotted notebook.

## Schedule

The schedule has some flexibility built into it, but tentatively goes as
follows:

| Week | Section              | Topic                                                    |
|-----:|----------------------|----------------------------------------------------------|
|    1 | Non-spatial data viz | What is a chart, and do you need one?                    |
|    2 |                      | Encoding data to visuals; making meaning of your data    |
|    3 |                      | Writing good code; working with color                    |
|    4 |                      | Text and annotation; uncertainty and distribution        |
|    5 |                      | Making good decisions pt. 1                              |
|    6 |                      | Storytelling pt. 1 (empathy & equity); experimentation   |
|      |                      | *Project 1 due*                                          |
|    7 | Spatial data viz     | What is a map, and do you need one?                      |
|    8 |                      | Encoding data to space; harmful practices                |
|    9 |                      | Color, text, and annotations pt. 2                       |
|   10 |                      | Making good decisions pt. 2                              |
|   11 |                      | Accessibility, literacy, and audience                    |
|   12 |                      | Storytelling pt. 2 (history & cohesion); experimentation |
|   13 |                      | Final critique; tying up loose ends                      |
|   14 |                      | Finishing touches on projects                            |
|      |                      | *Project 2 due*                                          |

### Class structure

A typical class session will be roughly:

| Activity                   |                   Time |
|----------------------------|-----------------------:|
| Warm-up                    |           5-10 minutes |
| Report-backs               |  10-15 minutes, if any |
| Lecture                    | 1 hour max + questions |
| Workshop, critique, or lab |         Remaining time |

## Grading

In data visualization there aren’t any perfectly right answers, and
there aren’t too many perfectly wrong ones either. As a result, rather
than tedious quizzes and problem sets, your grade will reflect the
effort you put into developing your process and your critical eye, and
how successfully you create compelling stories with data.

### Participation

There will be opportunities for participation points every week,
including:

- Bringing in visualizations you’ve found for us to discuss
- Opening your work up for workshopping
- Contributing code (there’s an R package in development for this
  class), with more points given for students with less experience in
  R—this includes the less glamorous but crucial tasks of testing,
  debugging, and documenting
- Doing an optional reading or attending a talk and reporting back to
  the class on some interesting things you learned
- Adding a resource to the class notes

There will be two opportunities to lose points as well:

- Being mean or unnecessarily harsh in critique
- Unexcused absences (see below)

There’s no set number of participation points you need—just rack them up
when you can, forgo them when you have to, and I’ll scale them at the
end of the semester. Notice that most of these involve contributing to
your classmates’ growth as well as your own.

### Projects

There will be 2 projects, one midterm and one final, that you’ll be
working on throughout the semester. Both will build upon the exercises,
and you’ll have lots of time to work on them in class and receive
feedback from myself and your peers. The first will be non-spatial data,
and the second will be both spatial and non-spatial. You’ll be
responsible for moving from a dataset through to a polished
visualization that tells a story and has real-world impact. You will
also document your process along the way and have check-ins regularly.
Each project will also have a semi-formal write-up to explain what you
did and why, and to situate your work into the theory and principles we
study.

### Other assignments

We’ll have a few more small assignments, including short case studies
and peer reviews.

### Grading scale

Grades will be rounded to the nearest whole percent.

| Grade | Percentage |
|-------|-----------:|
| A+    |      97% + |
| A     |     93-96% |
| A-    |     90-92% |
| B+    |     87-89% |
| B     |     83-86% |
| B-    |     80-82% |
| C+    |     77-79% |
| C     |     73-76% |
| C-    |     70-72% |
| D+    |     67-69% |
| D     |     63-66% |
| D-    |     60-62% |
| F     |     \< 60% |

### Grade distribution

| Category                  | Share of grade |
|---------------------------|---------------:|
| Case studies              |            15% |
| Peer review & reflections |             5% |
| Participation             |            20% |
| Project 1 visualization   |            20% |
| Project 1 write-up        |             5% |
| Project 2 visualization   |            25% |
| Project 2 write-up        |            10% |

## Attendance

As grad students, your course load is one of many responsibilities you
juggle, so I know things will come up from time to time that prevent you
from getting to class. If you need to miss class or will be late, just
let me know in advance (email or DM), and as long as absences don’t
become excessive, it should be fine. If there is some reason you’ll need
to miss class several times, such as chronic illness (after all, COVID’s
still here), just let me know and we can figure something out. If you
can’t attend class but are able to participate remotely, I can stream on
Zoom or WebEx.

Unexcused absences, except for a serious emergency (e.g. you got into a
car accident on the way to campus), will cost you participation points.
Excused absences will not.

## UMBC policies

### Accessibility and Disability Accommodations, Guidance and Resources

Accommodations for students with disabilities are provided for all
students with a qualified disability under the Americans with
Disabilities Act (ADA & ADAAA) and Section 504 of the Rehabilitation Act
who request and are eligible for accommodations. The Office of Student
Disability Services (SDS) is the UMBC department designated to
coordinate accommodations that creates equal access for students when
barriers to participation exist in University courses, programs, or
activities.

If you have a documented disability and need to request academic
accommodations in your courses, please refer to the SDS website at
[sds.umbc.edu](http://sds.umbc.edu/) for registration information and
office procedures.

SDS email: [disAbility@umbc.edu](mailto:disability@umbc.edu)

SDS phone: [410-455-2459](tel:410-455-2459)

If you will be using SDS approved accommodations in this class, please
contact the instructor to discuss implementation of the accommodations.
During remote instruction requirements due to COVID, communication and
flexibility will be essential for success.

### Sexual Assault, Sexual Harassment, and Gender Based Violence and Discrimination

[UMBC
Policy](https://ecr.umbc.edu/gender-discrimination-sexual-misconduct/)
in addition to federal and state law (to include Title IX) prohibits
discrimination and harassment on the basis of sex, sexual orientation,
and gender identity in University programs and activities. Any student
who is impacted by sexual harassment, sexual assault, domestic violence,
dating violence, stalking, sexual exploitation, gender discrimination,
pregnancy discrimination, gender-based harassment, or related
retaliation should contact the University’s Title IX Coordinator to make
a report and/or access support and resources. The Title IX Coordinator
can be reached at <titleixcoordinator@umbc.edu> or 410-455-1717.

You can access support and resources even if you do not want to take any
further action. You will not be forced to file a formal complaint or
police report. Please be aware that the University may take action on
its own if essential to protect the safety of the community.

If you are interested in making a report, please use the [Online
Reporting/Referral
Form](https://umbc-advocate.symplicity.com/titleix_report/index.php/pid364290?). 
Please note that, if you report anonymously, the University’s ability to
respond will be limited.

#### Notice that Faculty and Teaching Assistants are Responsible Employees with Mandatory Reporting Obligations

All faculty members and teaching assistants are considered Responsible
Employees, per UMBC’s [Policy on Sexual Misconduct, Sexual Harassment,
and Gender
Discrimination](https://ecr.umbc.edu/policy-on-sexual-misconduct-sexual-harassment-and-gender-discrimination/).
Faculty and teaching assistants therefore required to report all known
information regarding alleged conduct that may be a violation of the
Policy to the Title IX Coordinator, even if a student discloses an
experience that occurred before attending UMBC and/or an incident that
only involves people not affiliated with UMBC.  Reports are required
regardless of the amount of detail provided and even in instances where
support has already been offered or received.

While faculty members want to encourage you to share information related
to your life experiences through discussion and written work, students
should understand that faculty are required to report past and present
sexual harassment, sexual assault, domestic and dating violence,
stalking, and gender discrimination that is shared with them to the
Title IX Coordinator so that the University can inform students of their
[rights, resources, and
support](https://ecr.umbc.edu/rights-and-resources/).  While you are
encouraged to do so, you are not obligated to respond to outreach
conducted as a result of a report to the Title IX Coordinator.

If you need to speak with someone in confidence, who does not have an
obligation to report to the Title IX Coordinator, UMBC has a number of
[Confidential
Resources](https://ecr.umbc.edu/policy-on-sexual-misconduct-sexual-harassment-and-gender-discrimination/#confidential-resources)
available to support you: 

[Retriever Integrated Health](https://health.umbc.edu/) (Main Campus):
410-455-2472; Monday – Friday 8:30 a.m. – 5 p.m.; For After-Hours
Support, Call 988.

[Center for Counseling and
Well-Being](https://shadygrove.umd.edu/student-affairs/counseling-well-being)
(Shady Grove Campus): 301-738-6273; Monday-Thursday 10:00a.m. – 7:00
p.m. and Friday 10:00 a.m. – 2:00 p.m. (virtual) [Online Appointment
Request Form](https://shadygrove.titaniumhwc.com/)

Pastoral Counseling via [The Gathering Space for Spiritual
Well-Being](https://i3b.umbc.edu/spaces/the-gathering-space-for-spiritual-well-being/):
410-455-6795; <i3b@umbc.edu>; Monday – Friday 8:00 a.m. – 10:00 p.m.

#### Other Resources

[Women’s Center](https://womenscenter.umbc.edu/) (open to students of
all genders): [410-455-2714](tel:410-455-2714); <womenscenter@umbc.edu>;
Monday – Thursday 9:30 a.m. – 5:00 p.m. and Friday 10:00 a.m. – 4 p.m.

[Shady Grove Student
Resources](https://ecr.umbc.edu/shady-grove-title-ix-resources/), [Maryland
Resources](https://ecr.umbc.edu/maryland-resources/), [National
Resources](https://ecr.umbc.edu/national-resources/).

#### [Child Abuse and Neglect](https://ecr.umbc.edu/child-protection/)

Please note that Maryland law and [UMBC
policy](https://education.umbc.edu/child-abuse-reporting-policy//)
require that faculty report all disclosures or suspicions of child abuse
or neglect to the Department of Social Services and\_/\_or the police
even if the person who experienced the abuse or neglect is now over 18.

### [Pregnant and Parenting Students](https://www2.ed.gov/about/offices/list/ocr/docs/pregnancy.html)

UMBC’s [Policy on Sexual Misconduct, Sexual Harassment and Gender
Discrimination](https://ecr.umbc.edu/policy-on-sexual-misconduct-sexual-harassment-and-gender-discrimination/)
expressly prohibits all forms of discrimination and harassment on the
basis of sex, including pregnancy. Resources for pregnant, parenting and
breastfeeding students are available through the University’s [Office of
Equity and Civil Rights](https://ecr.umbc.edu/students/).  Pregnant and
parenting students are encouraged to contact the Title IX Coordinator to
discuss plans and ensure ongoing access to their academic program with
respect to a leave of absence – returning following leave, or any other
accommodation that may be needed related to pregnancy, childbirth,
adoption, breastfeeding, and/or the early months of parenting.

In addition, students who are pregnant and have an impairment related to
their pregnancy that qualifies as disability under the ADA may be
entitled to accommodations through the [Office of Student Disability
Services](https://sds.umbc.edu/accommodations/registering-with-sds/).

### Religious Observances & Accommodations

UMBC
[Policy](https://provost.umbc.edu/wp-content/uploads/sites/46/2022/08/Religious-Observance-Academic-Policy-2022_2023.pdf)
provides that students should not be penalized because of observances of
their religious beliefs, and that students shall be given an
opportunity, whenever feasible, to make up within a reasonable time any
academic assignment that is missed due to individual participation in
religious observances. It is the responsibility of the student to inform
the instructor of any intended absences or requested modifications for
religious observances in advance, and as early as possible. For
questions or guidance regarding religious observances and
accommodations, please contact the Office of Equity and Civil Rights at
<ecr@umbc.edu>.

### Hate, Bias, Discrimination and Harassment

UMBC values safety, cultural and ethnic diversity, social
responsibility, lifelong learning, equity, and civic engagement.

Consistent with these principles, [UMBC
Policy](https://ecr.umbc.edu/discrimination-and-bias/) prohibits
discrimination and harassment in its educational programs and activities
or with respect to employment terms and conditions based on race, creed,
color, religion, sex, gender, pregnancy, ancestry, age, gender identity
or expression, national origin, veterans status, marital status, sexual
orientation, physical or mental disability, or genetic information.

Students (and faculty and staff) who experience discrimination,
harassment, hate, or bias based upon a protected status or who have such
matters reported to them should use the [online reporting/referral
form](https://umbc-advocate.symplicity.com/titleix_report/index.php/pid954154?)
to report discrimination, hate, or bias incidents. You may report
incidents that happen to you anonymously. Please note that, if you
report anonymously, the University’s ability to respond may be limited.

<div id="3ade8a4a-fb1d-4a6c-8409-ac45482d5fc9" class="hidden">

</div>
