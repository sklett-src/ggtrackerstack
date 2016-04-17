# ggtrackerstack
Project to run the whole ggtracker stack in vagrant

### Running
 * Make sure you have vagrant+virtualbox installed on your computer
 * Run `git submodule update --init` to pull submodules
 * Run `vagrant up` to create the virtual box. This will download all required packages and go through the installation process for ggtracker and ESDB (~15 minutes; go make yourself a sandwich)
 * Run `vagrant ssh` to ssh into the vagrant box
 * Find code in /vagrant `cd /vagrant`
 * Start the application (requires 2 ssh sessions, or run them as background jobs)
   * ESDB: `(cd esdb && foreman start)`
   * ggtracker: `(cd ggtracker && ESDB_HOST=172.28.128.3:9292 foreman start)` (change IP accordingly)
 * Set up Amazon AWS S3 buckets for development as described in [esdb/config/s3.yml.example](https://github.com/dsjoerg/esdb/blob/master/config/s3.yml.example) (only dev and test are needed) and set up buckets and credentials accordingly in `esdb/config/s3.yml`. All buckets need to be [publicly readable](https://ariejan.net/2010/12/24/public-readable-amazon-s3-bucket-policy/) and the replay bucket needs to have [CORS enabled for GET, PUT and POST](http://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html).
 * The app will be on the ip of the vagrant box and uploading a replay should work - otherwise please raise an issue here, so it can be fixed.
