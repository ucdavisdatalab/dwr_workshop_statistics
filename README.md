# Template: R Workshop Reader

This repository is a template for R-specific workshop readers for the UC Davis
DataLab. The template uses [Quarto][] to render the reader.

[Quarto]: https://quarto.org/

To get started, create a new repo on GitHub from this template
([instructions][gh]), then `git clone` your new repo.

[gh]: https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template

Once you've cloned the repo, here's a checklist of things to do to prepare it:

1. Environment management: we recommend using [Pixi][], a fast package manager
   based on the conda ecosystem. A few minutes spent on proper environment
   management now will save you time (and suffering) later! To install Pixi,
   follow [the official instructions][Pixi].

   [Pixi]: https://pixi.prefix.dev/

   Once you've installed Pixi, open a terminal and navigate to your local clone
   of this repo. The repo is already set up with a Pixi virtual environment:
   explicit dependencies and version constraints are listed in `pixi.toml`, and
   the exact versions of *all* dependencies are listed in `pixi.lock`. To
   upgrade to the most recent versions, ignoring the constraints, run:

   ```sh
   pixi upgrade
   ```

   Pixi will upgrade `pixi.toml` and `pixi.lock` to match. Don't forget to
   commit these files when they change!

   At this point, you can use `pixi add` to install other packages. See
   [`CONTRIBUTING.md`](CONTRIBUTING.md) for more about how to use Pixi.

2. `README.md`: Replace the all-caps text with your workshop details.
   + Title
   + Quarter & year
   + Author's name and email
   + Helpers' names and email (optional)
   + Reader URL
   + Event URL
   + Description, learning goals, & prerequisites

3. `_quarto.yml`: Replace the all-caps text with your workshop details.
    + Author's name and email
    + Title
    + GitHub repository URL
    + Reader URL

4. `index.md` and `chapters/`: Write chapters as Quarto Markdown (`.qmd`)
   files.

5. `_quarto.yml`: This file contains the table of contents for the book. Any
   chapters that are not registered here will not appear in the book. The
   `index.qmd`, `references.qmd`, and `assessment.qmd` chapters are already
   registered. If you rename or add any chapters, you must update the table of
   contents in order for them to appear in the book.

6. Compile your book with:

   ```sh
   pixi run build
   ``` 

   This will generate a new `_build/` directory, which will contain HTML
   versions of your reader. This should not be added to Git (a `.gitignore` 
   file is already in the template).

7. `git add` all of the changed files, then `git commit` and `git push`.

8. This template is set up to serve the reader from the `gh-pages` branch of
   the repository. Once you've committed your files, you need to run one more
   command, which will automatically push the rendered HTML files to the
   `gh-pages` branch on GitHub:

   ```sh
   pixi run publish
   ```

   Make sure the GitHub repo is configured to serve pages from the `gh-pages`
   branch by going to `Settings/Pages` on GitHub. Select the `gh-pages` branch
   if it isn't selected already. _You must run the `pixi run publish` step
   every time you wish to push updates to the live site on GitHub._

9. `README.md`: Remove these template instructions, which end at this step,
   then add, commit, and push the changes.


# Workshop: WORKSHOP_TITLE

_[UC Davis DataLab][datalab]_  
_QUARTER YEAR_  
_Author(s): YOUR_NAME_  
_Maintainer: MAINTAINER_NAME <<MAINTAINER_EMAIL@ucdavis.edu>>_

The reader for this workshop is [here][reader].

SHORT DESCRIPTION OF WORKSHOP

[datalab]: https://datalab.ucdavis.edu/
[reader]: https://ucdavisdatalab.github.io/YOUR_REPOSITORY/
