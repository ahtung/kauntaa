# Kauntaa

A personal counter

# Tech

- Rails 4.2
- Foreman TODO
- Foundation TODO
- Postgresql

## Development

  foreman start -f Procfile.dev -e Procfile.dev.env

## Test

  foreman run rspec -e Procfile.test.env

## Production

  foreman start -f Procfile -e Procfile.env