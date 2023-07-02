
################
###### UI ######
################


navbarPage(
  title = "GWAS Results Analysis",
  windowTitle = "GWAS App",
  # 1st Tab - INTERACTIVE MANHATAN PLOT --------------------------------------------------

  
  tabPanel(
    "Interactive Manhattan Plot",

    # Side bar -----------------------------------------------

    sidebarLayout(
      sidebarPanel(

        # Select data
        
        selectInput(
          inputId = "choose_data",
          label = "Choose a dataset",
          choices = tables
        ),
        
        # Select color scheme

        selectInput("color", "Choose colour scheme:",
          list("Grey", "Blue", "Blue & Orange", "Earth", "Rainbow"),
          selected = "Rainbow"
        ),

        # Select chromosomes

        selectizeInput("chr", "Choose the chromosomes you want to plot:",
          choices = 1:22,
          multiple = TRUE
        ),

        # Select point size

        sliderInput(
          inputId = "point",
          label = "Select the point size",
          min = 1,
          max = 10,
          step = 0.05,
          value = 5
        ),

        # Option to make suggestive/significance lines visible or not

        checkboxInput(
          inputId = "suggest",
          label = "Suggestive line",
          value = TRUE
        ),
        checkboxInput(
          inputId = "geno",
          label = "Genome-wide significance line",
          value = TRUE
        ),
      ),

      # Main Panel -----------------------------------------------

      mainPanel(

        # Text before the graph

        p("Hover the mouse over a point in the plot to inspect its annotation information, such as the SNP identified and GENE name. 
                            A menu will appear in the upper-right corner of the graph, this allows to zoom in on a region of interest and export the image as a .png file"),

        # Graph output

        plotlyOutput("interactive_manhattan")
      )
    )
  ),


  # 2nd Tab - CIRCULAR MANHATAN PLOT --------------------------------------------------


  tabPanel(
    "Circular Manhattan plot",

    sidebarLayout(

      # Side bar -----------------------------------------------

      sidebarPanel(

        # Color scheme

        selectInput("colour_scheme", "Colour scheme:",
          list("Grey", "Blue", "Blue & Orange", "Earth", "Rainbow"),
          selected = "Rainbow"
        ),


        # Options for circular Manhattan plot

        radioButtons("circ_type", "Type", c("Inward plot" = "inw", "Outward plot" = "outw"), selected = "inw")
      ),

      # Main Panel -----------------------------------------------

      mainPanel(
        # A caption will be displayed above the chart
        h3(textOutput(outputId = "caption", container = span)),

        # Plot Output
        plotOutput("manhattan_plot",
          height = "800px",
          width = "800px"
        ),
      )
    )
  ),

  # 3rd Tab - QQ PLOT --------------------------------------------------

  tabPanel(
    "QQ Plot",

    # Side bar --------------------------------------------

    sidebarLayout(
      sidebarPanel(
        "QQ Plot",

        # Option to include confidence interval

        checkboxInput(
          inputId = "qqplot_conf",
          label = "Include confidence interval",
          value = FALSE
        ),
      ),

      # Main panel ----------------------------------------

      mainPanel(

        # Plot output

        plotOutput("qq_plot")
      )
    )
  ),


  # 4th Tab - SNP DENSITY --------------------------------------------------


  tabPanel(
    "SNP Density",

    sidebarLayout(
      sidebarPanel(),

      # Main panel -----------------------------------------------

      mainPanel(
        plotOutput("snp_density")
      )
    )
  ),

  # 5th Tab - HELP --------------------------------------------------

  tabPanel(
    "Help",

    # Function with the help tab

    documentation_tab(),
  )
)
