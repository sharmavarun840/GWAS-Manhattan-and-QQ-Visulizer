

####################
###### SERVER ######
####################


function(input, output, session) {

    # Fix for mini_app greying-out after 10 min of inactivity
    autoInvalidate <- reactiveTimer(10000)
    observe({
        autoInvalidate()
        cat(".")
    })

    data <- reactive({
        if (input$choose_data == ""){
            return(NULL)
        }
        
        file <- file.path("data", paste(input$choose_data))
        read.csv(file)
    })
    
    # Read in data ------------------------------------------------------------------------
    gwas <- reactive({
        data() %>% select (CHR, SNP, BP, P)
        })
    gwas_cm <- reactive({
        data() %>% select(SNP, CHR, BP, P)
        })
    
    
    # 1st Tab - INTERACTIVE MANHATAN PLOT --------------------------------------------------
    
    output$interactive_manhattan <- renderPlotly({
        
        cols = switch(   
            input$color,   
            "Grey"= c("#4D4D4D","#999999"),
            "Blue"= c("#104E8B", "#00BFFF"),  
            "Blue & Orange"=  c("#00008B", "#CD8500"), 
            "Earth"= c("#d9bb9c", "#28231e", "#4b61ba", "#deb7a0", "#a87963"),
            "Rainbow"= c("#4197d8", "#f8c120", "#413496", "#495226",
                         "#d60b6f", "#e66519", "#d581b7", "#83d3ad", "#7c162c", "#26755d")
        ) 
        
        if (input$suggest) suggest_y <- -log10(1e-5) else suggest_y <- FALSE
        if (input$geno) geno_y <- -log10(5e-08) else geno_y <- FALSE

        
        if (is.null(input$chr)){
            
            manhattanly(gwas(), 
                        snp="SNP", 
                        point_size= input$point,                                # Change of point size 
                        col=cols,                                               # Change colors of the graph
                        suggestiveline = suggest_y,                             # Suggestive line (value or FALSE)
                        genomewideline = geno_y)                                # Suggestive line (value or FALSE)

        } else {
            manhattanly(subset(gwas(), CHR %in% paste(input$chr, sep = ",")),     # Subset of selected chromosomes 
                        snp = "SNP",
                        point_size = input$point,                               # Change of point size
                        col = cols,                                             # Change colors of the graph
                        suggestiveline = suggest_y,                             # Suggestive line (value or FALSE)
                        genomewideline = geno_y,                                # Significance line (value or FALSE)
                        )
        }
    })
    
    # 2nd Tab - CIRCULAR MANHATAN PLOT --------------------------------------------------

    # Construct the plot if we have valid parameters
    output$manhattan_plot <- renderPlot({
        
        cols = switch(   
            input$colour_scheme,   
            "Grey"= c("grey30","grey60"),
            "Blue"= c("dodgerblue4", "deepskyblue"),  
            "Blue & Orange"=  c("blue4", "orange3"), 
            "Earth"= c("#d9bb9c", "#28231e", "#4b61ba", "#deb7a0", "#a87963"),
            "Rainbow"= c("#4197d8", "#f8c120", "#413496", "#495226",
                         "#d60b6f", "#e66519", "#d581b7", "#83d3ad", "#7c162c", "#26755d")
        )   
        

            if (input$circ_type == 'outw') outward <- TRUE else outward <- FALSE
            
            CMplot(gwas_cm(),                                                     
                   type = "p",                                                  # p = point type
                   plot.type="c",                                               # c = circular plot
                   chr.labels = paste("", c(1:22), sep=""),                     # chromosomes levels
                   col=cols,                                                    # Color scheme
                   H=6000,                                                      # Height for each circle 
                   cex=0.4,                                                     # Point size
                   signal.cex=0.7,                                              # Point size for significant points
                   threshold.lty=c(1,2),                                        # type of threshold line
                   threshold.col=c("red","blue"),                               # Color for the threshold lines
                   signal.line=1,                                               # Thickness of the lines
                   signal.col=c("red","green"),                                 # Color of the significant lines
                   threshold=c(5e-8, 1e-5),                                     # Significant threshold levels
                   outward=outward,                                             # Type of graph, outward/inward
                   cir.legend.col="black",                                      # Color of the legend
                   cir.chr.h=700,                                               # Width of the boundary   
                   chr.den.col= NULL,                                           # Density plot will not be around the graph 
                   file.output=FALSE)                                           # Not output the plot results
        
    })
    
    # 3rd Tab - QQ Plot --------------------------------------------------
    
    output$qq_plot <- renderPlot({
        
        #qq(gwas$P)
        CMplot(gwas_cm(), 
               plot.type="q",                                                   # q = QQ plot 
               file.output=FALSE,                                               # Not output the plot results
               mar=c(2, 2, 2, 2),                                               # Margins
               main=NULL,                                                       # Title 
               cex.lab = 1,                                                     # Size of X/Y labels
               ylim=c(0, 20),                                                   # Limit Y axis
               col='black',                                                     # Color scheme
               conf.int=input$qqplot_conf,                                      # Show confidence interval
               conf.int.col=NULL,                                               # Color of CI
               threshold.col="red",                                             # Color threshold
               threshold.lty=2)                                                 # Type of threshold line
    })
    
    # 4th Tab - SNP DENSITY --------------------------------------------------
    
    output$snp_density <- renderPlot({
        CMplot(gwas_cm(), 
               type="p",                                                        # p = point
               plot.type="d",                                                   # d = density 
               bin.size=1e6,       
               chr.den.col=c("darkgreen", "yellow", "red"),                     # Color for the SNP density
               file.output=FALSE)                                               # Not output the plot results
    })
    
    
    
}
