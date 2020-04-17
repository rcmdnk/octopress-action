# octopress-action
Build and deploy [Octopress](http://octopress.org/) site.

Some options are optimized for [octogray](https://github.com/rcmdnk/octogray) theme.

## Examples


    steps:
    - uses: actions/checkout@v2
      with:
        submodules: recursive
    - uses: rcmdnk/octopress-action@v1
      with:
        git_user_email: rcmdnk@gmail.com
        git_user_name: rcmdnk
        ssh_key: ${{ secrets.SSH_KEY }}

## Inputs

Name | Description | Default | Required
-|:-|-|-
git_user_email| Email of git user to deploy. | - | Yes
git_user_name| User name of git user to deploy. | - | Yes
ssh_key| ssh key to deploy. | - | Yes
known_hosts| known_hosts entry for the destination server. | GitHub's key | No
generate_option| Option for 'rake generate, for octogray.| no_minify | No
deploy_option| Option for 'rake deploy', for octogray.| push_ex | No
