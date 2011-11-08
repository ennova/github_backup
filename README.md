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

### Scheduling With Cron

Create a file in the same directory as `backup.rb` with the following (replace or remove the variables as needed):

**backup_cron.sh**

```sh
export PATH=/usr/bin:/bin:/sbin
cd "$(dirname "$0")"
# this sets up RVM is you're using it
[[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm
source .rvmrc

export GITHUB_USERNAME='username'
export GITHUB_PASSWORD='password'
export GITHUB_ORGANIZATION='organization' # optional
export GIT_SSH="$(pwd)/ssh_build"         # ssh key for github authorization
exec ruby backup.rb
```

Use this script tell git what ssh key to use.

**ssh_build**

```sh
#!/bin/bash -e
exec ssh -i "$(dirname "$0")/id_rsa" "$@" # path to your ssh key
```

Next type `crontab -e` into terminal and copy in the following line:

`05 * * * * ~/Documents/github_backup/backup_cron.sh > ~/Documents/github_backup/backup_cron.log 2>&1`

This will start the backup script on the 5th minute of every hour. If you have any
problems take a look at the log file in the `github_backup` folder.