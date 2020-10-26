# 18F eslint GitHub Action

A GitHub action for running the
[18F configuration of ESLint](https://github.com/18F/18f-eslint) on your project
nice and easily. Here's a sample workflow to get you started, or visit GitHub's
[documentation on workflow syntax](https://docs.github.com/en/free-pro-team@latest/actions/reference/workflow-syntax-for-github-actions)
for more information.

The simplest way to get this action installed into your repo is by using the
action installer:

```shell
npx -p @18f/18f-eslint install-action
```

(**NOTE** the `-p` - this is required in order to run non-default commands.)

This commend will begin at the root of your git repo, walk through your
directory tree looking for `package.json` files, and add a step to lint the
directories where each one is located. Once the basic action is installed, you
can then go tweak the configuration.

The action configuration is in a yaml file to your project's
`.github/workflows/` directory with something like this in it:

```yml
name: lint action

on: [pull_request]

jobs:
  lint:
    name: 18F ESLint
    runs-on: ubuntu-latest
    container: node:14
    steps:
      - uses: actions/checkout@af513c7a
      - uses: 18f/18f-eslint-action@v1.0.0
```

In a super simple project, that might be all you need. From now on, all of your
pull requests (and subsequent pushes to the same pull request) will have this
action run on them. The action will fail if there are any lint errors.

## Configuration

For somewhat more complicated projects (like, probably all of them), you can
configure the action's working directory and the glob that it uses to find files
for linting by setting its inputs. Inputs are set by adding them under a `with`
property in the `uses` block for the action:

```yml
- uses: 18f/18f-eslint-action@v1.0.0
  with:
    lint-glob: **/*.js
    working-directory: src
```

| variable          | default | what it does                                                                                                    |
|-------------------|---------|-----------------------------------------------------------------------------------------------------------------|
| lint-glob         | `.`     | Indicates what files to run eslint on. This is any single glob that eslint supports.                            |
| working-directory | `.`     | Indicates where install [@18f/18f-eslint](https://npm.im/@18f/18f-eslint). This path must include package.json. |

## Notes about action refs

In the example yml above, the `actions/github` action is using a SHA ref rather
than a version number. The reason is that it's very easy to change a commit's
tag, but its SHA cannot be changed, so referring to a SHA is much safer.

For the `18f/18f-eslint-action` action, it uses a tag rather than a SHA because
18F controls the repo and can make more guarantees about tags. It makes sense,
therefore, to give our own repos more trust.

### Public domain

This project is in the worldwide [public domain](LICENSE.md). As stated in
[CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States, and copyright
> and related rights in the work worldwide are waived through the
> [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0 dedication.
> By submitting a pull request, you are agreeing to comply with this waiver of
> copyright interest.
