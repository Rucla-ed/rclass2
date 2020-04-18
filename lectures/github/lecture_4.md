---
title: "Lecture 4"
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

# Pull Requests

What is a **pull request**?

> "Pull requests let you tell others about changes you've pushed to a branch in a repository on GitHub. Once a pull request is opened, you can discuss and review the potential changes with collaborators and add follow-up commits before your changes are merged into the base branch." -- [GitHub Help](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/about-pull-requests)

- As mentioned in the [branching](#9_branching) section, there is typically one base branch (usually master) that contains all working or approved changes
- Any development or testing is usually done on separate branches, then merged back into master once changes are finalized
- Pull requests are essentially requests to have one branch (e.g., development branch) merged into another (e.g., master branch)
- Pull requests are opened on GitHub

<br>
Why make a **pull request**?

- In a collaborative setting, pull requests give other people a chance to review and approve your changes before they are merged to the base branch
  - This allows for better quality control
  - It also lets all collaborators be in agreement with what gets merged to the base branch
- Pull requests can also be a way to keep a history of the major revisions and decisions made to the project

<br>
Types of **pull requests** ([Pull Request Tutorial](https://yangsu.github.io/pull-request-tutorial/))

- Pull request from a forked repository
  - People who don't have write permission to a repository can still contribute to it using this method
  - Process:
    - Fork the repository (i.e., create a copy under one's own account so they have write permission)
    - Make changes to the forked repository
    - Open a pull request on GitHub to have their changes merged to the original repository
  - Alternative to pull request:
    - Open an issue instead to request certain changes
    - But this means someone still has to implement the change
    - If the requester is able to make the change themselves, doing so and creating a pull request is a faster way to get the change incorporated
- Pull request from a branch within a repository
  - Collaborators working on the same repository can use pull requests as a way to let each other know about changes they made that they want incorporated to the main branch (typically master)
  - Process:
    - Create a new local branch off master to make changes to
    - Push the branch to the remote repository
    - Open a pull request on GitHub to have their branch merged to master
  - Alternative to pull request:
    - Merge your changes on the local branch directly into local master, then push to remote (see below for example)
    - This bypasses the review and approval process that a pull request offers
  
We will be focusing on the second type of pull request.

<br>
<details><summary>**Example**: Alternative to pull request: Merging changes directly into master</summary>

Let's say we create a new R script and add/commit that to the master branch:




```bash
# Create new R script
echo "library(tidyverse)" > create_dataset.R

# Add/commit R script
git add create_dataset.R
git commit -m "import tidyverse library"
```

```
## [master (root-commit) 3a2c074] import tidyverse library
##  1 file changed, 1 insertion(+)
##  create mode 100644 create_dataset.R
```

Then, we create a new branch and make further changes to the R script on the branch:


```bash
# Create and switch to new branch
git checkout -b dev

# Modify R script
echo "mpg %>% head(5)" >> create_dataset.R

# Add/commit R script
git add create_dataset.R
git commit -m "preview mpg dataset"
```

```
## Switched to a new branch 'dev'
## 
## [dev 18c53d0] preview mpg dataset
##  1 file changed, 1 insertion(+)
```

At this point, we can push this new branch to the remote if we wanted to open a pull request. But the alternative is to directly merge the changes to master:


```bash
# Switch back to master
git checkout master

# Merge in changes from the branch
git merge dev
```

```
## Switched to branch 'master'
## Updating 3a2c074..18c53d0
## Fast-forward
##  create_dataset.R | 1 +
##  1 file changed, 1 insertion(+)
```

Then, we can push the changes to the remote's master branch, which would also be the ultimate goal of a pull request:


```bash
# Push to remote's master
git push
```

</details>
<br>

## Creating a pull request 

*All image credits: [GitHub Help](https://help.github.com/en)*

<br>
**Creating a topical branch**:

- Create a new local branch and make your changes to it
- After you are done, it is good practice to merge in any changes from master that your branch doesn't have
  - This makes it easier later down the road when you are merging your branch back into master after the pull request is complete
- Push your branch to the remote repository

<br>
**Making the pull request**:

- On GitHub, select your branch and click `New pull request`:

  [![](https://help.github.com/assets/images/help/pull_requests/branch-dropdown.png){width=300px}](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request)
  
- Add a title and (optionally) a description for your pull request. You can also `@` users/teams if you want:
  
  [![](https://help.github.com/assets/images/help/pull_requests/pullrequest-description.png){width=500px}](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request)

- Click `Create Pull Request`:

  [![](https://help.github.com/assets/images/help/pull_requests/pullrequest-send.png){width=300px}](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request)

- Your pull request will appear under the tab `Pull requests`:

  [![](https://help.github.com/assets/images/help/repository/repo-tabs-pull-requests.png)](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/requesting-a-pull-request-review)

<br>
**Assigning reviewers**:

- On the right-hand side of the pull request, you are also able to assign **Reviewers** or **Assignees**, similar to an issue:

  ![](../../assets/images/reviewer.png)

- **Reviewers** should be someone who you want to review the changes you made, while **Assignees** could be anyone else more generally involved in the pull request
  - Reviewers will get a notification that their review is requested
  - Whether or not the reviewer actually completes a reviews does not affect the ability to merge pull request
  - If someone who is not assigned as reviewer reviews the changes (i.e., does one of three actions described in the next section), they will be added to the reviewers list
- The users listed under **Reviewers** (unlike **Assignees**) will also have a status icon:

  [![](https://help.github.com/assets/images/help/pull_requests/request-re-review.png)](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/requesting-a-pull-request-review)

  - ![](../../assets/images/reviewer_status_yellow.png): Pending review from reviewer
  - ![](../../assets/images/reviewer_status_gray.png): Reviewer has left comments
  - ![](../../assets/images/reviewer_status_green.png): Reviewer has approved changes
  - ![](../../assets/images/reviewer_status_red.png): Reviewer has requested additional changes
  - For any of the last three statuses, you can click ![](../../assets/images/reviewer_request.png) to re-request a review from the reviewer

<br>
<details><summary>**Example**: Creating a pull request</summary>

Similar to the previous example, let's say we create a new R script and added/committed that to the master branch:




```bash
# Create new R script
echo "library(tidyverse)" > create_dataset.R

# Add/commit R script
git add create_dataset.R
git commit -m "import tidyverse library"
```

```
## [master (root-commit) 3a2c074] import tidyverse library
##  1 file changed, 1 insertion(+)
##  create mode 100644 create_dataset.R
```

Then, we create a new branch and make further changes to the R script on the branch:


```bash
# Create and switch to new branch
git checkout -b dev

# Modify R script
echo "mpg %>% head(5)" >> create_dataset.R

# Add/commit R script
git add create_dataset.R
git commit -m "preview mpg dataset"
```

```
## Switched to a new branch 'dev'
## 
## [dev 18c53d0] preview mpg dataset
##  1 file changed, 1 insertion(+)
```

At this point, we can push this new branch to the remote repository. Remember to set the upstream branch if this is the first time you are pushing the branch to remote:


```bash
# Push branch to remote (say our remote is called `origin` here)
git push --set-upstream origin dev
```

All the subsequent steps to open the pull request will be performed on GitHub.

</details>
<br>

## Responding to a pull request

There are two ultimate responses to a pull request.

- **Merging** pull request:

  [![](https://help.github.com/assets/images/help/pull_requests/pullrequest-mergebutton.png)](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/merging-a-pull-request)

- **Closing** pull request:

  [![](https://help.github.com/assets/images/help/pull_requests/pullrequest-closebutton.png){width=400px}](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/closing-a-pull-request)

But before coming to one of these decisions, you will likely want to review the changes in more detail.

### Reviewing changes

Under the `Files` tab, you can view all changes that would potentially be merged if the pull request is completed:

[![](https://help.github.com/assets/images/help/pull_requests/pull-request-tabs-changed-files.png)](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/about-comparing-branches-in-pull-requests)

There, you will also see a button called `Review changes` that contains three options for leaving a review:

[![](https://help.github.com/assets/images/help/pull_requests/pull-request-review-statuses.png){width=500px}](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/about-pull-request-reviews)

<br>
**Comment**:

- Select this option to leave general feedback on the changes
  - You must write something in the comment box in order to click `Submit review`
- The reviewer status will be changed to ![](../../assets/images/reviewer_status_gray.png)
- Note that simply leaving a comment on the main pull request page will not trigger this status change

<br>
**Approve**:

- Select this option to approve merging the changes
  - You do not need to write anything in the comment box in order to click `Submit review`
- The reviewer status will be changed to ![](../../assets/images/reviewer_status_green.png)

<br>
**Request changes**:

- Select this option to request further changes before merging
  - You must write something in the comment box in order to click `Submit review`
- The reviewer status will be changed to ![](../../assets/images/reviewer_status_red.png)
- You will see that the merge box on the main pull request page is outlined in orange, along with a list of reviewers who requested changes:

  [![](https://help.github.com/assets/images/help/pull_requests/merge_box/pr-reviews-in-merge-box.png){width=500px}](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/about-pull-request-reviews)
  
- To respond to the change request from each reviewer, there are three options:

  [![](https://help.github.com/assets/images/help/pull_requests/merge_box/pull-request-dismiss-review.png){width=500px}](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/dismissing-a-pull-request-review)
  
  - `Approve changes`: The reviewer can select this to resolve the change request
    - This will turn the merge box outline from orange back to green
    - The reviewer status will be changed to ![](../../assets/images/reviewer_status_green.png)
    - For anyone other than the reviewer, they will see the option `See review` instead
  - `Dismiss review`: The review can be dismissed by anyone
    - You will be asked to enter a reason why you want to dismiss the review, which will appear as a comment on the pull request page
    - This will turn the merge box outline from orange back to green
    - The reviewer status will be changed to ![](../../assets/images/reviewer_status_gray.png)
  - `Re-request review`: Another review from the reviewer can be requested
    - The merge box outline will remain orange
    - The reviewer status will be changed to ![](../../assets/images/reviewer_status_yellow.png)

- Note that the merge box outline color and reviewer status do not affect the ability to merge the pull request


### Line-by-line comments

Under the `Files` tab, you can also make comments to specific lines of a file:

  [![](https://help.github.com/assets/images/help/commits/hover-comment-icon.gif){width=500px}](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/commenting-on-a-pull-request)
  
<br>
More on this next week.
<br>

### Code review best practices

TBD

# Organizing projects and scripts

[Organizing Lecture](https://edquant.github.io/edh7916/lessons/organizing.html) by Ben Skinner

- [Organizing a project directory](https://edquant.github.io/edh7916/lessons/organizing.html#organizing-a-project-directory)
- [Organizing a script](https://edquant.github.io/edh7916/lessons/organizing.html#organizing-a-script)
- *Bonus: [Some notes on work flow (good habits)](https://edquant.github.io/edh7916/lessons/intro.html#some-notes-on-work-flow-good-habits)*

Problem set expectations:

- Each team will create one repository to share
  - Rotate who will be creating the repository each week
- All work must be done on a separate branch other than master
- You must push your branch to the remote and have your work merged to master via a pull request
- All your work will be completed in an `.R` script (rather than an `.Rmd` file)

<br>
<details><summary>**Student Task**: Creating a team GitHub repository</summary>

**Part 1: Create the repository**

- Have one member of your team create a private repository [here](https://github.com/organizations/Rucla-ed/repositories/new)
  - Name it `<team_name>_ps4`
  - You will use it for this week's problem set
- All team members will clone this repository to their local machines

**Part 2: Add data file**

- Have a second member of your team add the data file
  - Create a sub-directory in the repository called `data`
  - Inside `data`, save the recruiting dataset from [here](https://github.com/Rucla-ed/rclass2/raw/master/_data/recruiting/recruit_school_somevars.RDS)
  - Add/commit the file and push to GitHub
- All other team members will pull this change
  
<!--
  
**Part 3: Add lecture file**

- Have a third member of your team add the lecture file
  - Create a sub-directory in the repository called `lecture`
  - Inside `lecture`, save the latest version of the Github lecture Rmd [here](https://raw.githubusercontent.com/Rucla-ed/rclass2/master/lectures/github/github_lecture.Rmd)
  - Add/commit the file and push to GitHub
- All other team members will pull this change

-->

</details>

## Current working directory

When you run R code in an `.Rmd` file, the working directory is the directory that your `.Rmd` file is in:


```r
getwd()
```

```
## [1] "/Users/cyouh95/Projects/RStudio/rclass2/lectures/github"
```

<br>
When you run an `.R` script, the working directory is the directory indicated at the top of your console in RStudio:

![](../../assets/images/r_console.png)

- This is typically your home directory if you are not working from an RStudio project
- If you are working from an RStudio project, your working directory would be the project directory

## RStudio project

How to create an **RStudio project**?

- On the top right corner in RStudio, select `New Project` under the dropdown menu
- If there's a folder you want to turn into a project, select `Existing Directory`
- Under `Project working directory`, browse for your folder and click `Create Project`

![](../../assets/images/rstudio_project.png)

<br>
Why use **RStudio project**?

- Creating a RStudio project helps keep everything relative to the project directory
  - Your R Console and R scripts will run using the project directory as the working directory
  - Your Terminal in RStudio will start in the project directory
  - Your file browser window (bottom right panel) will also start off in the project directory

<br>
<details><summary>**Student Task**: Creating an RStudio project</summary>

Create an RStudio project for your `<team_name>_ps4` directory.

Notice that the working directory in both your R Console and Terminal will be set to your project directory.

</details>

## File paths

> We use the `file.path()` command because it is smart. Some computer operating systems use forward slashes, `/`, for their file paths; others use backslashes, `\`. Rather than try to guess or assume what operating system future users will use, we can use R's function, `file.path()`, to check the current operating system and build the paths correctly for us.

*Credit: [Organizing Lecture](https://edquant.github.io/edh7916/lessons/organizing.html) by Ben Skinner*

<br>
__The `file.path()` function__:


```r
?file.path

# SYNTAX AND DEFAULT VALUES
file.path(..., fsep = .Platform$file.sep)
```

- Pass in each section of the file path as a separate argument
  - Example: `file.path('.', 'lectures', 'week_1')` returns `'./lectures/week_1'`
- You can also save this file path object in a variable
  - Example: `lec_dir <- file.path('.', 'lectures', 'week_1')`

<!--

- `dir.create()`: `mkdir`
- `file.create()`: `touch`
- `list.files()`: `ls`

data_dir <- file.path('.', '_data', 'recruiting')
saveRDS(df_school, file.path(data_dir, 'recruit_school_somevars.RDS'))
df <- readRDS(file.path(data_dir, 'recruit_school_somevars.RDS'))
-->

<br>
<details><summary>**Student Task**: Saving path in an object</summary>

In your R console, create a variable called `data_dir` that stores the path to your `data` folder. Remember that the R console for an RStudio project uses the project directory as the working directory, so write `data_dir` as a path relative to that.

</details>

<br>

## Saving and reading data

<br>
__The `saveRDS()` and `readRDS()` functions__:


```r
?saveRDS

# SYNTAX AND DEFAULT VALUES
saveRDS(object, file = "", ascii = FALSE, version = NULL,
        compress = TRUE, refhook = NULL)


?readRDS

# SYNTAX AND DEFAULT VALUES
readRDS(file, refhook = NULL)
```


- `saveRDS()`: Writes a single R object to a file
  - Example: `saveRDS(my_df, file.path(files_dir, 'my_data.RDS'))`
    - This saves the `my_df` object to a file called `my_data.RDS` that is located inside the `files_dir`
- `readRDS()`: Restores the saved object
  - Example: `my_df <- readRDS(file.path(files_dir, 'my_data.RDS'))`
    - This loads the R object stored in `my_data.RDS` (which is located inside the `files_dir`) and saves it in a variable called `my_df`

<br>
<details><summary>**Student Task**: Reading and saving data</summary>

Using your `data_dir` saved from the previous exercise, load the recruiting dataset and save it to a variable called `df_school`.

Next, write this dataframe to a file called `data_<your_last_name>.RDS` - make sure this file is saved inside `data_dir`.

Add/commit your data file and push to GitHub. Pull your team members' data files.

</details>

# JSON

What is **JSON**?

- **JavaScript Object Notation** (**JSON**) is a data file format, like CSV
- JSON syntax is derived from JavaScript

What does **JSON** data look like?

- In JavaScript, there are data structures called **arrays** and **objects**
  - **Arrays**: Contains elements separated by `,` and surrounded by square brackets (`[]`)
    - Example: `["a", "b", "c"]`
    - We can think of this as `R` vectors, except the elements do not have to be the same type
  - **Objects**: Contains key-value pairs separated by `,` and surrounded by curly brackets (`{}`)
    - Example: `{"a": "alfa", "b": "bravo", "c": "charlie"}`
    - We can think of this as `R` lists
- Each element can be a string or numeric type
  - String elements must be surrounded by **double quotes**
- There can be nested "arrays" and/or "objects" in the JSON data

<br>
**Example**: Simple JSON data

- In this particular example, the data can easily be converted to an R dataframe
  - Each row is a state
  - The columns are `state_name` and `median_household_income`

```
[
  {
    "state_name": "Alaska",
    "median_household_income": 72515
  },
  {
    "state_name": "California",
    "median_household_income": 61818
  },
  {
    "state_name": "New York",
    "median_household_income": 59269
  }
]
```

<br>
**Example**: Nested JSON data

```
{
   "status" : "OK",
   "plus_code" : {
      "compound_code" : "P27Q+MC New York, NY, USA",
      "global_code" : "87G8P27Q+MC"
   },
   "results" : [
      {
         "formatted_address" : "279 Bedford Ave, Brooklyn, NY 11211, USA",
         "geometry" : {
            "location" : {
               "lat" : 40.7142484,
               "lng" : -73.9614103
            }
         },
         "types" : [
            "bakery",
            "cafe",
            "establishment",
            "food",
            "point_of_interest",
            "store"
         ]
      }
   ]
}
```

*Source: [Geocoding API](https://developers.google.com/maps/documentation/geocoding/start)*

  


