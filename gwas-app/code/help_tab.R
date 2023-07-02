documentation_tab <- function() {
  tabPanel("Help",
           fluidPage(width = 12,
                     fluidRow(column(
                       6,
                       h3("Genome Wide Association Studies (GWAS)"), 
                       p("This RShiny mini-app allows you to easily visualise the results from GWAS, which is a hypothesis-free mothod for identifying associations between genetic regions and traits
                         (e.g. diseases). This kind of studies search for ", strong("Single-Nucleotide Polymorphisms (SNPs)"), " , which are small variations in the genetic 
                         code. Through GWAS, it is possible to identify SNPs that occur more frequently in certain diseases"),
                       p("The results are displayed in a ", strong("Manhattan plot"), "which shows the -log10(p-value) against the position in the genome. The signficace
                         threshold for this studies is p = 5 x 10", tags$sup("-8.")),
                       h4("How use the mini-app"),
                       p("The data being used by the app is the HapMap dataset from the manhattanly R package, to use a different dataset you should store the 
                         csv file in the data folder" ),
                       
                       tags$ol(
                         tags$li("The first tab displays an ", strong("interactive Manhattan plot"), ", the red line shows the significace threshold and the blue line shows the suggestive line. 
                                 Hovering the moues over the SNPs will display the variant information. Using the options on the left-side bar, the user can change
                                 the color scheme, choose to display one or multiple chromosomes, select the size of the points and remove the suggestive ans siginificance
                                 lines."), 
                         
                         tags$li("The second tab prints a ", strong("Circular Manhattan plot."), 
                                 "This plot is also interactive, you can change the color scheme using the options on the left."),
                         tags$li("In the third tab builds a ", strong("Quantile-quantile (QQ) plot, "), 
                                 "which are probability plots used to compare two probability distributions by plotting their quantiles against each other. In GWAS
                                 , the QQ plot is a graphical representation of the deviation of the observed p-value against the expected p-values from a 
                                 theoretical distribution"), 
                         tags$li("Finally, the fourth tab build the ", strong("SNP density plot, "), "which shows the number of candidate variants in consecutive 100-kb regions")
                       )
                     ),
                     column(
                       6,
                       h3("Walkthrough video"),
                       tags$video(src="gwas_captions.mp4", type="video/mp4", width="100%", height="350", frameborder="0", controls = NA),
                       p(class = "nb", "NB: This mini-app is for provided for demonstration purposes, is unsupported and is utilised at user's 
                       risk. If you plan to use this mini-app to inform your study, please review the code and ensure you are 
                       comfortable with the calculations made before proceeding. ")
                       
                     ))
                     
                     
                     
                     
           ))
}