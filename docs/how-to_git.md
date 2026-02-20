### how to push from windows to mac on development branch and pick up from there

1.  make sure you're on the right branch

```
git status

```

```
git branch
```

2. pull first so we're not pushing on to a stale branch

```
git pull origin develop
```

3. stage and commit
```
git add .
git commit -m "wip: <short description of what you changed>"
```

4. push the commits to github

```
git push origin develop
```

5. on mac
```
git checkout develop
git pull origin develop
```