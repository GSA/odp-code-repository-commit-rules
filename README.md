# Project
The objective of this repository is to warehouse common rules and patterns for identifying sensitive information in source code.

## Rules and Patterns

The examples in the table below are Regular Expression patterns that match sensitive information that should not be committed to an open-source repository.
Name|Value
--|--
Social Security Numbers|`[0-9]{3}[\.\-][0-9]{2}[\.\-][0-9]{4}`
IPv4 Addresses|`[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}`
Credit Cards|`[0-9]{12}(?:[0-9]{3})?`

## Repository contents

`gitleaks/rules.toml` contains an up-to-date list of rules and patterns for projects using [gitleaks](https://github.com/zricethezav/gitleaks).

## Public domain

This project is in the worldwide [public domain](LICENSE.md). As stated in [CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States, and copyright and related rights in the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0 dedication. By submitting a pull request, you are agreeing to comply with this waiver of copyright interest.