## Running locally

A [vagrant](https://www.vagrantup.com/) file has been included to remove the inconsistencies of developing across multiple operating systems (*cough* Windows *cough*). You can spin up the environment with the following command:

```
vagrant up
```

Once the VM is up and running you can ssh into it using `vagrant ssh` and navigate the `/vagrant` directory. On the first run of the VM you will need to install the dependencies by running:

```
bundle install
```

Once the dependencies are installed you can run the site with the following command:

```
bundle exec jekyll serve --host 0.0.0.0
```

Now you should be able to browse the site at http://localhost:4000. You need to specify `0.0.0.0` as the host otherwise you will not be able to view the site on the host machine.