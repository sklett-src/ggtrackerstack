# ggtrackerstack
Project to run the whole ggtracker stack in vagrant

### Running
 * Make sure you have vagrant+virtualbox installed on your computer
 * Run `vagrant up` to create the virtual box
 * Run `vagrant ssh` to ssh into the vagrant box
 * Find code in /vagrant
 * Run the installation and updating steps of the components (ESDB and ggtracker) ([will be automated soon](https://github.com/gravelweb/ggtrackerstack/commit/e3bdbb30d9384d37e8b96692af81cefd5f8a87d2))
   * ESDB: https://github.com/dsjoerg/esdb#installation-and-setup
   * ggtracker: https://github.com/dsjoerg/ggtracker#basic-installation-and-updating
     * Note: You need to run ggtracker webapp like this `ESDB_HOST=172.28.128.3:9292 foreman start` (change ip accordingly)
 * Set up Amazon AWS S3 buckets for development as described in [esdb/config/s3.yml.example](https://github.com/dsjoerg/esdb/blob/master/config/s3.yml.example) (only dev and test are needed) and set up buckets and credentials accordingly in `esdb/config/s3.yml`.
 * Set up a hostname for the vagrant box's ip in /etc/hosts - e.g. `172.28.128.3 ggtracker.test` (change ip accordingly)
 * The app will be on `ggtracker.test` in the browser and uploading should work - otherwise please raise an issue here, so it can be fixed.
