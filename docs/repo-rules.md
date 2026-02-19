# Repository Rules

## Branch Model

((tag|main|red)) Production-ready.
- Always deployable
- No direct commits
- Only receives merges from ((tag|release|orange)) or ((tag|hotfix|purple))
  


((tag|develop|blue)) Integration branch.
- Base for all feature work
- Must remain stable
- Receives merges from ((tag|feature|green)) and ((tag|release|orange))

((tag|feature|green)) Feature development branches.
- Created from ((tag|develop|blue))
- Named: ((tag|feature|green))/<short-description>
- Deleted after merge

((tag|release|orange)) Stabilization branches.
- Created from ((tag|develop|blue))
- Named: ((tag|release|orange))/<version>
- No new features
- Bug fixes and version adjustments only
- Merged into both ((tag|main|red)) and ((tag|develop|blue))

((tag|hotfix|purple)) Production emergency fixes.
- Created from ((tag|main|red))
- Named: ((tag|hotfix|purple))/<short-description>
- Merged into both ((tag|main|red)) and ((tag|develop|blue))


## Workflow Rules

1. Never commit directly to ((tag|main|red)).
2. Create branches from the correct base.
3. Keep commits small and coherent.
4. Use descriptive commit messages.
5. Delete temporary branches after merge.

## Commit Standards

- Use present tense.
- Be explicit about intent.
- One logical change per commit.


## Versioning

- Use semantic versioning.
- Format: `MAJOR.MINOR.PATCH`
- Tag releases:

## Structural Discipline

- No secrets committed.
- No dead code.
- No placeholder branches.
- Remove unused artifacts.

---

## Intent

This repository prioritizes clarity, reproducibility, and disciplined change.

Structure reduces entropy.

question: what branch am i on?
```git
git branch
```

question: how do i stage all my changed?

```git
git add .
```

question: how do i commit?

```git
git commit -m "Add repository rules and workspace configuration"
```

```git
git push
```


question: what if i want to push this from develop to main?

```git
First, make sure everything is pushed:

git checkout develop
git pull origin develop
```

Now switch to main:
```git
git checkout main
```

Update it so you’re not merging into something stale:

```git
git pull origin main
```

Now merge develop into main:
```git
git merge develop
```

If there are no conflicts, Git will create a merge commit (unless it can fast-forward).

Now push main:

```git
git push origin main
```