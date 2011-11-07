# GitHub Backups

This script will find all repositories that a user has access to and clone them
onto the local machine.

## Usage

```sh
git clone git://github.com/ennova/github_backup
cd github_backup
env GITHUB_USERNAME=foo GITHUB_PASSWORD=secret ruby backup.rb
# or for an organization
env GITHUB_USERNAME=foo GITHUB_PASSWORD=secret GITHUB_ORGANIZATION=bar ruby backup.rb
# using the path and backup path options (for example to clone into bananjour)
env GITHUB_USERNAME=foo GITHUB_PASSWORD=secret GITHUB_REPOSITORY_TYPE=public GITHUB_BACKUP_PATH=$HOME/.bananajour/repositories ruby backup.rb
```

### Environment Variables

  - `GITHUB_USERNAME` and `GITHUB_PASSWORD`

    GitHub username and password for authentication.

  - `GITHUB_ORGANIZATION`

    Organization name (optional).

  - `GITHUB_REPOSITORY_TYPE`

    Type of repositories. Defaults to `all`. (Acceptable values: `all`, `private`, `public`, and `member`.)

  - `GITHUB_BACKUP_PATH`

    Directory to store the repositories. Default `repositories`.
