# Forking Recipes

<a href="https://assembly.com/forking-recipes/bounties"><img src="https://asm-badger.herokuapp.com/forking-recipes/badges/tasks.svg" height="24px" alt="Open Tasks" /></a>

## Version control for recipes

This is a product being built by the Assembly community. You can help push this idea forward by visiting [https://assembly.com/forking-recipes](https://assembly.com/forking-recipes).

### How Assembly Works

Assembly products are like open-source and made with contributions from the community. Assembly handles the boring stuff like hosting, support, financing, legal, etc. Once the product launches we collect the revenue and split the profits amongst the contributors.

Visit [https://assembly.com](https://assembly.com) to learn more.

### Running the app

#### Requirements
* With brew: `brew install fig`
* Without brew:
  * Install [Docker](https://docs.docker.com/installation/) (requires boot2docker on mac)
  * Install [Fig](http://www.fig.sh/install.html)

#### Build and Setup
Container setup
```
fig build
fig up
```

Just like on your local, run your setup commands.
```
fig run web rake db:setup
fig run web rake db:setup RAILS_ENV=test
```

#### Development

Speed up your development workflow by running guard. Currently uses guard livereload.
`fig run web guard`

Use `boot2docker ip` to get the ip of your web container and then go to _containerip_:3000 in your browser.

#### Testing

Run your tests!
`fig run web rspec`
