library(shiny)
library(terra)

species <- c("Eastern oyster", "Blue crab", "White perch", "Blue catfish")
vals <- sapply(species, function(.) {
  rast(ncol=10, nrow=10, nlyr=1, vals=rnorm(10*10))
},
simplify = FALSE)


# Define UI for app that draws a histogram ----
ui <- fluidPage(

  # App title ----
  titlePanel("Physiological habitat suitability"),
  
  helpText(
    'Note: This page was slow to load as all of the\n',
    'calculations were done in your browser, rather than\n',
    'a server at CBL.\n',
    'The actual application will load much more quickly.'
  ),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    # Sidebar panel for inputs ----
    sidebarPanel(

      # Input: Slider for the number of bins ----
      selectInput("species", "Select species",
                  choices = c("Eastern oyster", "Blue crab", "White perch", "Blue catfish")),

    ),

    # Main panel for displaying outputs ----
    mainPanel(

      plotOutput("plot")

    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  output$plot <- renderPlot({
    plot(vals[[input$species]], main = input$species)
    })

}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
