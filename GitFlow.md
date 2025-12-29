# GitFlow — Branching Strategy

This repository follows the GitFlow model to standardize development and releases.

Branches
- `main`: production-ready code. Only release merges go here.
- `develop`: integration branch for features; CI runs full test-suite.
- `feature/*`: short-lived feature branches branched from `develop`.
- `release/*`: preparation branches for releases; merged into `main` and `develop`.
- `hotfix/*`: urgent fixes branched from `main` and merged back to `main` and `develop`.

Common commands

Create a feature branch:

```bash
git checkout develop
git checkout -b feature/my-feature
```

Finish feature (merge into `develop`):

```bash
git checkout develop
git pull
git merge --no-ff feature/my-feature
git push origin develop
```

Finish release (merge to `main` and `develop`):

```bash
git checkout main
git merge --no-ff release/1.2.0
git tag -a v1.2.0 -m "Release 1.2.0"
git push origin main --tags

git checkout develop
git merge --no-ff release/1.2.0
git push origin develop
```

Hotfix example:

```bash
git checkout main
git checkout -b hotfix/1.2.1
# fix
git commit -am "Fix: ..."
git checkout main
git merge --no-ff hotfix/1.2.1
git tag -a v1.2.1 -m "Hotfix 1.2.1"
git push origin main --tags

git checkout develop
git merge --no-ff hotfix/1.2.1
git push origin develop
```

CI Integration
- Protect `main` and `develop` branches in your Git host and require pull request approvals and passing CI checks before merging.
