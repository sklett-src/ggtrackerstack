# ggtrackerstack
Project to run the whole ggtracker stack in vagrant

### Running
 * Make sure you have vagrant+virtualbox installed on your computer
 * Run `git submodule update --init --remote --recursive` to pull the latest version of each submodule
 * Run `vagrant up` to create the virtual box. This will download all required packages and go through the installation process for ggtracker and ESDB (~15 minutes; go make yourself a sandwich)
 * Run `vagrant ssh` to ssh into the vagrant box
 * Make a note of your vagrant IP: In the text it prints out upon login it says IP address for eth1: 172.28.128.3 (potentially some other ip)
 * Find code in /vagrant `cd /vagrant`
 * Start the application (requires 2 ssh sessions, or run them as background jobs)
   * ESDB: `(cd esdb && foreman start)`
   * ggtracker: `(cd ggtracker && ESDB_HOST=172.28.128.3:9292 foreman start)` (change IP accordingly)
 * Set up Amazon AWS S3 buckets for development as described in [esdb/config/s3.yml.example](https://github.com/dsjoerg/esdb/blob/master/config/s3.yml.example) (only dev and test are needed) and set up buckets and credentials accordingly in `esdb/config/s3.yml` and `ggtracker/config/s3.yml`. All buckets need to be [publicly readable](https://ariejan.net/2010/12/24/public-readable-amazon-s3-bucket-policy/) and the replay bucket needs to have [CORS enabled for GET, PUT and POST](http://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html).
 * The app will be on the ip of the vagrant box and uploading a replay should work - otherwise please raise an issue here, so it can be fixed.

### Making changes to components
The components needed to run ggtracker.com are included in this project as submodules. We generally track the `master` branch of the official repos, except for sc2reader, which tracks the `upstream` branch.

##### Making changes to `ggtracker`, `esdb` and `ggpyjobs`
To make a change to `ggtracker`, `esdb` or `ggpyjobs` and testing that they work in your local setup, we recommended that you fork the component to your own github account and add the fork to your working copy of ggtrackerstack like this (using `esdb` forked to `nickelsen` as example):
 * Fork the component on github (e.g. nickelsen/esdb).
 * Go to the ggtrackerstack directory of the component (e.g. ggtracker, esdb or esdb/vendor/ggpyjobs).
 * Set your fork ssh url as the origin remote: `git remote set-url origin git@github.com:nickelsen/esdb.git`.
 * Add the official repo ssh url as the upstream remote: `git remote add upstream git@github.com:dsjoerg/esdb.git`.
 * Check your setup with `git remote -v` - should look like this (with your account instead of nickelsen).
```
origin  git@github.com:nickelsen/esdb.git (fetch)
origin  git@github.com:nickelsen/esdb.git (push)
upstream    git@github.com:dsjoerg/esdb.git (fetch)
upstream    git@github.com:dsjoerg/esdb.git (push)
```
 * Once your remotes are set up, you can branch off master of your fork (`git checkout -b <branch-with-fix>`), make your application changes, commit and push to your remote and create a pull-request against the official repo.
 * **Note:** If you work on `ggpyjobs`, you need to also make a pull-request to `esdb` to make `esdb` actually use your new and improved version of `ggpyjobs` (we'll hopefully automate this remote tracking at some point).
 * When the official repo changes (e.g. your pull-request is merged), you can update your working copy like this:
   * `git fetch upstream`
   * `git merge upstream/master`
 * You can sync your `master` branch to the `master` branch of the `upstream` like this:
   * `git checkout master`
   * `git fetch upstream`
   * `git merge upstream/master`
   * `git push origin master`

##### Making changes to `sc2reader`
Per default, `sc2reader` is managed by [requirements.txt](https://github.com/dsjoerg/ggpyjobs/blob/master/requirements.txt) in `ggpyjobs`. To work on `sc2reader` it is recommended to use the cloned submodule at the root of `ggtrackerstack` and install that in development mode on the vagrant box by issuing `python setup.py develop` in `/vagrant/sc2reader` after ssh'ing into the vagrant box. Forks and branches are managed as described above.
