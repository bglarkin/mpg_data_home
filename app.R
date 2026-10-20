# MPG Data Home
# Resource content lives here so titles, descriptions, and URLs are easy to update.
library(shiny)
library(bslib)

resources <- list(
  list(
    title = "MPG Weather Data",
    credit = "Designed by Erik Samsoe",
    description = paste(
      "Filter, explore, and download daily weather summaries from six MPG Ranch",
      "weather stations. Compare conditions across stations and dates for research",
      "and field planning."
    ),
    url = "https://mpg-data.shinyapps.io/weather/",
    source = "https://github.com/samsoe/mpg_weather_warehouse",
    update = paste(
      "Coming soon: more recent weather data and a move to Posit hosting",
      "to improve performance."
    )
  ),
  list(
    title = "MPG Ranch Ecology Tools",
    credit = "Designed by Kyle Doherty",
    description = paste(
      "Explore environmental variation across MPG Ranch, compare environmentally",
      "similar sites, and download survey-point information. Supports survey design,",
      "native seed collection, and restoration planning."
    ),
    url = "https://mpgranch.shinyapps.io/ecology_tools/",
    source = "https://github.com/mosscoder/mpg_ecology_tools",
    update = NULL
  ),
  list(
    title = "Native Seed Inventory",
    credit = "Maintained by Chuck Casper and Kenzie Sebastian",
    description = paste(
      "View MPG's native seed inventory in Airtable. Contact Chuck or Kenzie",
      "with questions about the inventory or updates."
    ),
    url = "https://airtable.com/appf1cF9iAiODto6X/shrS7n91K0oezP11A/tblyDe8Kvv8L3MK9Z",
    source = NULL,
    update = NULL
  ),
  list(
    title = "MPG VegData Finder",
    credit = "Designed by Beau Larkin",
    description = paste(
      "Find and download MPG Ranch vegetation survey data by location, species,",
      "or plant functional group. Browse reference photos and export data,",
      "location files, and survey-planning materials."
    ),
    url = "https://bglarkin-mpg-plant-finder.share.connect.posit.cloud/",
    source = "https://github.com/bglarkin/mpg_plant_finder",
    update = NULL
  ),
  list(
    title = "MPG Sage Thinning Planner",
    credit = "Designed by Beau Larkin",
    description = paste(
      "View sage presence and vole-related mortality alongside herbaceous",
      "vegetation composition and past thinning treatments. Use the map to",
      "consider potential vegetation responses when planning sage thinning."
    ),
    url = "https://bglarkin-sage-thinning-planner.share.connect.posit.cloud/",
    source = "https://github.com/bglarkin/sage_thinning_planner",
    update = NULL
  )
)

# Optional: set MPG_FEEDBACK_EMAIL locally or in Connect's environment settings.
# Until an address is configured, feedback goes to the repository's issue page.
feedback_email <- trimws(Sys.getenv("MPG_FEEDBACK_EMAIL", unset = ""))
feedback_url <- if (nzchar(feedback_email)) {
  paste0("mailto:", feedback_email, "?subject=MPG%20Data%20Home%20feedback")
} else {
  "https://github.com/bglarkin/mpg_data_home/issues/new"
}

external_link <- function(label, url, class = NULL) {
  tags$a(label, href = url, class = class,
         target = "_blank", rel = "noopener noreferrer")
}

resource_card <- function(resource) {
  tags$article(
    class = "resource-card",
    tags$h2(resource$title),
    tags$p(class = "resource-credit", resource$credit),
    tags$p(class = "resource-description", resource$description),
    if (!is.null(resource$update)) {
      tags$p(class = "resource-update", resource$update)
    },
    tags$div(
      class = "resource-links",
      external_link(paste("Open", resource$title), resource$url, "btn btn-primary"),
      if (!is.null(resource$source)) external_link("Source on GitHub", resource$source)
    )
  )
}

ui <- page_fluid(
  title = "MPG Data Home",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#315a48"),
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
  tags$div(
    class = "home-shell",
    tags$header(
      class = "home-header",
      tags$p(class = "eyebrow", "MPG RANCH"),
      tags$h1("MPG Data Home"),
      tags$p(class = "intro", "A starting point for MPG staff to find data, explore tools, and plan field work."),
      tags$p(class = "link-hint", "Resource links open in a new tab.")
      # Future images in www/ can be added here with tags$img(src = "logo.png", alt = "MPG Ranch").
    ),
    tags$main(
      id = "resources",
      `aria-label` = "Staff resources",
      tags$div(class = "resource-grid", lapply(resources, resource_card))
    ),
    tags$footer(
      class = "home-footer",
      tags$h2("Help keep this page useful"),
      tags$p("Have a new tool to share, a broken link, or a suggestion?"),
      if (nzchar(feedback_email)) {
        tags$a("Email feedback", href = feedback_url)
      } else {
        external_link("Share feedback on GitHub", feedback_url)
      }
    )
  )
)

# This directory needs no reactive logic or data connections.
server <- function(input, output, session) {}

shinyApp(ui = ui, server = server)
