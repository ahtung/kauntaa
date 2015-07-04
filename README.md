# kauntaa

A personal counter

[![Circle CI](https://circleci.com/gh/dunyakirkali/kauntaa.png?circle-token=f174742eaf65e547a254e8a3df6d511704ac8ab4)](https://circleci.com/gh/dunyakirkali/kauntaa)

## Tech

- Rails 4.2.1
- Foreman
- Foundation
- Postgresql
- Chromedriver

## Pre

    brew install chromedriver

## Development

    foreman start -f Procfile.dev -e Procfile.dev.env

## Tasks

    foreman run -e Procfile.dev.env rake spec
    foreman run -e Procfile.dev.env rake style
    foreman run -e Procfile.dev.env rake security
    foreman run -e Procfile.dev.env rake doc
    foreman run -e Procfile.dev.env rake quality

### Security

Run ``` foreman run -e Procfile.dev.env rake security ``` and use ``` brakeman ```

### Documentation

Run ``` foreman run -e Procfile.dev.env rake doc ``` and open docs with ``` open doc/index.html ```

## Deploy

### Auto

Once a PullRequest is merged into the master branch, Github will trigger a build on CircleCI.
CircleCI will do ``` circle.yml ``` and eventually deploy to heroku.

### Manual

    ./script/deploy/staging
    ./script/deploy/production
