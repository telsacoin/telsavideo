| title        | position | layout |
| ------------ | -------- | ------ |
| Contributors | 1        | full   |

Everyone is welcome to contribute code to TELSA Video. projects. We have a Code of Conduct; we ask that you please follow it in all your interactions with our team and your fellow contributors.

Please note that this contributing guide only applies to our development presence.

## Repositories

There are currently two repositories that you can contribute to:

1. Devportal https://github.com/TelsaCoin/TelsaVideo

All of the repositories have a package.json file included with them with script helpers setup. To use these you will need the following packages installed:

1. [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/en/)
2. [prettier](https://github.com/prettier/prettier)
3. [eslint](https://eslint.org/)

These must all be installed in your development environment

Each of the repositories have the following scripts

`yarn lint` - performs linting validation on the codebase `yarn fmt` - executes prettier to format the codebase

There is also a `precommit` script that will run both of these on committing of code to the repositoriy.

When contributing to the **DevPortal** all code snippets must be added to the `_includes/<tutorial name>` folder since this will be linted on commit. You can also wrap all your code in the tutorial in ````` tags which will force them to be highlighted in the portal.

## How to contribute

1. File an issue describing the problem you would like to solve or the feature you would like to add. It saves unnecessary work on your part, in case there's a nontechnical reason we can't accept a particular change. Please note that we can and will *automatically close all pull requests that do not refer to an issue*.
2. Learn the conventions of the project you are submitting code to, even implicit ones, and follow them. In case you have a question about a project's conventions, please ask on the issue you filed. This includes writing tests, formatting code, and documentation.
3. File a pull request against your Github issue and fill out the pull request template. Remember, you are agreeing to license your code and any intellectual property associated with your code under the same terms as the repository you are contributing to.
4. If one of our teammates asks you to make changes, please make them. Our rule is that all requests for changes in code review are resolved in favor of the reviewer. Our teammates follow this rule too!

## Code of Conduct

Again, please note that this Code of Conduct *only applies to our development presence*.

### Our Pledge

We welcome your membership in our project and community under the rules that we have set below.

In the interest of fostering an open and welcoming environment, we as contributors and maintainers will work to make your participation in our project and community as fulfilling as possible.

### Our Rules

All members of our project and community must:

1. Show empathy toward other project and community members
2. Use welcoming and inclusive language
3. Respect differing viewpoints and experiences
4. Gracefully accept constructive criticism

All members of our project and community must not:

1. Harm our project and community, or advocate harm to our project and community
2. Insult or make derogatory comments about others
3. Interact with others after they have withdrawn permission to do so

### Our Responsibilities

We will use any and all lawful means at our disposal to enforce our rules. This includes but is not limited to:

1. Rejecting contributions
2. Removing comments, commits, code, wiki edits, and issues
3. Banning abusers

We will clarify standards of acceptable behavior and we will take appropriate and fair corrective action in response to any instances of unacceptable behavior.

Instances of abusive, harassing, or otherwise unacceptable behavior may be reported by contacting us at [github.abuse@steemit.com](mailto:github.abuse@steemit.com). All complaints will be reviewed and investigated and will result in a response that is deemed necessary and appropriate to the circumstances. We maintain strict confidentiality with regard to the reporter of an incident. Further details of specific enforcement policies may be posted separately.

### Attribution

This Code of Conduct is adapted from the [Contributor Covenant](http://contributor-covenant.org/), version 1.4, available at [http://contributor-covenant.org/version/1/4](http://contributor-covenant.org/version/1/4/gg)