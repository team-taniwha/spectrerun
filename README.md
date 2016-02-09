# spectrerun
Find and run all of the specs impacted by your changes

Why would I want to use this?
---

Say you work at a Ruby on Rails dev shop with a huge codebase. `spectrerun` will help you figure out which specs you should run to test your changes, so you don't have to push your code up to CI and wait to see what fails.

Installation
---

```bash
gem install spectrerun
```

Usage
---

`spectrerun` works by looking at the list of files changed (`git diff --name-only`). It then figures out what classes are declared in those files, and which files use those classes. It then gives you a list of specs to run!

```bash
spectrerun

spectrerun | xargs bundle exec rspec

# 5 commits ago
spectrerun HEAD~5

spectrerun HEAD~1..HEAD~3

spectrerun my_private_branch
```

How does it work?
---

`spectrerun` performs static analysis on your codebase to figure out where constants are declared and used throughout the system. It then figures out which specs you might need to run based on that information.
