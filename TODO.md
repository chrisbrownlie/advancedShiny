# Plan/To Do

## Basic principles
- shinydashboard layout
- a module per tab to keep code easy to navigate/maintain
- using fluid structure { fluidRow() -> column(width=..) -> shinydashboardPlus::box(width=NULL) } as the basis for every tabs ui
- each box: single topic; valid title; solid header; consistent status/colours; collapsible & closable where desired
- include code snippets where possible/appropriate, using the code_snippet() function (see R/fct_utils.R)
- file naming conventions adhered to for any functions etc. that are required

## Plan for each tab:
(Bullet points indicate rough/minimum points to cover, initials in brackets indicate who will complete)

- [x] Info (CB)
    - What the app is
    - How to use it
    - Important points

### SECTION 1
- [x] What is Shiny, actually? (CB)
    - What a web app is
    - How shiny converts R to HTML, JS and CSS
    - Shiny dependencies (httpuv etc.)

- [x] Understanding reactivity (CB)
    - How reactivity makes a pull relationship look like a push relationship
    - Graph showing the flushing cycle and reactive graph
    - reactlog

- [x] Using reactivity (CB)
    - Types of object (reactive values, expressions, outputs)
    - When to use reactive vs observe
    - Including observeEvent vs eventReactive

- [x] Controlling reactivity (CB)
    - Using debounce & throttle
    - Using invalidateLater & reactivePoll
    - Using isolate & req

- [x] Structuring an app (CB)
    - As a package
    - File naming conventions
    - Workflow (using roxygen2, devtools, usethis etc.)
    - Making use of reactivevalues not being copy-on-modify
    - Using modules (briefly mention, covered in next tab)

- [x ] Shiny modules (CB)
    - The 1000 button problem
    - Namespacing
    - Using modules effectively

### SECTION 2
- [ ] Improving UI with CSS
    - Key choices when designing shiny apps - choice between shinydashboard[Plus] or shiny+bslib (or other)
    - What is CSS and how to include in shiny
    - Using Sass

- [ ] Improving UX with JS
    - What is JS
    - Ways to include JS in shiny
    - Some example use cases
    - Briefly mention shinyjs (covered in next tab)

- [ ] The attaliverse
    - What is attaliverse
    - List all the packages
    - shinyjs
    - Some details of each, minimum include some detail for each of (shinyalert, shinycssloaders, shinydisconnect, shinybrowser)

- [ ] Extending shiny (CB)
    - The power of javascript
    - Packages which extend/improve shiny (e.g. shinyhelper, shinyFeedback, shinyEffects)
    - Creating your own widget with htmlwidgets

- [ ] Custom shiny inputs (CB)
    - Types of inputs in shiny & other packages
    - Input bindings and events
    - Creating your own input element
    - charpente

### SECTION 3
- [ ] The session object (CB)
    - Apps, sessions and users
    - Elements of the session object and what they are useful for
    - DfE-specific

- [ ] Tracking usage
    - Why it can be useful
    - Custom methods (observers, save to sql etc.)
    - shinylogs

- [ ] Advanced Visualisation 1 (plotly)
    - The basics of plotly
    - plotly vs ggplot2
    - Possibilities with plotly

- [ ] Advanced Visualisation 2 (r2d3 + other js libs) (CB)
    - When to use r2d3 vs plotly/ggplot2
    - Extent of control
    - How to use js visualisations in shiny

- [ ] Error handling & Debugging
    - base R error handling (tryCatch, withRestarts)
    - shiny-specific error handling (validate, safeError)
    - unit testing (briefly) and shiny testing (shinytest, testServer, testModule)
    - whereami

- [ ] Optimisation
    - profvis
    - Caching
    - Async/futureverse
