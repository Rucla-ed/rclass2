---
title: "Introduction to Git and GitHub"
author: 
date: 
urlcolor: blue
output: 
  html_document:
    toc: true
    toc_depth: 2
    toc_float: true # toc_float option to float the table of contents to the left of the main document content. floating table of contents will always be visible even when the document is scrolled
      #collapsed: false # collapsed (defaults to TRUE) controls whether the TOC appears with only the top-level (e.g., H2) headers. If collapsed initially, the TOC is automatically expanded inline when necessary
      #smooth_scroll: true # smooth_scroll (defaults to TRUE) controls whether page scrolls are animated when TOC items are navigated to via mouse clicks
    number_sections: true
    fig_caption: true # ? this option doesn't seem to be working for figure inserted below outside of r code chunk    
    highlight: tango # Supported styles include "default", "tango", "pygments", "kate", "monochrome", "espresso", "zenburn", and "haddock" (specify null to prevent syntax    
    theme: default # theme specifies the Bootstrap theme to use for the page. Valid themes include default, cerulean, journal, flatly, readable, spacelab, united, cosmo, lumen, paper, sandstone, simplex, and yeti.
    df_print: tibble #options: default, tibble, paged
    keep_md: true # may be helpful for storing on github
    
---

# Introduction


Load packages:

```r
library(tidyverse)
```

Resources used to create this lecture:

- https://happygitwithr.com/
- https://edquant.github.io/edh7916/lessons/intro.html
- https://www.codecademy.com/articles/f1-u3-git-setup
- https://medium.com/@lucasmaurer/git-gud-the-working-tree-staging-area-and-local-repo-a1f0f4822018

## What and why use Git and GitHub?  

[Video](https://www.dropbox.com/s/r4gij79tw8dx1zv/doyle_why_code_git.mp4?dl=0) from Will Doyle, Professor at Vanderbilt University

What is __version control__?

- [Version control](https://git-scm.com/book/en/v2/Getting-Started-About-Version-Control) is a "system that records changes to a file or set of files over time so that you can recall specific versions later"
- Keeps records of changes, who made changes, and when those changes were made
- You or collaborators take "snapshots" of a document at a particular point in time. Later on, you can recover any previous snapshot of the document.

How version control works:

- Imagine you write a simple text file document that gives a recipe for yummy chocolate chip cookies and you save it as `cookies.txt`
- Later on, you make changes to `cookies.txt` (e.g., add alternative baking time for people who like "soft and chewy" cookies)
- When using version control to make these changes, you don't save entirely new version of `cookies.txt`; rather, you save the changes made relative to the previous version of `cookies.txt`


Why use version control when you can just save new version of document?

1. Saving entirely new document each time a change is made is very inefficient from a memory/storage perspective
    - When you save a new version of a document, much of the contents are the same as the previous version
    - Inefficient to devote space to saving multiple copies of the same content
1. When document undergoes lots of changes -- especially a document that multiple people are collaborating on -- it's hard to keep track of so many different documents. Easy to end up with a situation like this:



[![](https://pbs.twimg.com/media/B9HgQmDIEAALfb4.jpg)](http://www.phdcomics.com/comics/archive.php?comicid=1531)

*Credit: Jorge Chan (and also, lifted this example from Benjamin Skinner's [intro to Git/GitHub lecture](https://edquant.github.io/edh7916/lessons/intro.html))*

<br>

What is __Git__? (from git [website](https://git-scm.com/))

> "Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency"

- Git is a particular version control software created by _The Git Project_
- Git can be used by:
    - An individual/standalone developer
    - For collaborative projects, where multiple people collaborate on each file
- The term "__distributed__" means that every user collaborating on the project has access to all files and the history of changes to all files
- Git is the industry standard version control system used to create software
    - For example, [Zoom](https://zoom.us/) is developed on GitHub ([Zoom GitHub site](https://github.com/zoom))
- Increasingly, Git is the industry standard for collaborative academic research projects
    - E.g., the nascent [Unrollment Project](https://github.com/eddatasci/unrollment_proj)
    - Used GitHub to develop research on recruiting by universities at https://emraresearch.org/

What is a __Git repository__?

- A Git repository is any project managed in Git
- From [Git Handbook](https://guides.github.com/introduction/git-handbook/) by github.com:
    - A repository "encompasses the entire collection of files and folders associated with a project, along with each file’s revision history"
    - Because git is a __distributed__ version control system, "repositories are self-contained units and anyone who owns a copy of the repository can access the entire codebase and its history"
- This course is a Git repository ([Rclass2 repository](https://github.com/Rucla-ed/rclass2))
- Local vs. remote git repository:
    - __Local__ git repository: git repository for a project stored on your machine
    - __Remote__ git repository: git repository for a project stored on the internet
- Typically, a local git repository is connected to a remote git repository
    - You can make changes to local repository on your machine and then __push__ those changes to the remote repository
    - A collaborator can make changes to their local repository, push them to the remote repository, and then you can __pull__ these changes into your local repository


What is __GitHub__?

- [GitHub](https://github.com/) is the industry standard hosting site/service for Git repositories
    - Hosting services allow people/organizations to store files on the internet and make those files available to others
- GitHub stores your local repositories in "the cloud"
    - E.g., if you create a local repository stored on your machine, GitHub enables you to create a "remote" version of this repository
    - Also, you can connect to a remote repository that already exists and create a local version of this respository on your machine
- More broadly, GitHub enables you to store files, share code, and collaborate with others

## How we will learn Git and GitHub

> "Whoah, I’ve just read this quick tutorial about git and oh my god it is cool. I feel now super comfortable using it, and I’m not afraid at all to break something.”— said no one ever ([de Wulf](https://www.daolf.com/posts/git-series-part-1/))

<!--
NOTE FOR LATER: READ HIS THREE POSTS ON UNDERSTANDING WHAT'S IN .GIT AND PUT THAT INFO IN LATER CHAPTER OF YOUR GITHUB LECTURE

- https://www.daolf.com/posts/git-series-part-1/ [part 1, what's in .git]
- https://www.daolf.com/posts/git-series-part-2/ [part 2, rebasing and "golden rule"]
- https://www.daolf.com/posts/git-series-part-3/ [part 3, more on rebase]
-->

Understanding and learning how to use Git and GitHub can be intimidating. A lot of tutorials give you recipes for how to accomplish specific tasks (either point-and-click or issuing commands on command line), but don't provide a conceptual understanding of how things work.

Here is how we will learn Git and GitHub over the course of the quarter:

- The first of three "units" of the course will be (mostly) devoted to Git and GitHub
- During the Git/GitHub unit, we will:
    - Provide a conceptual overview of concepts and workflow
    - Show you how to accomplish specific tasks by issuing commands on the command line
    - Devote time to providing in-depth conceptual understanding of particular topics/concepts
    - You will practice doing Git/GitHub stuff during in-class exercises and in weekly problem sets
- With the exception of using [github.com](https://github.com/) website for communication ("issues") and for creating/cloning repositories, we will perform all tasks on the "command line" rather than using a point-and-click graphical user interface (GUI)
    - Initially, this will feel intimidating, but after a few weeks you will see that this helps you understand Git/GitHub better and is much more efficient
- After the Git/GitHub unit:
    - Weekly problem sets will be completed and submitted using GitHub
    - When communicating with your problem set "team," you will use GitHub "issues"
    - When posing questions to instructors/classmates, you will use GitHub "issues"
    - Selected additional lectures/class exercises about additional Git/GitHub concepts

Organization of `github_lecture.Rmd`, which will be the basis for the Git/GitHub unit:



- [Introduction](#introduction)
    - [What and why use Git and GitHub?  ](#what-and-why-use-git-and-github?-)
    - [How we will learn Git and GitHub](#how-we-will-learn-git-and-github)
- [Overview of core concepts and work flow](#overview-of-core-concepts-and-work-flow)
    - [Git stores "snapshots," not "differences"](#git-stores-"snapshots,"-not-"differences")
    - [Three components of a Git project](#three-components-of-a-git-project)
    - [Git/GitHub work flow](#git/github-work-flow)
    - [Branch and merge](#branch-and-merge)
        - [Branches](#branches)
        - [Merges](#merges)
    - [Models for collaborative development](#models-for-collaborative-development)
        - [Shared repository](#shared-repository)
        - [Fork and pull](#fork-and-pull)
- [Command line](#command-line)
    - [Shell/command line vs. graphical user interface (GUI)](#shell/command-line-vs.-graphical-user-interface-(gui))
        - [Command-line bullshittery](#command-line-bullshittery)
    - [Basic (Bash) commands line commands](#basic-(bash)-commands-line-commands)
        - [logistics for running `Bash` code in .Rmd code chunks [skip]](#logistics-for-running-`bash`-code-in-.rmd-code-chunks-[skip])
        - [Bash syntax](#bash-syntax)
        - [Changing directories](#changing-directories)
        - [Creating/deleting directories](#creating/deleting-directories)
        - [Other commands](#other-commands)
- [Basic Git tasks](#basic-git-tasks)
    - [Git commands](#git-commands)
    - [Creating and cloning repositories](#creating-and-cloning-repositories)
        - [Clone an existing repository to your local machine](#clone-an-existing-repository-to-your-local-machine)
        - [Create new repository on GitHub and clone to your local machine](#create-new-repository-on-github-and-clone-to-your-local-machine)
        - [Create new git repository on your local machine and add to GitHub](#create-new-git-repository-on-your-local-machine-and-add-to-github)
- [Git: Under the hood](#git:-under-the-hood)
    - [git/ directory](#git/-directory)
    - [Git objects](#git-objects)
        - [Blob object](#blob-object)
        - [Tree object](#tree-object)
        - [Commit object](#commit-object)
        - [Tag object](#tag-object)
    - [HEAD and refs/](#head-and-refs/)
    - [Full example](#full-example)
- [Git commands: Observing your repository](#git-commands:-observing-your-repository)
    - [git status](#git-status)
    - [git log](#git-log)
    - [git diff](#git-diff)
- [Git commands: Undoing changes](#git-commands:-undoing-changes)
    - [git checkout](#git-checkout)
    - [git reset](#git-reset)
    - [git revert](#git-revert)

# Overview of core concepts and work flow


This section introduces some core concepts and then explains the Git "work flow" (i.e., how Git works)

## Git stores "snapshots," not "differences"

Version control systems that save "differences"

- Prior to Git, "centralized version control systems" were the industry standard version control systems (From [Getting Started - About Version Control](https://git-scm.com/book/en/v2/Getting-Started-About-Version-Control))
    - In these systems, a central server stored all the versions of a file and "clients" (e.g., a programmer working on a project on their local computer) could "check out" files from the central server
- These centralized version control systems stored multiple versions of a file as "differences"
    - For example, imagine you create a simple text file called `twinkle.txt`
    - "Version 1" (the "base" version) of `twinkle.txt` has the following contents:
        - `twinkle, twinkle, little star`
    - You make some changes to `twinkle.txt` and save those changes, resulting in "Version 2," which has the following contents:
        - `twinkle, twinkle, little star, how I wonder what you are!`
    - When storing "Version 2" of `twinkle.txt`, centralized version control systems don't store the entire file. Rather, they store the changes relative to the previous version. In our example, "Version 2" stores:
        - `, how I wonder what you are!`
- The below figure portrays version control systems that store data as changes relative to the base version of each file:    

<br>

[![](https://git-scm.com/book/en/v2/images/deltas.png)](https://git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F)

*Credit: [Getting Started - What is Git](https://git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F)*

<br>

Git stores data as "snapshots" rather than "differences" (From [Getting Started - What is Git](https://git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F))

- Git doesn't think of data as differences relative to the base version of each file
- Rather, Git thinks of data as "a series of snapshots of a minature filesystem" or, said differently, a series of snapshots of all files in the repository.
- "With Git, every time you commit, or save the state of your project, Git basically takes a picture of what all your files look like at that moment and stores a reference to that snapshot."
- "To be efficient, if files have not changed, Git doesn’t store the file again, just a link to the previous identical file it has already stored."
- The below figure portrays storing data as a stream of snapshots over time:

<br>

[![](https://git-scm.com/book/en/v2/images/snapshots.png)](https://git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F)

*Credit: [Getting Started - What is Git](https://git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F)*

<br>

What is a __commit__?

- A **commit** is a snapshot of all files in the repository at a particular time
- Example: Imagine you are working on a project (repository) that contains a dozen files.
    - You change two files and make a commit
    - Git takes a snapshot of the full repository (all files)
    - Content that remains unchanged relative to the previous commit is stored vis-a-vis a link to the previous commit

## Three components of a Git project

- __Local working directory (also called "working tree")__
    - This is the area where all your work happens! You are writing Rmd files, debugging R-scripts, adding and deleting files
    - These changes are made on your local machine!
- __Git index/staging area__
    - The staging area is the area between your _local working directory_ and the _repository_, where you list changes you have made in the local working directory that you would like to commit to the repository
    - Hypothetical work flow (imagine you are working on document `cookies.txt`):
        - Make changes to `cookies.txt` in a text editor. These are changes made in your _local working directory_.
        - Imagine you are happy with some changes you made to `cookies.txt` and you want to ***commit*** those changes to your repository
        - Before you commit changes to repository, you must ***add*** them to the _staging area_ as an intermediary step
- __Repository__
    - This is the actual repository where Git permanently stores the changes you've made in the local working directory and added to the staging area as different versions of the project file
    - Hypothetical work flow to `cookies.txt`:
        - ***Add*** changes from _local working directory_ to _staging area_
        - ***Commit*** changes from _staging area_ to _repository_
    - Each commit to the repository is a different version of the file that represents a snapshot of the file at a particular time
    - Local vs. remote repository
        - When you add a change to the _staging area_ and then commit the change to your _repository_, this changes your _local repository_ rather than your _remote repository_
        - If you want to change your _remote repository_, you must ***push*** the change from your _local repository_ to your _remote repository_

<br>

[![](https://miro.medium.com/max/686/1*diRLm1S5hkVoh5qeArND0Q.png)](https://medium.com/@lucasmaurer/git-gud-the-working-tree-staging-area-and-local-repo-a1f0f4822018)

*Credit: Lucas Maurer, medium.com*

## Git/GitHub work flow

<br>

[![](https://www.jrebel.com/sites/rebel/files/blog-images/2016/02/GitHub-cheat-sheet-graphic-v1.jpg)](https://www.jrebel.com/blog/git-cheat-sheet)

*Credit: Simon Maple, JRebel, https://www.jrebel.com/blog/git-cheat-sheet*

<br>

Git commands:

- `add`: Add file from working directory to staging area
- `commit`: Commit file from staging area to local repository
- `push`: Send files from local repository (your machine) to remote repository
    - Synchronizes local repository and remote repository
    - Think of `push` as "uploading"
- `fetch`: Get files from remote repository and put them in local repository
- `pull`: Get files from remote repository and put them in the working directory
    - Think of `pull` as "downloading"
    - `pull` is effectively `fetch` followed by `merge` (discussed later)
- `reset`: After you `add` files from working directory to staging area, `reset` unstages those files

## Branch and merge

### Branches

<!--
HELPFUL RESOURCES ON BRANCHES I USED TO CREATE THIS SECTION

- https://geeks.uniplaces.com/mastering-branches-in-git-f20cb2d0c51f
- https://backlog.com/git-tutorial/using-branches/
- https://guides.github.com/activities/hello-world/
-->

Why are __branches__ necessary? (Drawing from [Using branches](https://backlog.com/git-tutorial/using-branches/) tutorial)

- __Branching__ is a means of working on different versions of files in a repository at one time
    - Branching is useful for "solo developer" projects (e.g., a PhD dissertation that does not build on an existing project) but is essential for collaborative projects
- In collaborative projects, it is common for several programmers to share and work on the same programming scripts
- Example in programming/software development world: 
    - Imagine your bank is creating a new mobile banking app
    - Some programmers are fixing a bug in how the app imports data from your account
    - Other programmers are developing a new feature (e.g., allowing users to use Venmo to transfer funds)
    - "With so much going on, there needs to be a system in place for managing different versions of the same code base."
- Example from social science research world:
    - In the [Unrollment Project](https://github.com/eddatasci/unrollment_proj) we are exploring potential bias in alternative algorithms to predict student success
    - We have a file [predict_grad.Rmd](https://github.com/eddatasci/unrollment_proj/blob/master/scripts/rmd/predict_grad.Rmd) that reads in secondary data, creates analysis variables, runs alternative models for predicting the probability of obtaining a BA
    - Several collaborators are working on different parts of `predict_grad.Rmd`. For example, one person writing functions to clean data and create analysis variables and another person writing functions to run models and store model results.
    - Need a way for multiple people to work on `predict_grad.Rmd` at the same time
    
What is a __branch__?

- A branch is an "independent line of development" that "isolates your work from that of other team members" ([Using branches](https://backlog.com/git-tutorial/using-branches/) tutorial)
- By default, a git repository "has one branch named __master__ which is considered to be the definitive branch. We use [other] branches to experiment and make edits before committing them to __master__" ([Hello World](https://guides.github.com/activities/hello-world/) tutorial)
- "When you create a branch off the __master__ branch, you’re making a copy, or snapshot, of master as it was at that point in time"
- Branches are sometimes described as "deviations" from the master branch
- The below image shows three branches -- the master, "Branch 1," and "Branch 2" -- and each circle represents a commit:

[![](https://miro.medium.com/max/552/1*PiduCtSA7kMwdPiMZo1nHw.jpeg)](https://geeks.uniplaces.com/mastering-branches-in-git-f20cb2d0c51f)

*Credit: [Mastering git branches](https://geeks.uniplaces.com/mastering-branches-in-git-f20cb2d0c51f) by Henrique Mota*

<br>

Defining branches in terms of commits:

- People often define a __branch__ as "a pointer to a single commit"
    - In programming, a "pointer" is a variable/object that stores the address of other variables or objects in memory
- Recall that a **commit** is a snapshot of a repository at a particular point in time
    - Each commit also stores connections (referred to as "references") between the current commit and previous commits (referred to as "ancestors")
- The figure below shows the relationship between commits, references, and branches
- Below, commits 1, 2, 3, and 4 are made to the __master__ branch, prior to the creation of "branch 1"
    - When we make "commit 2," we create "reference 1," which is a pointer from "commit 2" to "commit 1"
- "commit 4" is the last commit made to the master branch prior to the creation of "branch 1"
- We can think of "branch 1" as a pointer to "commit 4"
- When we make additional commits to "branch 1" (e.g., "commit 5," "commit 7") we also create references to the previous commit
    - For example, "commit 5" creates "reference 4," which is a pointer from "commit 5" to "commit 4"

<br>

[![](https://miro.medium.com/max/626/1*IkZTYrKIf8E3chEvgIiOxA.jpeg)](https://geeks.uniplaces.com/mastering-branches-in-git-f20cb2d0c51f)

*Credit: [Mastering git branches](https://geeks.uniplaces.com/mastering-branches-in-git-f20cb2d0c51f) by Henrique Mota*

### Merges

<!--
RESOURCES USED TO CREATE SUB-SECTION

- https://www.freecodecamp.org/news/an-introduction-to-git-merge-and-rebase-what-they-are-and-how-to-use-them-131b863785f/
- https://geeks.uniplaces.com/mastering-branches-in-git-f20cb2d0c51f
- https://community.intersystems.com/post/continuous-delivery-your-intersystems-solution-using-gitlab-part-i-git
-->

The goal of a **merge** is to "integrate changes from multiple branches into one [branch]" ([An introduction to Git merge and rebase](https://www.freecodecamp.org/news/an-introduction-to-git-merge-and-rebase-what-they-are-and-how-to-use-them-131b863785f/))

The below image shows a merge between the __master__ branch and a branch named "develop"

- Each circle represents a commit
- The "develop" branch was created after "commit 2" on the __master__
- After two commits, the "develop" branch is merged back into the __master__

<br>
[![](https://community.intersystems.com/sites/default/files/inline/images/risunok4.png)](https://community.intersystems.com/post/continuous-delivery-your-intersystems-solution-using-gitlab-part-i-git)

*Credit: [Eduard Lebedyuk](https://community.intersystems.com/post/continuous-delivery-your-intersystems-solution-using-gitlab-part-i-git)*

<br>
Merge terminology:

- "Current branch"
    - Branch you are currently working with
    - The branch will be updated/modified by the merge with the "target branch"
    - In the figure above, the __master__ branch is the "current branch"
- "Target branch"
    - Branch that will be merged into the "current branch"
    - Target branch will be unaffected by the merge
    - Often, programmers delete the target branch after merging with the current branch
    - In the figure above, "develop" is the target branch
    
How programmers use branches and merges in day-to-day work:

- Typically, programmers do all work on branches rather than the __master__ branch
    - For example, in the [Unrollment Project](https://github.com/eddatasci/unrollment_proj), project co-founders [Will Doyle](https://github.com/wdoyle42) and [Ben Skinner](https://github.com/btskinner) stated that all project work should be done on branches rather than the master
- Branches are created for specific tasks (e.g., fixing a bug, adding a new feature)
    - "Short-lived topic branches, in particular, keep teams focused" ([Git Handbook](https://guides.github.com/introduction/git-handbook/))
    - Once the specific task is completed, the topic branch is merged into the __master__ branch and then the topic branch is often deleted

<!--
Later on, we will devote more time to learning the conceptual and technical aspects of merging.

"Here at GitHub, our developers, writers, and designers use branches for keeping bug fixes and feature work separate from our master (production) branch. When a change is ready, they merge their non-master branch into the master branch"

Create a branch: Topic branches created from the canonical deployment branch (usually master) allow teams to contribute to many parallel efforts. Short-lived topic branches, in particular, keep teams focused and results in quick ships

Git merge 
https://guides.github.com/introduction/git-handbook/
“git merge merges lines of development together. This command is typically used to combine changes made on two distinct branches. For example, a developer would merge when they want to combine changes from a feature branch into the master branch for deployment.

-->

## Models for collaborative development

<!--
RESOURCES USED TO CREATE SUB-SECTION

- https://guides.github.com/introduction/git-handbook/
-->

Two primary ways people collaborate on GitHub:

1. Shared repository
1. Fork and pull

### Shared repository

<br>
[![](https://miro.medium.com/max/1698/1*CEyiDu_mQ5u9NI0Fr2pSdA.png)](https://medium.com/faun/centralized-vs-distributed-version-control-systems-a135091299f0)

*Credit: [Matuesz Lubanski](https://medium.com/faun/centralized-vs-distributed-version-control-systems-a135091299f0)*

<br>


Overview of "shared repository" work flow:

- All work on project happens in a single repository
- Everyone working on the project `clones` the repository to their local computer
- Designate level of "access" for each team member
    - Read access
    - Write access
    - Administrator access
- As an individual team member, you work on specific tasks (e.g., fix a bug, add a new feature, write a lecture on a topic)
    - Work on tasks in your local working directory on your local machine
        - Often, work on tasks in a branch other than __master__
    - Once you complete a task, `commit` changes to your local repository
    - `push` changes from local repository on your machine to remote repository shared with collaborators
- Other team members also working on specific tasks that they `commit` to their local repository and then `push` to the remote repository
    - After your team members `push` a change to remote respository, you may `pull` those changes to your local repository and local working directory
- Issuing a "pull request"
    - For most collaborative projects, users do not simply `push` their changes to the master branch of the shared remote repository
    - Why? Before pushing final changes to shared repository, those changes should be reviewed by other team members. This can be done by issuing a "pull request."
    - A "pull request" is an announcement to team members that you have made changes and you want those changes to be reviewed before they become final (e.g., merged to the master branch)
        - "If you send a pull request to another repository, you ask their maintainers to pull your changes into theirs (you more or less ask them to use a git pull from your repository)" ([Stack Overflow](https://stackoverflow.com/questions/44669519/difference-between-git-pull-and-git-request-pull))
    - Once you issue a pull request, "the person or team reviewing your changes may have questions or comments. Perhaps the coding style doesn't match project guidelines, the change is missing unit tests, or maybe everything looks great and props are in order" ([Understanding the GitHub flow](https://guides.github.com/introduction/flow/))
    - We will devote more time to understanding and doing "pull requests" later


### Fork and pull

<!--
RESOURCES

- https://guides.github.com/introduction/git-handbook/
- https://guides.github.com/activities/forking/
-->

What is a **fork**?

- A fork is a copy of a repository that is associated with an individual's personal account
- The individual has full control of their fork (read, write, administrator)

Why use forks?

- For projects with many contributors, it can become overwhelming to manage the project and to manage individual permissions using the "shared repository" model

<br>
[![](https://dab1nmslvvntp.cloudfront.net/wp-content/uploads/2016/02/14550049531.jpg)](https://www.sitepoint.com/quick-tip-synch-a-github-fork-via-the-command-line/)

*Credit: [Shaumik Daityari](https://www.sitepoint.com/quick-tip-synch-a-github-fork-via-the-command-line/)*

<br>

Overview of "fork and pull" work flow:

- Create a fork repository (copy of project repository associated with your personal account) of the `central_repo` repository
    - Let's call the forked repository `your_fork`
    - Initially, `your_fork` repository only exists on GitHub
- `clone` the `your_fork` repository to your local machine
- On the local "working directory," make changes to files
- When you are happy with changes you have made:
    - `add` changes to index/staging area
    - `commit` changes to local `your_fork` repository 
    - `push` changes to remote `your_fork` repository
- Issue a "pull request" asking that the changes you have made to remote `your_fork` repository be incorporated to the main `central_repo` repository    



# Command line

## Shell/command line vs. graphical user interface (GUI)

What is a **shell**?

- "A shell is a terminal application used to interface with an operating system through written commands" ([Git Bash tutorial](https://www.atlassian.com/git/tutorials/git-bash))
- "The shell is a program on your computer whose job is to run other programs. Pseudo-synonyms are 'terminal', 'command line', and 'console.'" ([Happy Git and GitHub for the useR](https://happygitwithr.com/shell.html) by Jenny Bryan)
- In this course, we will usually use the term "command line" rather than "shell"
- In the command line, you issue commands one line at a time
- Most programmers use the command line rather than a graphical user interface (GUI) to accomplish tasks

What is **graphical user interface (GUI)**?

- A graphical user interface is an interface for using a program that includes graphical elements such as windows, icons, and buttons that the user can click on using the mouse
- For example, "RStudio" has GUI capabilities in that it has windows and you can perform operations using point-and-click (however, RStudio also has command line capabilities)
- RStudio also includes a GUI interface for performing Git operations
- There are many other GUI software packages for performing GIT operations
    - Popular tools include "GitHub Desktop," "GitKraken," and "SmartGit"
    - See [GUI Clients](https://git-scm.com/downloads/guis)

In this course, we will perform Git operations solely using the command line. Why?

- Learning Git from the command line will give you a deeper understanding of how Git and GitHub work
    - I have found that performing Git operations using a GUI did nothing to help me overcome my feelings of anxiety/intimidation about Git
    - As soon as I started doing stuff on the command line, I started feeling less intimidated
- After you start feeling more comfortable with the command line, using the command line makes you _much_ more efficient than using a GUI
- Learning the command line takes time and does feel intimidating
    - So we will devote substantial time in-class and during problem sets to learning/practicing the command line

We will use the Unix shell called "Bash" to perform Git operations:

- Some background on "Bash"
    - Unix is an operating system developed by AT&T Bell Labs in the late 1960s
    - The "Unix shell" is a command line program for issuing commands to "Unix-like" operating systems ([Unix Shell](https://en.wikipedia.org/wiki/Unix_shell))
        - Unix-like operating systems include macOS and Linux, but not Windows
        - The first Unix shell was the "Thompson shell" originally written by Ken Thompson at Bell Labs in 1971
    - The Bourne shell was a Unix shell programming language written by Stephen Bourne at Bell Labs in 1979
    - The "Bourne Again Shell" - commonly referred to as "Bash" was "written by Brian Fox for the GNU Project as a free software replacement for the Bourne shell," and first released in 1989
- Relationship between Git and Bash
    - "At its core, Git is a set of command line utility programs that are designed to execute on a Unix style command-line environment" ([GIT Bash](https://www.atlassian.com/git/tutorials/git-bash))
- Mac users
    - "Terminal" is the application that enables you to control your Mac using a command line prompt
    - Terminal runs the Bash shell programming language
    - Therefore, Mac users use "Terminal" to perform Git operations and the commands to perform Git operations utilize the Bash programming language
- Windows users
    - Windows is not a "Unix-like" operating system. Therefore, Bash is not the default command line interface
    - In order for Windows users to use Bash to perform Git operations, you must install the Git Bash program, which is installed as part of "git for Windows" ([install here](https://gitforwindows.org/))
- Because Mac "Terminal" program and the Windows "Git Bash" program both use the Bash command line program, performing Git operations using the command line will be _exactly the same_ for both Mac and Windows users!!!

### Command-line bullshittery

<br>

> "What is wonderful about doing applied computer science research in the modern era is that there are thousands of pieces of free software and other computer-based tools that researchers can leverage to create their research software. With the right set of tools, one can be 10x or even 100x more productive than peers who don't know how to set up those tools."

> "But this power comes at a great cost: __*It takes a tremendous amount of command-line bullshittery to install, set up, and configure all of this wonderful free software*__. What I mean by command-line bullshittery is dealing with all of the arcane, obscure, strange bullshit of the command-line paradigm that most of these free tools are built upon....So perhaps what is more important to a researcher than programming ability is adeptness at dealing with command-line bullshittery, since that enables one to become 10x or even 100x more productive than peers by finding, installing, configuring, customizing, and remixing the appropriate pieces of free software."

_[Helping my students overcome __command-line bullshittery__](http://www.pgbovine.net/command-line-bullshittery.htm) by Philip J. Guo_

<br>

## Basic (Bash) commands line commands

### logistics for running `Bash` code in .Rmd code chunks [skip]

Checking that RMarkdown can run `Bash` commands [code not run]:

```r
names(knitr::knit_engines$get())
#knitr::knit_engines$get("bash")

# should exist
Sys.which('bash')
Sys.which('python')

#path of where executables are run
Sys.getenv("PATH")
Sys.getenv("HOME")

#if path to an executable must be added to PATH
  #old_path <- Sys.getenv("PATH")
  #old_path
  #Sys.setenv(PATH = paste(old_path, "C:\\Users\\ozanj\\AppData\\Local\\Programs\\Python\\Python38", sep = ";"))
  #Sys.getenv("PATH")
```

Show "home" directory for code chunks

```r
Sys.getenv("HOME")
```

```
## [1] "C:\\Users\\ozanj"
```
Show "home" directory for `bash` code chunks

```bash
cd ~
pwd
```

```
## /c/Users/ozanj
```

note: home directory for r code chunks run in R might be different

```r
setwd("~")
getwd()
```

```
## [1] "C:/Users/ozanj/Documents"
```


### Bash syntax

We can run Bash code instead of R code by replacing `{r}` with `{bash}` at top of chunk.

- Note that the default working directory when you run a code chunk in a .Rmd file is the directory where the .Rmd file is saved
    - This is true for an R code chunk, a Bash code chunk, or any other programming language
    - If you change working directories within a code chunk, the working directory reverts back to where the .Rmd file is saved after the code chunk finishes running
    

```bash
pwd
ls
```

```
## /c/Users/ozanj/Documents/rclass2/lectures/github
## git_lecture.Rmd
## git_lecture.html
## git_lecture.md
## github_lecture.Rmd
## github_lecture.html
## github_lecture.md
## render_toc.R
## text
```

We can see the help file for any Bash command by typing:

- `command_name --help` (Windows) or `man command_name` (Mac)
- For example:


```bash
ls --help
man ls
```

Let's learn a bit about Bash command syntax.

<!--
RESOURCES TO CREATE SECTION

- http://www.compciv.org/topics/bash/command-structure/
- https://www.educative.io/blog/bash-shell-command-cheat-sheet
-->

The Bash command `ls` lists the contents (e.g., files, folders) of a directory. A "directory" is another word for "folder." In Terminal/Git Bash, try typing `ls` and then hit `ENTER` key. 

The `pwd` command shows the filepath of the directory you are currently in, that is the current working directory. In Terminal/Git Bash, try typing `pwd` and then hit `ENTER` key.

Note that you can also run Bash code from within an R code chunk of a .Rmd file. First, let's run some simple R commands from within an R code chunk:


```r
library(tidyverse)
mpg %>% head(5)
```

```
## # A tibble: 5 x 11
##   manufacturer model displ  year   cyl trans      drv     cty   hwy fl    class 
##   <chr>        <chr> <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr> 
## 1 audi         a4      1.8  1999     4 auto(l5)   f        18    29 p     compa~
## 2 audi         a4      1.8  1999     4 manual(m5) f        21    29 p     compa~
## 3 audi         a4      2    2008     4 manual(m6) f        20    31 p     compa~
## 4 audi         a4      2    2008     4 auto(av)   f        21    30 p     compa~
## 5 audi         a4      2.8  1999     6 auto(l5)   f        16    26 p     compa~
```


Syntax of `ls` command:

- `ls [option(s)] [file(s)]`
- The bracketed `[option(s)]` and `[file(s)]` means they are optional and you do not need to specify these
- Options in the `ls` command
    - In the help file for `ls` we see that most options can be specified using `-` or `--`
    - For example, `-a` and `--all` are two different ways to specify the option "do not ignore entries starting with `.`"
    - For the most part, `--` is the way to specify the long name version of an option and `-` is the way to specify the short name version. For more see [blog discussion](https://askubuntu.com/questions/813303/whats-the-difference-between-one-hyphen-and-two-hyphens-in-a-command).
    
**Example**: Using `ls` command (run in code chunk and run on command line)

- Without options:

```bash
pwd
ls
```

```
## /c/Users/ozanj/Documents/rclass2/lectures/github
## git_lecture.Rmd
## git_lecture.html
## git_lecture.md
## github_lecture.Rmd
## github_lecture.html
## github_lecture.md
## render_toc.R
## text
```

- Using `-a` to include entries that start with `.`:

```bash
pwd
ls -a
```

```
## /c/Users/ozanj/Documents/rclass2/lectures/github
## .
## ..
## git_lecture.Rmd
## git_lecture.html
## git_lecture.md
## github_lecture.Rmd
## github_lecture.html
## github_lecture.md
## render_toc.R
## text
```

- Using `--all` to include entries that start with `.`:

```bash
pwd
ls --all
```

### Changing directories

__`cd` command__: Changes the current directory

- Syntax
    - `cd [option(s)] directory_name`
- Example: Change current directory to the `lectures` directory
    - `cd lectures`
- In Bash, separate sub-folders using `/` rather than `\` [even if you are using a PC!]
- __Absolute__ vs. __relative__ filepaths
    - Can specify `directory_name` using __absolute__ or __relative__ filepaths
    - __Absolute__ filepath: the complete filepath relative to the "root" directory
        - Example:
            - `cd "/c/Users/ozanj/documents/rclass2/lectures"`
    - __Relative__ filepath: filepath relative to the current directory
        - Example [starting from working directory `rclass2`]:
            - `cd lectures`
            - `cd lectures/github`
    - By default, `cd` command assumes you are using a __relative__ filepath
- `../` or `..` -- move up one directory
    - Example [assume working directory is `"/c/Users/ozanj/documents/rclass2/lectures"`]:
        - `cd ..` -- move up one directory to `rclass2`
        - `cd ../problem_sets` -- move up one directory to `rclass2` and then change to `problem_sets` directory
- `./` or `.` -- current directory
    - Example [assume working directory is `"/c/Users/ozanj/documents/rclass2/lectures"`]:
        - `cd .` -- doesn't change current working directory
        - `cd ./` -- doesn't change current working directory
        - `cd ./ggplot` -- changes to directory `lectures/ggplot`
            - Same as `cd ggplot`
- `cd` [by itself] or `cd ~` changes to your "home directory"

**Example**: Using `cd` command

- _Can run these commands in .Rmd code chunk or paste them to Terminal/Git Bash command line_
- _**Note**: When running from .Rmd code chunk the working directory is `rclass2/lectures/github`_

- Move up one directory level and then show file path and list contents of directory:

```bash
pwd
cd ../
pwd
ls
```

```
## /c/Users/ozanj/Documents/rclass2/lectures/github
## /c/Users/ozanj/Documents/rclass2/lectures
## _style
## apa.csl
## ggplot
## github
## rclass2_bib.bib
```

- Move up two directory levels and then show file path and list contents of directory:

```bash
pwd
cd ../../
pwd
ls
```

```
## /c/Users/ozanj/Documents/rclass2/lectures/github
## /c/Users/ozanj/Documents/rclass2
## README.md
## _config.yml
## _data
## _gitadmin
## _layouts
## _resources
## _student_repositories
## _working
## lectures
## problem_sets
## rclass2.Rproj
## syllabus
```

- Move up two directory levels and then show file path and list contents of directory, including entries that begin with `.`:

```bash
pwd
cd ../../
pwd
ls -a
```

```
## /c/Users/ozanj/Documents/rclass2/lectures/github
## /c/Users/ozanj/Documents/rclass2
## .
## ..
## .Rhistory
## .Rproj.user
## .git
## .gitignore
## README.md
## _config.yml
## _data
## _gitadmin
## _layouts
## _resources
## _student_repositories
## _working
## lectures
## problem_sets
## rclass2.Rproj
## syllabus
```

- Move up one directory, then change to `ggplot` directory:

```bash
pwd

cd ../
pwd

cd ggplot
pwd

ls
```

```
## /c/Users/ozanj/Documents/rclass2/lectures/github
## /c/Users/ozanj/Documents/rclass2/lectures
## /c/Users/ozanj/Documents/rclass2/lectures/ggplot
## ggplot_lecture.Rmd
## ggplot_lecture.html
## ggplot_lecture.md
```

### Creating/deleting directories

__`mkdir` command__: Makes a directory

- Syntax
    - `mkdir [option(s)] directory_name(s)`
- Common option
    - `-p` -- no error if existing, make parent directories as needed

**Example**: Using `mkdir` command

- Make new directory:

```bash
cd ../../../ 
pwd
mkdir mkdir_test
```

- Move to new directory and create sub-folders:

```bash
cd ../../../
  
cd mkdir_test

mkdir folder_a folder_b folder_c
ls
```

__`rm` command__: Removes a file or directory

- Syntax
    - `rm [option(s)] file/directory_name(s)`
- Common options
    - `-f` -- force remove
        - `rm -f some_file.txt`
    - `-r` -- delete directory (default is deleting a file)
        - `rm -r some_directory`
    - `-rf` -- force remove directory
        - `rm -rf some_directory`

**Example**: Using `rm` command

- Remove directory named `folder_a`:

```bash
cd ../../../
  
cd mkdir_test

rm -rf folder_a
ls
```


### Other commands

__`touch` command__: Creates a file

- `touch file_name(s)`

__`cat` command__: Outputs content of a file

- `cat file_name(s)`

__`cp` command__: Copies files

- `cp file1 file2` –- copy file1 to file2
- `cp -r dir1 dir2` -– copy dir1 to dir2; create dir2 if it doesn't exist

__`mv` command__: Renames or moves files

- `mv file1 file2` -- rename file1 to file2
- `mv file/directory_name(s) directory_name` -- if last argument provided is a directory, move all previous files and/or directories into the destination directory
  - `mv file1 dir2` -- move file1 into dir2
  - `mv dir1 dir2` -- move dir1 into dir2
  - `mv dir1/file1 dir2 dir3` -- move file1 (originally located inside dir1) and dir2 into dir3

# Basic Git tasks


## Git commands

Git command "cheat sheets":

- https://github.github.com/training-kit/downloads/github-git-cheat-sheet.pdf
- https://www.jrebel.com/blog/git-cheat-sheet

When performing git operations on command line, all commands begin with `git`, for example:

- `git init`
- `git clone url_of_remote_repository`
- `git status`

For an overview of git command syntax and a list of common git commands, type this in command line:

```bash
git --help
```

To see the help file for a particular git command (e.g., `add`, `commit`, `clone`), type `git command_name --help`. For example:

```bash
git add --help

# or this:
# git help add
```

Basic/essential git commands:

- __Create a repository__
    - `git init`
        - "Initializes a brand new Git repository and begins tracking an existing directory. It adds a hidden subfolder [named `.git`] within the existing directory that houses the internal data structure required for version control" ([Git Handbook](https://guides.github.com/introduction/git-handbook/))
    - `git clone url_of_remote_repository`
        - "Creates a local copy of a project that already exists remotely. The clone includes all the project’s files, history, and branches" ([Git Handbook](https://guides.github.com/introduction/git-handbook/))
- __Make a change__
    - `git add file_name(s)`
        - Add file(s) from local working directory to staging area/index
        - Note: You must "stage" changes to a file before you `commit` them to your local repository
    - `git commit -m "commit message"`
        - All changes to files that have been staged [previous step] are committed to the local repository
        - Each commit is a snapshot of all files in your repository
        - Note: `-m` is an option to the `git commit` command, which specifies that you will add a brief description about changes you are committing
- __Observe your repository__
    - `git status`
        - "Shows the status of changes as untracked, modified, or staged" ([Git Handbook](https://guides.github.com/introduction/git-handbook/))
- __Synchronize with remote repository__
    - `git push`
        - "Updates the remote repository with any commits made locally" ([Git Handbook](https://guides.github.com/introduction/git-handbook/))
    - `git pull`
        - Updates the local repository with any commits from the remote repository


## Creating and cloning repositories

Basic stuff you will do all the time:

- `clone` an existing remote repository from GitHub to your local machine
    - For example, clone the repository for this class -- named `student_lastname` (e.g., `student_jaquette`) -- to your local machine
- Create a new git repository on your local machine and add to GitHub
    - For example, you might want to create the repository `problem_set_1` for all files related to the first problem set

### Clone an existing repository to your local machine

What we will do:

- Go to a remote repository stored on GitHub.com
    - We will be downloading the remote repository called [downloadipeds](https://github.com/btskinner/downloadipeds)
- Copy to our clipboard the URL that enables us to `clone` this repository to our local machine
- On Git Bash command line:
    - Change directories to folder we want repository to be downloaded to
        - Note: We don't have to create a new directory (e.g., directory named `documents/downloadipeds`) prior to cloning. 
        - When we clone from GitHub, the repository will be downloaded in a folder named `downloadipeds`
    - Use `git clone` command to clone repository


Click on link of remote repository: [downloadipeds](https://github.com/btskinner/downloadipeds)

- This repository, created by [Ben Skinner](https://github.com/btskinner), contains a script to "batch download" files from the [Integrated Postsecondary Data System (IPEDS)](https://nces.ed.gov/ipeds/), which contains data on U.S. colleges and universities
- Click on "Clone or download"
    - We will be "cloning" rather than the "open in desktop" or "Download ZIP" options
        - Essentially, we will get the url of the remote git repository and then paste this URL into the Git Bash command line
    - Clone with SSH vs. HTTPs?
        - These are two different ways to authenticate that you are you
        - If you haven't set up SSH, then choose HTTPs
    - Copy the url to your clipboard:
        - HTTPs URL will be: `https://github.com/btskinner/downloadipeds.git`
        - SSH URL will be: `git@github.com:btskinner/downloadipeds.git`


Below, I show the Bash code, but better to run this code in command line (one line at a time) than run in code chunk:


```bash
# CHANGE TO DESIRED DIRECTORY

  cd ~ # change directories to home directory
  
  #cd documents # change to "documents" [if necessary]
  
  ls # list files in directory
  
  # Note: we don't have to create a new directory (e.g., directory named `documents/downloadipeds`) prior to cloning. 
  # When we clone from github, the repository will be downloaded in a folder named `downloadipeds`

# CLONE REMOTE REPOSITORY

  # clone with https
  git clone https://github.com/btskinner/downloadipeds.git
  
  # OR clone with ssh
  git clone git@github.com:btskinner/downloadipeds.git
  
# INVESTIGATE REPOSITORY WE JUST CLONED

  cd downloadipeds
  
  #list files
  ls
  ls -a
  
  git status
```

<br>

__What we just did:__


[![](https://www.w3docs.com/uploads/media/default/0001/03/3f26b30cc1dbda3424ceef3ab4977149906a0c58.png)](https://www.w3docs.com/learn-git/git-clone.html)

*Credit: [W3 docs, Git clone](https://www.w3docs.com/learn-git/git-clone.html)*

<br>

<details><summary>Optional: Student task</summary>

**Student task: Clone repository for this course to desired directory on your local machine**

- Go to URL for the github organization [Rucla-ed](https://github.com/Rucla-ed)
- Create your own repository and name it `student_yourlastname` (e.g., `student_jaquette`) (NOTE: You need access to Rucla-ed org)
- Follow same steps as we did for cloning `downloadipeds`
    - Note: Before cloning, make sure you change directories to directory where you want to save files for this class
    - You will be using this directory `student_yourlastname` for the rest of the quarter


```bash
# change directories to home directory
cd ~ 

# change to "documents" [if necessary]
cd documents

# show filepath of current working directory
pwd 

# list files in current working directory
#ls

# clone git repository that is on github.com
#git clone https://github.com/Rucla-ed/student_jaquette.git # HTTPs authentication
git clone git@github.com:Rucla-ed/student_jaquette.git # SSH authentication

cd student_jaquette
ls
```
</details>

### Create new repository on GitHub and clone to your local machine

The repository you clone to your local machine can also be a new repository that you create:

- Create a new repository on [GitHub](https://github.com/new)
- Make sure to check the `Initialize this repository with a README` option
- You will then be able to clone your new repository to your local machine as described in the previous section

### Create new git repository on your local machine and add to GitHub

<!--
To create this example, can draw from both of these two tutorials:

- https://www.codecademy.com/articles/f1-u3-git-setup
- https://guides.github.com/introduction/git-handbook/
-->

Alternatively, you can create a new git repository on your local machine, and then connect it to the remote on GitHub.

First, create the remote repository:

- Create a new repository on [GitHub](https://github.com/new), call it `gitr_practice` [not required to use this name]
- Do **not** check the `Initialize this repository with a README` option
- After creation, you will be able to see the HTTPs/SSH URL of your new repository. Save this URL for later.

Then, in Terminal/Git Bash on your local machine:

- Create a new directory
- Change working directory to this new directory
- Turn this directory into a Git repository
- Within the "local working directory," create/change one or more files
- `add` changes to file(s) from the "local working directory" to the "staging area"/"index"
- `commit` all staged changes to the "local repository"
- Connect this local git repository to a remote git repository using `git remote add` command. To add a new remote:
  - `git remote add remote_name remote_url`
    - `remote_name`: Name we choose to call our remote repository, conventionally `origin`
    - `remote_url`: HTTPs/SSH URL of remote repository
  - Example: `git remote add origin https://github.com/ozanj/gitr_practice.git`
- Push changes to specified remote repository and branch using `git push` command with option `--set-upstream`:
  - `git push --set-upstream remote_name branch_name`
  - Example: `git push --set-upstream origin master`
    - This sets our local git repository to track from our remote repository's master branch

Below, I show the Bash code, but better to run this code in command line (one line at a time) than run in code chunk:


```bash
# CREATING AND CHANGING DIRECTORIES

  cd ~ # change directories to home directory
  
  #cd documents # change to "documents" [if necessary]
  
  ls # list files in directory
  
  # make new directory that will be our git repository
    # rm -rf gitr_practice # remove if it exists
  mkdir gitr_practice
  
  cd gitr_practice # move to new directory
  
  ls -a # show all files in directory

# INITIALIZING GIT REPOSITORY

  # turn the current, empty directory into a fresh Git repository
  git init
  
  ls -a # show all files in directory
  
# CHANGING FILES IN WORKING DIRECTORY
  
  # create a new README file with some sample text
  echo "Hello. I thought we would be learning R this quarter" >> README.txt
  
  # view the file README.txt
  cat README.txt
  
  # create a simple R script
  echo "library(tidyverse)" >> simple_script.r
  echo "mpg %>% head(5)" >> simple_script.r # add another line to simple_script.r
  
  cat simple_script.r # show contents of file simple_script.r

# STAGE AND COMMIT FILES TO LOCAL REPOSITORY

  # check status of git repository
  git status 
  
  # add README.txt from working directory to staging area (will now become a file that is "tracked" by git)
  git add README.txt
  
  # add simple_script.r from working directory to staging area (will now become a file that is "tracked" by git)
  git add simple_script.r
  
  # check status
  git status
  
  # commit changes to local repository
  git commit -m "Initial commit, README.txt simple_script.r"
  
  git status
  
# CONNECT AND PUSH TO REMOTE REPOSITORY
  
  # provide the path for the repository you created on GitHub in the first step
  #git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
  git remote add origin https://github.com/ozanj/gitr_practice.git

  # push changes to GitHub
  git push --set-upstream origin master
```

<br>

__What we just did:__

[![](https://miro.medium.com/max/686/1*diRLm1S5hkVoh5qeArND0Q.png)](https://medium.com/@lucasmaurer/git-gud-the-working-tree-staging-area-and-local-repo-a1f0f4822018)

*Credit: Lucas Maurer, medium.com*

# Git: Under the hood

## .git/ directory

<br>
Every git repository that is created using `git init` contains a **`.git/` directory** that "contains all the informations needed for git to work" (From [Git series 1/3: Understanding git for real by exploring the .git directory](https://www.daolf.com/posts/git-series-part-1/)):


```bash
# Initialize a new git repository in `my_git_repo` directory
cd my_git_repo
git init

ls -al
```

```
## Initialized empty Git repository in C:/Users/ozanj/my_git_repo/.git/
## total 16
## drwxr-xr-x 1 ozanj 197121 0 Apr  5 22:38 .
## drwxr-xr-x 1 ozanj 197121 0 Apr  5 22:38 ..
## drwxr-xr-x 1 ozanj 197121 0 Apr  5 22:38 .git
```

<br>
What's inside the **`.git/` directory**?


```bash
# List out the contents of the .git/ directory (in tree form)
find .git -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
```

```
## .git
## |____config
## |____description
## |____HEAD
## |____hooks
## | |____applypatch-msg.sample
## | |____commit-msg.sample
## | |____fsmonitor-watchman.sample
## | |____post-update.sample
## | |____pre-applypatch.sample
## | |____pre-commit.sample
## | |____pre-merge-commit.sample
## | |____pre-push.sample
## | |____pre-rebase.sample
## | |____pre-receive.sample
## | |____prepare-commit-msg.sample
## | |____update.sample
## |____info
## | |____exclude
## |____objects
## | |____info
## | |____pack
## |____refs
## | |____heads
## | |____tags
```

We will be focusing on:

- `objects/`: Directory containing all git objects
- `HEAD`: Reference to the latest commit of the current branch
- `refs/`: Directory containing the hash ID of commit referred to by `HEAD`

We'll get into git objects starting in the next section, and see an example of `HEAD` and `refs/` in a [later section](#head-and-refs).

## Git objects

What is a **git object**?

- "A git repository is actually just a collection of objects, each identified with their own hash." (From [Deep dive into git: git Objects](https://aboullaite.me/deep-dive-into-git/))
  - A "hash" can be thought of as an unique ID that points to the git object
  - "Git is a simple key-value data store. You put a value into the repository and get a key by which this value can be accessed." (From [Becoming a Git pro. Part 1: internal Git architecture](https://indepth.dev/becoming-a-git-pro-part-1-internal-git-architecture/))
    - Key = Hash
    - Value = Git object
- Git objects are stored inside the `.git/objects` directory
  - The first 2 characters of its hash will be the name of the sub-directory within `.git/objects` that it is located in
  - The rest of the hash will be the git object filename
- Use the `git cat-file` command can be used to view information about a git object whose hash you specify
- Use the `git hash-object` to compute (show) the hash for a git "blob" object based on the name of associated file

<br>
**`git cat-file`**: Provide content or type and size information for repository objects

- Help: `git cat-file -help`
- Syntax: `git cat-file [<option(s)>] <object>`
- Options:
  - `-p`: Pretty-print the contents of `<object>` based on its type
  - `-t`: Instead of the content, show the object type identified by `<object>`
  - `-s`: Instead of the content, show the object size identified by `<object>`

<br>
There are 4 types of **git objects** (From [The Git Object Model](http://shafiul.github.io/gitbook/1_the_git_object_model.html))
  
- [Blob](#blob-object)
- [Tree](#tree-object)
- [Commit](#commit-object)
- [Tag](#tag-object)

### Blob object

A **blob** is generally a file which stores data

- For example, this could be an R script
- The file must be added to the _staging area_ (i.e., "index") in order for the blob object to be created
- The hash of the blob object can be seen in the `.git/objects` directory
  - The first 2 characters of the hash is the name of the sub-directory within `.git/objects`
  - The rest of the hash comes from the git object filename
  - But only the first 7 characters of the hash is required to uniquely identify it
- This hash can also be computed from the name of the file for which the blob is to be created by using the `git hash-object` command


```bash
# Create new R script
echo "library(tidyverse)" > create_dataset.R
echo "mpg %>% head(5)" >> create_dataset.R

# Add R script
git add create_dataset.R

# View .git/objects directory
find .git/objects -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
```

```
## warning: LF will be replaced by CRLF in create_dataset.R.
## The file will have its original line endings in your working directory
## |____objects
## | |____c1
## | | |____cff389562e8bc123e6691a60352fdf839df113
## | |____info
## | |____pack
```


<br>
**`git hash-object`**: Compute hash for a blob object from name of file

- Help: `git hash-object -help`
- Syntax: `git hash-object <file_name>`

We can use `git hash-object` to verify the hash for `create_dataset.R`:


```bash
# Generate blob object hash for R script
git hash-object create_dataset.R
```

```
## c1cff389562e8bc123e6691a60352fdf839df113
```


<br>
<details><summary>**Example**: Using `git cat-file` to view blob object content</summary>


```bash
# View content of create_dataset.R
git cat-file -p c1cff38
```

```
## library(tidyverse)
## mpg %>% head(5)
```
</details>

<br>
<details><summary>**Example**: Using `git cat-file` to view blob object type</summary>


```bash
# View content of create_dataset.R
git cat-file -t c1cff38
```

```
## blob
```
</details>

<br>
<details><summary>**Example**: Using `git cat-file` to view blob object size</summary>


```bash
# View content of create_dataset.R
git cat-file -s c1cff38
```

```
## 35
```
</details>
<br>

### Tree object

A **tree** is a directory that contains references to blobs (_files_) or other trees (_sub-directories_)

- Any sub-directories created inside the git repository is a tree object
  - It contains references to any blobs (_files_) or additional trees (_sub-directories_) within it
- The root directory of the git repository is also a tree itself, and contains references to all its content at the point of commit (like a "snapshot")
- A commit must be made in order for the tree object(s) to be created


```bash
# Create a sub-directory 
rm -rf notes
mkdir notes

# Add files to the sub-directory (since git doesn't track empty directories)
echo "This is my first set of notes." > notes/note_1.txt
echo "This is my second set of notes." > notes/note_2.txt

# Add new files
git add .

# View .git/objects directory
find .git/objects -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
```

```
## warning: LF will be replaced by CRLF in create_dataset.R.
## The file will have its original line endings in your working directory
## warning: LF will be replaced by CRLF in notes/note_1.txt.
## The file will have its original line endings in your working directory
## warning: LF will be replaced by CRLF in notes/note_2.txt.
## The file will have its original line endings in your working directory
## |____objects
## | |____47
## | | |____6fb98775843929ca6c55b16b04752d973b3d2a
## | |____61
## | | |____08458417308ddc15d7390a2f8db50cf65ec399
## | |____c1
## | | |____cff389562e8bc123e6691a60352fdf839df113
## | |____info
## | |____pack
```

<br>
As seen, new blob objects are created for `note_1.txt` and `note_2.txt` since the files have been added (but tree objects will not be created until a commit has been made):


```bash
# View content of note_1.txt and note_2.txt
git cat-file -p 476fb98
git cat-file -p 6108458
```

```
## This is my second set of notes.
## This is my first set of notes.
```

<br>
After the files have been committed, tree objects will be created for any sub-directories as well as for the root directory of the repository:


```bash
# Make a commit
git commit -m "initial commit"

# View .git/objects directory
find .git/objects -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
```

```
## [master (root-commit) 05ae512] initial commit
##  3 files changed, 4 insertions(+)
##  create mode 100644 create_dataset.R
##  create mode 100644 notes/note_1.txt
##  create mode 100644 notes/note_2.txt
## |____objects
## | |____05
## | | |____ae5124198500eb6b068e51f014bb9cf3514af8
## | |____47
## | | |____6fb98775843929ca6c55b16b04752d973b3d2a
## | |____61
## | | |____08458417308ddc15d7390a2f8db50cf65ec399
## | |____6c
## | | |____f7bbf49af4f9fd5103cf9f0a3fa25226b12336
## | |____c1
## | | |____cff389562e8bc123e6691a60352fdf839df113
## | |____f5
## | | |____9085df29aed7826a89b23af3f67fc3ab96f643
## | |____info
## | |____pack
```

<br>
As we now see, the tree objects for the `my_git_repo/` root directory and `notes/` sub-directory exists, and another object has been created for the commit (_more info on that in [next section](#commit-object)_):


```bash
# View object type for my_git_repo/ and notes/ trees
git cat-file -t f59085d
git cat-file -t 6cf7bbf

# View object type for the commit
git cat-file -t $(git rev-parse --short HEAD)  # git rev-parse retrieves latest commit hash
```

```
## tree
## tree
## commit
```

<br>
The content of a tree object is a list of all blobs (_files_) and other trees (_sub-directories_) in the directory. Each list entry follows the format:

```
<permission_code> <object_type> <object_hash> <object_name>
```

- `<permission_code>`: Code indicating who has read/write access to the object
  - This is typically `100644` for blobs and `100755` or `040000` for trees
- `<object_type>`: Type of the object (i.e., blobs or trees)
- `<object_hash>`: Reference to the object (i.e., the hash)
- `<object_name>`: Name of the file or directory

<br>
<details><summary>**Example**: Using `git cat-file` to view tree object content for `my_git_repo/` root directory</summary>

First, show files in directory using `ls` command with options `al`

```bash
#show files in directory
ls -al
```

```
## total 17
## drwxr-xr-x 1 ozanj 197121  0 Apr  5 22:38 .
## drwxr-xr-x 1 ozanj 197121  0 Apr  5 22:38 ..
## drwxr-xr-x 1 ozanj 197121  0 Apr  5 22:38 .git
## -rw-r--r-- 1 ozanj 197121 35 Apr  5 22:38 create_dataset.R
## drwxr-xr-x 1 ozanj 197121  0 Apr  5 22:38 notes
```

Second, show contents of tree using `git cat-file`

```bash
#show files in directory
ls -al
echo ""

# View type and content of my_git_repo/ tree object
git cat-file -t f59085d  # type
git cat-file -p f59085d  # content
```

```
## total 17
## drwxr-xr-x 1 ozanj 197121  0 Apr  5 22:38 .
## drwxr-xr-x 1 ozanj 197121  0 Apr  5 22:38 ..
## drwxr-xr-x 1 ozanj 197121  0 Apr  5 22:38 .git
## -rw-r--r-- 1 ozanj 197121 35 Apr  5 22:38 create_dataset.R
## drwxr-xr-x 1 ozanj 197121  0 Apr  5 22:38 notes
## 
## tree
## 100644 blob c1cff389562e8bc123e6691a60352fdf839df113	create_dataset.R
## 040000 tree 6cf7bbf49af4f9fd5103cf9f0a3fa25226b12336	notes
```

- contents of tree object are essentially a list of files in the directory

</details>

<br>
<details><summary>**Example**: Using `git cat-file` to view tree object content for `notes/` sub-directory</summary>


```bash
# View type and content of notes/ tree object
git cat-file -t 6cf7bbf  # type
git cat-file -p 6cf7bbf  # content
```

```
## tree
## 100644 blob 6108458417308ddc15d7390a2f8db50cf65ec399	note_1.txt
## 100644 blob 476fb98775843929ca6c55b16b04752d973b3d2a	note_2.txt
```
</details>
<br>

### Commit object

A **commit** object is created after a commit is made that contains information about the commit:

```
tree <tree_hash>
parent <commit_hash>
author <username> <email> <time>
committer <username> <email> <time>

<commit_message>
```

- `tree`: Reference to the root directory tree object (i.e., "snapshot" of repository at the point of commit)
- `parent`: Reference to the parent commit
- Other information about the commit (e.g., `author`, `committer`, `commit_message`)


<br>
All commits except for the initial commit will contain a reference to its `parent` commit. So let's create a second commit:


```bash
# Modify R script
echo "df <- mpg %>% filter(year == 2008)" >> create_dataset.R

# Add R script
git add create_dataset.R

# Make another commit
git commit -m "second commit"

# View .git/objects directory
find .git/objects -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
```

```
## warning: LF will be replaced by CRLF in create_dataset.R.
## The file will have its original line endings in your working directory
## [master 1f4c3b5] second commit
##  1 file changed, 1 insertion(+)
## |____objects
## | |____05
## | | |____ae5124198500eb6b068e51f014bb9cf3514af8
## | |____1f
## | | |____4c3b5906610eeaadb7a8f2a704fc355279b8a8
## | |____47
## | | |____6fb98775843929ca6c55b16b04752d973b3d2a
## | |____49
## | | |____0ec1c138021b8d5c196c26a2a7b3de69afc2d1
## | |____52
## | | |____4db779f0a3e3b3b353b522285c7da4830e21f1
## | |____61
## | | |____08458417308ddc15d7390a2f8db50cf65ec399
## | |____6c
## | | |____f7bbf49af4f9fd5103cf9f0a3fa25226b12336
## | |____c1
## | | |____cff389562e8bc123e6691a60352fdf839df113
## | |____f5
## | | |____9085df29aed7826a89b23af3f67fc3ab96f643
## | |____info
## | |____pack
```


<br>
<details><summary>**Example**: Using `git cat-file` to view commit object content for first commit</summary>

- _**Note**: The commit hash will be different each time we run this because it is dependent on the time_


```bash
# Retrieve commit hash for first commit
git rev-list HEAD | tail -n 1

# View content of the commit object
git cat-file -p $(git rev-list HEAD | tail -n 1)
```

```
## 05ae5124198500eb6b068e51f014bb9cf3514af8
## tree f59085df29aed7826a89b23af3f67fc3ab96f643
## author Ozan Jaquette <ozanj@ucla.edu> 1586151515 -0700
## committer Ozan Jaquette <ozanj@ucla.edu> 1586151515 -0700
## 
## initial commit
```
</details>

<br>
<details><summary>**Example**: Using `git cat-file` to view commit object content for second commit</summary>

- _**Note**: The commit hash will be different each time we run this because it is dependent on the time_


```bash
# Retrieve commit hash for lastest commit
git rev-parse HEAD

# View content of the commit object
git cat-file -p $(git rev-parse HEAD)
```

```
## 1f4c3b5906610eeaadb7a8f2a704fc355279b8a8
## tree 524db779f0a3e3b3b353b522285c7da4830e21f1
## parent 05ae5124198500eb6b068e51f014bb9cf3514af8
## author Ozan Jaquette <ozanj@ucla.edu> 1586151517 -0700
## committer Ozan Jaquette <ozanj@ucla.edu> 1586151517 -0700
## 
## second commit
```
</details>
<br>

### Tag object

A **tag** object is created after a tag is generated:

```
object <object_hash>
type <object_type>
tag <tag_name>
tagger <username> <email> <time>

<tag_message>
```

- `object`: Reference to the tagged object
- `type`: Object type of the tagged object (usually a `commit`)
- Other information about the tag (e.g., name of `tag`, `tagger`, `tag_message`)

Let's create a tag for the current commit:


```bash
# Create a tag
git tag -a v1 -m "version 1.0"

# View .git/objects directory
find .git/objects -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
```

```
## |____objects
## | |____05
## | | |____ae5124198500eb6b068e51f014bb9cf3514af8
## | |____1f
## | | |____4c3b5906610eeaadb7a8f2a704fc355279b8a8
## | |____47
## | | |____6fb98775843929ca6c55b16b04752d973b3d2a
## | |____49
## | | |____0ec1c138021b8d5c196c26a2a7b3de69afc2d1
## | |____52
## | | |____4db779f0a3e3b3b353b522285c7da4830e21f1
## | |____54
## | | |____e99fc14ca176ff1f9ab515913932ec25ec978b
## | |____61
## | | |____08458417308ddc15d7390a2f8db50cf65ec399
## | |____6c
## | | |____f7bbf49af4f9fd5103cf9f0a3fa25226b12336
## | |____c1
## | | |____cff389562e8bc123e6691a60352fdf839df113
## | |____f5
## | | |____9085df29aed7826a89b23af3f67fc3ab96f643
## | |____info
## | |____pack
```

<br>
<details><summary>**Example**: Using `git cat-file` to view tag object</summary>

```bash
# View content of the tag object
git cat-file -p $(git show-ref -s v1)  # retrieves hash for v1 tag
```

```
## object 1f4c3b5906610eeaadb7a8f2a704fc355279b8a8
## type commit
## tag v1
## tagger Ozan Jaquette <ozanj@ucla.edu> 1586151518 -0700
## 
## version 1.0
```


```bash
# The tagged object was the second commit
git log
```

```
## commit 1f4c3b5906610eeaadb7a8f2a704fc355279b8a8
## Author: Ozan Jaquette <ozanj@ucla.edu>
## Date:   Sun Apr 5 22:38:37 2020 -0700
## 
##     second commit
## 
## commit 05ae5124198500eb6b068e51f014bb9cf3514af8
## Author: Ozan Jaquette <ozanj@ucla.edu>
## Date:   Sun Apr 5 22:38:35 2020 -0700
## 
##     initial commit
```
</details>
<br>

## HEAD and refs/

The `HEAD` file is a pointer to your current (active) branch -- specifically, it points to the latest commit of that branch (whose hash ID is stored in the `refs/` directory). Especially when we get to working with multiple branches, the `HEAD` becomes important as it keeps track of which branch you are currently on.


If we output the contents of `HEAD`, we see it contains a reference to the _master_ branch:


```bash
# View content of HEAD
cat .git/HEAD
```

```
## ref: refs/heads/master
```

Following that reference, we can find the hash ID of the latest commit located inside the `refs/` directory:


```bash
# View content of refs/heads/master
cat .git/refs/heads/master
```

```
## 1f4c3b5906610eeaadb7a8f2a704fc355279b8a8
```

We can use `git log` to verify that this is the hash ID of the latest commit:


```bash
# View commit log
git log
```

```
## commit 1f4c3b5906610eeaadb7a8f2a704fc355279b8a8
## Author: Ozan Jaquette <ozanj@ucla.edu>
## Date:   Sun Apr 5 22:38:37 2020 -0700
## 
##     second commit
## 
## commit 05ae5124198500eb6b068e51f014bb9cf3514af8
## Author: Ozan Jaquette <ozanj@ucla.edu>
## Date:   Sun Apr 5 22:38:35 2020 -0700
## 
##     initial commit
```

## Full example


```bash
# Initialize a new git repository in `my_git_repo` directory
cd my_git_repo
git init
```

```
## Initialized empty Git repository in C:/Users/ozanj/my_git_repo/.git/
```


```bash
# Create new R script
echo "library(tidyverse)" > create_dataset.R
echo "mpg %>% head(5)" >> create_dataset.R

# R script initially starts off under `Untracked Files`
git status
```

```
## On branch master
## 
## No commits yet
## 
## Untracked files:
##   (use "git add <file>..." to include in what will be committed)
## 	create_dataset.R
## 
## nothing added to commit but untracked files present (use "git add" to track)
```


```bash
# Add R script
git add create_dataset.R

# R script moves to `Changes to be committed`
git status
```

```
## warning: LF will be replaced by CRLF in create_dataset.R.
## The file will have its original line endings in your working directory
## On branch master
## 
## No commits yet
## 
## Changes to be committed:
##   (use "git rm --cached <file>..." to unstage)
## 	new file:   create_dataset.R
```


```bash
# Once R script has been added, a blob object is created for it in the .git/objects directory
find .git/objects -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
```

```
## |____objects
## | |____c1
## | | |____cff389562e8bc123e6691a60352fdf839df113
## | |____info
## | |____pack
```


```bash
# We can use `git hash-object` to verify the hash of the blob object
git hash-object create_dataset.R
```

```
## c1cff389562e8bc123e6691a60352fdf839df113
```


```bash
# With this hash, we can view the content of create_dataset.R
git cat-file -p c1cff38
```

```
## library(tidyverse)
## mpg %>% head(5)
```


```bash
# Make a commit
git commit -m "add create_dataset.R"

# The R script is now no longer listed
git status
```

```
## [master (root-commit) 9ed32a5] add create_dataset.R
##  1 file changed, 2 insertions(+)
##  create mode 100644 create_dataset.R
## On branch master
## nothing to commit, working tree clean
```


```bash
# Check the commit history
git log
```

```
## commit 9ed32a54a04cce7741115286a4cc12645a43db4a
## Author: Ozan Jaquette <ozanj@ucla.edu>
## Date:   Sun Apr 5 22:38:41 2020 -0700
## 
##     add create_dataset.R
```


```bash
# Verify that `HEAD` is indeed pointing to the last commit made, which is our initial commit
cat .git/HEAD
cat .git/refs/heads/master
```

```
## ref: refs/heads/master
## 9ed32a54a04cce7741115286a4cc12645a43db4a
```


```bash
# Further modify R script, which is now a tracked file
echo "df <- mpg %>% filter(year == 2008)" >> create_dataset.R

# R script is now under `Changes not staged for commit`
git status
```

```
## On branch master
## Changes not staged for commit:
##   (use "git add <file>..." to update what will be committed)
##   (use "git restore <file>..." to discard changes in working directory)
## 	modified:   create_dataset.R
## 
## no changes added to commit (use "git add" and/or "git commit -a")
```


```bash
# View what new changes were made to R script
git diff
```

```
## warning: LF will be replaced by CRLF in create_dataset.R.
## The file will have its original line endings in your working directory
## diff --git a/create_dataset.R b/create_dataset.R
## index c1cff38..490ec1c 100644
## --- a/create_dataset.R
## +++ b/create_dataset.R
## @@ -1,2 +1,3 @@
##  library(tidyverse)
##  mpg %>% head(5)
## +df <- mpg %>% filter(year == 2008)
```


```bash
# Add new changes made to R script
git add create_dataset.R

# .git/objects directory now contains blob objects for both versions of R script
# It also contains objects for the commit and root directory tree
find .git/objects -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
```

```
## warning: LF will be replaced by CRLF in create_dataset.R.
## The file will have its original line endings in your working directory
## |____objects
## | |____49
## | | |____0ec1c138021b8d5c196c26a2a7b3de69afc2d1
## | |____96
## | | |____6cc780d5994bc8a4ed535484cd7f8268e8e874
## | |____9e
## | | |____d32a54a04cce7741115286a4cc12645a43db4a
## | |____c1
## | | |____cff389562e8bc123e6691a60352fdf839df113
## | |____info
## | |____pack
```


```bash
# We can use `git hash-object` to verify the hash for the new blob object
git hash-object create_dataset.R
```

```
## 490ec1c138021b8d5c196c26a2a7b3de69afc2d1
```


```bash
# With this hash, we can view the content of the modified create_dataset.R
git cat-file -p 490ec1c
```

```
## library(tidyverse)
## mpg %>% head(5)
## df <- mpg %>% filter(year == 2008)
```


```bash
# Make a commit
git commit -m "modify create_dataset.R"
```

```
## [master 5dea84c] modify create_dataset.R
##  1 file changed, 1 insertion(+)
```


```bash
# Check the commit history
git log
```

```
## commit 5dea84c6e76ed479db4fafc1f36b60fd23a428f0
## Author: Ozan Jaquette <ozanj@ucla.edu>
## Date:   Sun Apr 5 22:38:43 2020 -0700
## 
##     modify create_dataset.R
## 
## commit 9ed32a54a04cce7741115286a4cc12645a43db4a
## Author: Ozan Jaquette <ozanj@ucla.edu>
## Date:   Sun Apr 5 22:38:41 2020 -0700
## 
##     add create_dataset.R
```


```bash
# Verify that `HEAD` is pointing to the last commit made, which is now our second commit
cat .git/HEAD
cat .git/refs/heads/master
```

```
## ref: refs/heads/master
## 5dea84c6e76ed479db4fafc1f36b60fd23a428f0
```


```bash
# View content of commit object for second commit
git cat-file -p $(git rev-parse HEAD)
```

```
## tree 6de1187f46bbf4d76cafca7c0e5d3d61db6b5a53
## parent 9ed32a54a04cce7741115286a4cc12645a43db4a
## author Ozan Jaquette <ozanj@ucla.edu> 1586151523 -0700
## committer Ozan Jaquette <ozanj@ucla.edu> 1586151523 -0700
## 
## modify create_dataset.R
```


# Git commands: Observing your repository

Below are some common git commands you might use to observe your repository:

- [git status](#git-status)
- [git log](#git-log)
- [git diff](#git-diff)

## git status

**`git status`**: Shows the working tree status

- Help: `git status -help`
- Syntax: `git status [<option(s)>]`
    - Commonly used without any options, but see help file for possible options
- Output:
    - Information about the branch (e.g., which branch you are on, its status relative to the remote branch)
    - `Changes to be committed`
      - List of files that have been added to the _staging area_ using `git add`
      - These can be committed using `git commit`
      - The filenames will be in <span style="color: green;">green</span>
    - `Changes not staged for commit`
      - List of tracked files (i.e., files that have been added using `git add` before) that have since been changed (e.g., modified, deleted) in the _working directory_
      - These can be added to the _staging area_ using `git add`
      - The filenames will be in <span style="color: red;">red</span>
    - `Untracked files`
      - List of untracked files (i.e., new files that have never been added using `git add` before)
      - These can be added to the _staging area_ using `git add`
      - The filenames will be in <span style="color: red;">red</span> 

Below is a sample output of `git status`:

```
On branch master
Your branch is up-to-date with 'origin/master'.

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   clean_dataset.R

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   create_dataset.R

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	analyze_dataset.R
```

<br>
<details><summary>**Example**: Checking `git status` after creating a new file</summary>

- Imagine you have created a new file called `create_dataset.R` in your git repository
- You will initially see the file listed under `Untracked files`


```bash
# Create new R script
echo "library(tidyverse)" > create_dataset.R
echo "mpg %>% head(5)" >> create_dataset.R

git status
```

```
On branch master
Your branch is up-to-date with 'origin/master'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	create_dataset.R

nothing added to commit but untracked files present (use "git add" to track)
```
</details>

<br>
<details><summary>**Example**: Checking `git status` after adding a file</summary>

- After adding `create_dataset.R`, you will see it listed under `Changes to be committed`


```bash
# Add R script
git add create_dataset.R

git status
```

```
On branch master
Your branch is up-to-date with 'origin/master'.

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   create_dataset.R

```
</details>

<br>
<details><summary>**Example**: Checking `git status` after making a commit</summary>

- After making a commit, you will notice that the committed file(s) are no longer listed
- If your local repository is connected with a remote, you'll also see that it says your branch is ahead of the remote by 1 commit


```bash
# Make a commit
git commit -m "add create_dataset.R"

git status
```

```
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
```
</details>

<br>
<details><summary>**Example**: Checking `git status` after modifying a tracked file</summary>

- If you make further modifications to a file that's being tracked (i.e., a file that's been added before), you will see it listed under `Changes not staged for commit` (as compared to under `Untracked files` when it's never been tracked before)


```bash
# Modify create_dataset.R
echo "df <- mpg %>% filter(year == 2008)" >> create_dataset.R

git status
```

```
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   create_dataset.R

no changes added to commit (use "git add" and/or "git commit -a")
```
</details>
<br>

## git log

**`git log`**: Show commit logs

- Help: `git log -help`
- Syntax: `git log [<option(s)>]`
  - Commonly used without any options, but see help file for possible options
- Output: List of commits in reverse chronological order (i.e., newest first)
  - `commit <commit_hash>`: Each commit can be uniquely identified by their hash ID (SHA-1)
    - _**Note**: Only the first 7 characters of this hash is needed to uniquely identify it_
  - `Author: <username> <email>`: Username and email of the author of the commit
  - `Date: <commit_date>`: Date of the commit
  - `<commit_message>`: Commit message
- _**Note**: If the list of commits is long, you will be able to use your up and down arrow keys to scroll through the log. After you are done viewing, you can hit `q` to exit this read mode._
  
Below is a sample output of `git log`:

```
commit 2e525e4b1c40f6cffb78438285a00cd7eed54ae0 (HEAD -> master)
Author: username <email@example.com>
Date:   Thu Apr 2 23:53:30 2020 -0700

    second commit

commit 8c20a14b99d7a490580045176287b979c93d9cb5
Author: username <email@example.com>
Date:   Wed Apr 1 22:49:52 2020 -0700

    initial commit

```

<br>

## git diff

**`git diff`**: Show changes between files, commits, etc.

<!--
FROM HELP FILE:

Show changes between commits, commit and working tree, etc.

Show changes between the working tree and the index or a tree, changes between the index and a tree, changes between two trees, changes between two blob objects, or changes between two files on disk
-->

- Help: `git diff --help`
- Syntax:
  - `git diff [<file_name(s)>]`: Show changes made to unstaged files in _working directory_ compared to the "index"
    - In other words, these are the changes that would get added to the _staging area_ if you `git add` them
    - This only applies to tracked files (i.e., files listed under `Changes not staged for commit` when you check `git status`), since untracked files have no history in the "index" to compare against
    - If no `file_name(s)` specified, `git diff` shows changes made to all tracked, unstaged files
  - `git diff --cached [<file_name(s)>]`: Show changes made to added files in _staging area_ compared to the last commit
    - In other words, these are the changes that would be committed if you run `git commit` command
    - If no `file_name(s)` specified, `git diff --cached` shows changes made to all staged files (i.e., files listed under `Changes to be committed` when you check `git status`)
    - If this is the initial commit, then all staged changes are shown
  - `git diff <commit_hash> <commit_hash> [<file_name(s)>]`: Show changes between the two specified commits
    - If no `file_name(s)` specified, `git diff <commit_hash> <commit_hash>` shows changes between all files
- Output: Comparison results for each file being checked by `git diff`
  - Each output starts with `diff --git a/<file_name> b/<file_name>`, which indicates that two versions of `file_name` is being compared
  - This is followed by some information about whether the versions are previously tracked by Git (indicated by `index`) or if a new file is involved (as in the case of `git diff --cached` for an untracked, staged file -- see second example below)
  - The line-by-line comparison of the file begins after the part in the output that starts with `@@`
    - A `-` in front of a line indicates that the line has been removed in `b/<file_name>` as compared to `a/<file_name>`
    - A `+` in front of a line indicates that the line has been added in `b/<file_name>` as compared to `a/<file_name>`
  
Below is a sample output of `git diff`:

```
diff --git a/create_dataset.R b/create_dataset.R
index c1cff38..5ea84e9 100644
--- a/create_dataset.R
+++ b/create_dataset.R
@@ -1,2 +1,2 @@
 library(tidyverse)
-mpg %>% head(5)
+mpg %>% filter(year == 2008)
```

<br>
<details><summary>**Example**: Checking `git diff` for an untracked file</summary>

- Imagine you have created a new file called `create_dataset.R` in your git repository
- Because this file has never been added to "index" before, you will not see any ouput to `git diff`


```bash
# Create new R script
echo "library(tidyverse)" > create_dataset.R

git diff  # No output
```
</details>

<br>
<details><summary>**Example**: Checking `git diff` for a staged file</summary>

- After staging `create_dataset.R`, it will be added to the "index"
- `git diff --cached` can be used to view all staged changes


```bash
# Add R script
git add create_dataset.R

git diff --cached
```

```
diff --git a/create_dataset.R b/create_dataset.R
new file mode 100644
index 0000000..8b151a2
--- /dev/null
+++ b/create_dataset.R
@@ -0,0 +1 @@
+library(tidyverse)
```
</details>

<br>
<details><summary>**Example**: Checking `git diff` for a modified, tracked file</summary>

- If you make further modifications to a file that’s being tracked (i.e., a file that’s been added before), you can use `git diff` to see changes between the versions in the _working directory_ and the _staging area_


```bash
# Modify create_dataset.R
echo "mpg %>% head(5)" >> create_dataset.R

git diff
```

```
diff --git a/create_dataset.R b/create_dataset.R
index 8b151a2..c1cff38 100644
--- a/create_dataset.R
+++ b/create_dataset.R
@@ -1 +1,2 @@
 library(tidyverse)
+mpg %>% head(5)
```
</details>

<br>
<details><summary>**Example**: Checking `git diff` after committing changes</summary>

- Suppose you commit the staged changes (i.e., the line `library(tidyverse)` in `create_dataset.R`)
- Note that the output of `git diff` (i.e., comparing changes between the _working directory_ and "index") is the same as the previous example, when the changes were just staged and not yet committed


```bash
# Make a commit
git commit -m "add 1st line to create_dataset.R"

git diff
```

```
diff --git a/create_dataset.R b/create_dataset.R
index 8b151a2..c1cff38 100644
--- a/create_dataset.R
+++ b/create_dataset.R
@@ -1 +1,2 @@
 library(tidyverse)
+mpg %>% head(5)
```
</details>

<br>
<details><summary>**Example**: Checking `git diff` between commits</summary>

- Now suppose we add the new changes made to `create_dataset.R` in the _working directory_ (i.e., the line `mpg %>% head(5)`) and make a second commit


```bash
# Add create_dataset.R and make a commit
git add create_dataset.R
git commit -m "add 2nd line to create_dataset.R"

git log
```

```
commit aa89efba9adddf8547b3743ba81a421dd2a28881 (HEAD -> master)
Author: cyouh95 <25449416+cyouh95@users.noreply.github.com>
Date:   Sat Apr 4 03:20:15 2020 -0700

    add 2nd line to create_dataset.R

commit d5c6e0958fb173af04f7e2c5d5fd81457e8ffd0c
Author: cyouh95 <25449416+cyouh95@users.noreply.github.com>
Date:   Sat Apr 4 03:11:38 2020 -0700

    add 1st line to create_dataset.R
```

- We can use `git diff` to check the differences between the two commits by specifying their hash ID's
- As seen below, the line `mpg %>% head(5)` has been added between the two commits


```bash
git diff d5c6e09 aa89efb
```

```
diff --git a/create_dataset.R b/create_dataset.R
index 8b151a2..c1cff38 100644
--- a/create_dataset.R
+++ b/create_dataset.R
@@ -1 +1,2 @@
 library(tidyverse)
+mpg %>% head(5)
```

- Note that the order we specify the commit hash ID's in matters
- As seen below, if we specify the ID of second commit and then the first commit, the displayed differences show that the line `mpg %>% head(5)` has been removed between the two commits


```bash
git diff aa89efb d5c6e09
```

```
diff --git a/create_dataset.R b/create_dataset.R
index c1cff38..8b151a2 100644
--- a/create_dataset.R
+++ b/create_dataset.R
@@ -1,2 +1 @@
 library(tidyverse)
-mpg %>% head(5)
```
</details>
<br>


# Git commands: Undoing changes

Below are some common git commands you might use to undo changes:

- [git checkout](#git-checkout)
- [git reset](#git-reset)
- [git revert](#git-revert)

## git checkout

**`git checkout`**: Restore working tree files (or switch branches)

- Help: `git checkout -help`
- Syntax: `git checkout [<file_name(s)>]`
- Result: Undo changes made to specified `file_name(s)` in the _working directory_
    - This only applies to tracked, unstaged files (i.e., files listed under `Changes not staged for commit` when you check `git status`)
- _**Note**: The `git checkout` command can also be used for switching branches, but that will be covered later_

<br>
<details><summary>**Example**: Using `git checkout` to discard changes to a tracked, unstaged file</summary>



```bash
# First, create new R script
echo "library(tidyverse)" > create_dataset.R
echo "mpg %>% head(5)" >> create_dataset.R

# Add/commit R script so it is now tracked
git add create_dataset.R
git commit -m "add create_dataset.R"
```

```
## Initialized empty Git repository in C:/Users/ozanj/my_git_repo/.git/
## warning: LF will be replaced by CRLF in create_dataset.R.
## The file will have its original line endings in your working directory
## [master (root-commit) fafdd7d] add create_dataset.R
##  1 file changed, 2 insertions(+)
##  create mode 100644 create_dataset.R
```


```bash
# View how create_dataset.R looks when it was committed
cat create_dataset.R
```

```
## library(tidyverse)
## mpg %>% head(5)
```


```bash
# Modify R script
echo "df <- mpg %>% filter(year == 2008)" >> create_dataset.R

# View how create_dataset.R looks now
cat create_dataset.R
```

```
## library(tidyverse)
## mpg %>% head(5)
## df <- mpg %>% filter(year == 2008)
```


```bash
# See exact changes that have been made to file since last commit
git diff
```

```
## warning: LF will be replaced by CRLF in create_dataset.R.
## The file will have its original line endings in your working directory
## diff --git a/create_dataset.R b/create_dataset.R
## index c1cff38..490ec1c 100644
## --- a/create_dataset.R
## +++ b/create_dataset.R
## @@ -1,2 +1,3 @@
##  library(tidyverse)
##  mpg %>% head(5)
## +df <- mpg %>% filter(year == 2008)
```



```bash
# Undo those changes using git checkout
git checkout create_dataset.R

# View file after discarding changes
cat create_dataset.R
```

```
## Updated 1 path from the index
## library(tidyverse)
## mpg %>% head(5)
```

</details>
<br>


## git reset

**`git reset`**: Reset current `HEAD` to the specified state

- Help: `git reset -help`
- Syntax:
  - `git reset HEAD <file_name(s)>`: Unstages the specified `file_name(s)` from the _staging area_ to the _working directory_
    - This only applies to staged files (i.e., files listed under `Changes to be committed` when you check `git status`) and will move them back under `Changes not staged for commit` or `Untracked files`
    - `HEAD` is a pointer to the latest commit and will restore the _staging area_/"index" to that state
    - Any changes made to the file in the _working directory_ are still retained
  - `git reset <commit_hash>`: Undo all commits up to (but not including) the specified `commit_hash`
    - The `HEAD` pointer will be set to the specified commit
    - The undone changes will be retained in the _working directory_

<br>
<details><summary>**Example**: Using `git reset` to unstage a file</summary>
  

```bash
# First, create new R script
echo "library(tidyverse)" > create_dataset.R
echo "mpg %>% head(5)" >> create_dataset.R

# Add/commit R script so it is now tracked
git add create_dataset.R
git commit -m "add create_dataset.R"
```

```
## Initialized empty Git repository in C:/Users/ozanj/my_git_repo/.git/
## warning: LF will be replaced by CRLF in create_dataset.R.
## The file will have its original line endings in your working directory
## [master (root-commit) da43ed2] add create_dataset.R
##  1 file changed, 2 insertions(+)
##  create mode 100644 create_dataset.R
```


```bash
# Modify R script
echo "df <- mpg %>% filter(year == 2008)" >> create_dataset.R

# Add new changes to the staging area
git add create_dataset.R

# Check status to verify it has been staged (listed under `Changes to be committed`)
git status
```

```
## warning: LF will be replaced by CRLF in create_dataset.R.
## The file will have its original line endings in your working directory
## On branch master
## Changes to be committed:
##   (use "git restore --staged <file>..." to unstage)
## 	modified:   create_dataset.R
```


```bash
# Use git reset to unstage file
git reset HEAD create_dataset.R

# Check status to verify it has been unstaged (listed under `Changes not staged for commit`)
git status
```

```
## Unstaged changes after reset:
## M	create_dataset.R
## On branch master
## Changes not staged for commit:
##   (use "git add <file>..." to update what will be committed)
##   (use "git restore <file>..." to discard changes in working directory)
## 	modified:   create_dataset.R
## 
## no changes added to commit (use "git add" and/or "git commit -a")
```
</details>

<br>
<details><summary>**Example**: Using `git reset` to undo a commit</summary>


```bash
# First, create new R script
echo "library(tidyverse)" > create_dataset.R

# Add/commit R script
git add create_dataset.R
git commit -m "add 1st line to create_dataset.R"
```

```
## Initialized empty Git repository in C:/Users/ozanj/my_git_repo/.git/
## warning: LF will be replaced by CRLF in create_dataset.R.
## The file will have its original line endings in your working directory
## [master (root-commit) 871a547] add 1st line to create_dataset.R
##  1 file changed, 1 insertion(+)
##  create mode 100644 create_dataset.R
```


```bash
# Modify R script
echo "mpg %>% head(5)" >> create_dataset.R

# Add/commit R script
git add create_dataset.R
git commit -m "add 2nd line to create_dataset.R"
```

```
## warning: LF will be replaced by CRLF in create_dataset.R.
## The file will have its original line endings in your working directory
## [master a04d45e] add 2nd line to create_dataset.R
##  1 file changed, 1 insertion(+)
```


```bash
# View commit log
git log
```

```
## commit a04d45e84a01a9944962fe684a9bc9aa4f5dab7e
## Author: Ozan Jaquette <ozanj@ucla.edu>
## Date:   Sun Apr 5 22:38:47 2020 -0700
## 
##     add 2nd line to create_dataset.R
## 
## commit 871a547e5f140995e9f75db58ac313cdafaab40c
## Author: Ozan Jaquette <ozanj@ucla.edu>
## Date:   Sun Apr 5 22:38:46 2020 -0700
## 
##     add 1st line to create_dataset.R
```


```bash
# Specify the hash ID of the commit to undo up to
git reset $(git rev-list HEAD | tail -n 1)  # this retrieves the first commit hash

# View commit log - the 2nd commit has been removed
git log
```

```
## Unstaged changes after reset:
## M	create_dataset.R
## commit 871a547e5f140995e9f75db58ac313cdafaab40c
## Author: Ozan Jaquette <ozanj@ucla.edu>
## Date:   Sun Apr 5 22:38:46 2020 -0700
## 
##     add 1st line to create_dataset.R
```


```bash
# Notice that the changes to the file is still retained in the working directory
cat create_dataset.R
```

```
## library(tidyverse)
## mpg %>% head(5)
```

</details>
<br>

## git revert

**`git revert`**: Revert existing commit(s)

- Help: `git revert -help`
- Syntax:
  - `git revert <commit_hash>`: Revert all commits up to and including the specified `commit_hash`
    - The difference between `git revert` and `git reset` is that the former does not completely remove all past commits, but creates a new one that reverts those changes
    - When working in a collaborative project where multiple users are contributing to a remote repository, you may want to use `git revert` so that it does not permenantly erase history
    - When you are working locally and want to undo commits that you have not yet pushed to a remote, then `git reset` may also be an option
    - _**Note**: After entering this command, you'll be given a chance to edit the commit message of the new commit. Just enter `:q` to use the default message._

<br>
<details><summary>**Example**: Using `git revert` to revert a commit</summary>


```bash
# First, create new R script
echo "library(tidyverse)" > create_dataset.R

# Add/commit R script
git add create_dataset.R
git commit -m "add 1st line to create_dataset.R"
```

```
## Initialized empty Git repository in C:/Users/ozanj/my_git_repo/.git/
## warning: LF will be replaced by CRLF in create_dataset.R.
## The file will have its original line endings in your working directory
## [master (root-commit) b7faffa] add 1st line to create_dataset.R
##  1 file changed, 1 insertion(+)
##  create mode 100644 create_dataset.R
```


```bash
# Modify R script
echo "mpg %>% head(5)" >> create_dataset.R

# Add/commit R script
git add create_dataset.R
git commit -m "add 2nd line to create_dataset.R"
```

```
## warning: LF will be replaced by CRLF in create_dataset.R.
## The file will have its original line endings in your working directory
## [master b7ec26a] add 2nd line to create_dataset.R
##  1 file changed, 1 insertion(+)
```


```bash
# View commit log
git log
```

```
## commit b7ec26a74816f229ca85c2b4dec202813de8be92
## Author: Ozan Jaquette <ozanj@ucla.edu>
## Date:   Sun Apr 5 22:38:48 2020 -0700
## 
##     add 2nd line to create_dataset.R
## 
## commit b7faffae1ccc4d57d9e1b8ccbd75151954425fe5
## Author: Ozan Jaquette <ozanj@ucla.edu>
## Date:   Sun Apr 5 22:38:48 2020 -0700
## 
##     add 1st line to create_dataset.R
```


```bash
# Specify the hash ID of the unwanted commit
git revert $(git rev-parse --short HEAD)  # git rev-parse retrieves latest commit hash

# View commit log
git log
```

```
## [master 5b0e7f9] Revert "add 2nd line to create_dataset.R"
##  Date: Sun Apr 5 22:38:49 2020 -0700
##  1 file changed, 1 deletion(-)
## commit 5b0e7f965a60cebfcd06ba842f7fc54eac00d52c
## Author: Ozan Jaquette <ozanj@ucla.edu>
## Date:   Sun Apr 5 22:38:49 2020 -0700
## 
##     Revert "add 2nd line to create_dataset.R"
##     
##     This reverts commit b7ec26a74816f229ca85c2b4dec202813de8be92.
## 
## commit b7ec26a74816f229ca85c2b4dec202813de8be92
## Author: Ozan Jaquette <ozanj@ucla.edu>
## Date:   Sun Apr 5 22:38:48 2020 -0700
## 
##     add 2nd line to create_dataset.R
## 
## commit b7faffae1ccc4d57d9e1b8ccbd75151954425fe5
## Author: Ozan Jaquette <ozanj@ucla.edu>
## Date:   Sun Apr 5 22:38:48 2020 -0700
## 
##     add 1st line to create_dataset.R
```


```bash
# The file now only contains the 1st line
cat create_dataset.R
```

```
## library(tidyverse)
```



</details>


