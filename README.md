# Forking Recipes

<a href="https://assembly.com/forking-recipes/bounties"><img src="https://asm-badger.herokuapp.com/forking-recipes/badges/tasks.svg" height="24px" alt="Open Tasks" /></a>

## Version control for recipes

This is a product being built by the Assembly community. You can help push this idea forward by visiting [https://assembly.com/forking-recipes](https://assembly.com/forking-recipes).

### How Assembly Works

Assembly products are like open-source and made with contributions from the community. Assembly handles the boring stuff like hosting, support, financing, legal, etc. Once the product launches we collect the revenue and split the profits amongst the contributors.

Visit [https://assembly.com](https://assembly.com) to learn more.

### Running the app

Install fig and Docker (boot2docker for a mac)

```
fig build
fig up
fig run web rake db:create
fig run web rake db:migrate
```

Use `boot2docker ip` to get the ip of your web container and then go to ip:3000 in your browser.
