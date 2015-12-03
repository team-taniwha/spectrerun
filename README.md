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

```bash
spectrerun

spectrerun | xargs bundle exec rspec
```
