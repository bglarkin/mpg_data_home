# MPG Data Home

A small Shiny directory of MPG staff tools. Resource titles, descriptions, credits,
URLs, and optional update notes are maintained in the `resources` list in `app.R`.
No data files, database connections, or supporting R scripts are required.

## Local use

Open `mpg_data_home.Rproj`, run `renv::restore()` once, then `shiny::runApp()`.
The project uses Shiny and bslib; `renv.lock` records their dependencies and the
R version used for development. Use a compatible R version when restoring.

## Images and feedback

Put the future logo and photo in `www/` alongside `styles.css`. Shiny serves
this folder automatically: use `tags$img(src = "logo.png", alt = "MPG Ranch")`
without the `www/` prefix. Files here are available to app visitors.

Set `MPG_FEEDBACK_EMAIL` in your local environment or in Posit Connect's content
environment settings to enable the footer's email link. Until configured, the
footer links to this repository's GitHub issue form. No email address is assumed.

## Eventual Posit deployment

The app has not been deployed. Confirm the target Connect server supports the R
version in `renv.lock`. After editing dependencies, run `renv::snapshot()`.

For Posit Connect, configure your account with `rsconnect`, then publish the
project directory using RStudio's Publish button or `rsconnect::deployApp()`.
Install `rsconnect` as a publishing tool if needed; the running app does not use it.
For a Git-backed Connect deployment, generate and commit `manifest.json` with
`rsconnect::writeManifest()` in the restored project before configuring deployment.
Regenerate the manifest whenever dependencies or bundled files change.
Connect Cloud's GitHub publishing can use the included `renv.lock` directly.

Select the staff audience/access settings in Connect when publishing. There are
no credentials or data connections to configure for this directory. Do not commit
Connect API keys, `.Renviron`, local package libraries, or deployment credentials.
