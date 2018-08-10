# Spindle

http://spindle-frontend.s3-website.eu-west-2.amazonaws.com/

An app to collect apprentices' blog posts in one place.

Spindle is built using:

- [Elm](http://elm-lang.org/)
- [Serverless](https://serverless.com/)
- [Postgres](https://www.postgresql.org/)

## Get up and running

### Installing dependencies

To get up and running make sure you have [Elm](https://guide.elm-lang.org/install.html), [Node](https://nodejs.org/en/download/) and [Postgres](https://www.postgresql.org/download/) installed.

Install the serverless cli with:

```sh
> npm i -g serverless
```

Install dependencies in both the `frontend` and `api` directories: `cd` into both directories and run:

```sh
> npm install
```

### Adding seed data to Postgres

For running the app locally and for testing create two postgres databases (`spindle_dev` and `spindle_test`)

To add data to the dev database `cd` into the `api` directory and run:

```sh
> npm run seeds
```

This will create the tables and add the default authors

To fetch the most recent posts for the authors:

```sh
> npm run scrape-posts:local
```

This will invoke the `scrapePosts` lambda locally and store each author's posts in the dev database

### Running the Dev environment

Frontend: `cd` into `frontend` and run

```sh
> npm run dev
```

Api: `cd` into `api` and run

```sh
> npm run dev
```

If you'd like to fetch the posts from the dev database via the Elm app (rather than the production api) change the `authorsUrl` in the `Request.Author` module to `http://localhost:3000/posts`

## Running tests

Run the test suites for `api` and `frontend` in each directory with

```sh
> npm test
```

## Contributions

Suggestions and PRs are welcome! Please leave an issue first here https://github.com/Gabbendorf/spindle/issues
