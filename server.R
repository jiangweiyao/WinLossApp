#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(lattice)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    library(lattice)
    
    loss <- seq(0,1,by=0.01)
    win <- seq(0, 1,by=0.01)
    
    grid <- expand.grid(x=loss, y=win)
    grid$ret <- ((1 * (1-grid$x) * (1+grid$y))-1)*100       
    colnames(grid) <- c("loss", "win", "return")
    
    
    

    wl <- reactive({
        winf <- 1+input$win/100
        lossf <- 1-input$loss/100
        ret <- ((1 * winf * lossf)-1)*100
        round(ret, digits = 3)
    })
    
    wlpoint <- reactive({
        df2 <- data.frame(input$loss, input$win)
        colnames(df2) <- c("loss", "win")
        return(df2)
    })
    
    output$WinLoss <- renderText({ 
        paste(wl(),"%")})
    
    output$WLplot<-renderPlot({
        ggplot(grid, (aes(loss * 100, win * 100)))+geom_tile(aes(fill = return))+scale_fill_gradient2(low = "red", mid = "white", high = "green")+
            geom_point(data = wlpoint(), aes(x = loss, y = win), shape=23, fill="blue", color="darkred", size=3)+
            theme_bw() + theme(axis.text=element_text(size=12), axis.title=element_text(size=14,face="bold"))+
            geom_abline(slope = 1, intercept = 0)+coord_cartesian(xlim = c(0,100), ylim = c(0,100))+scale_y_continuous(expand = c(0,0))+scale_x_continuous(expand = c(0,0))+
            xlab("Percent Loss") +ylab("Percent Win")
    },
                #if(is.null(input$win)){
        #    p <- ggplot(df, aes(x = loss*100, y = win*100, color = "red"))+geom_line()+xlab("Percent Loss")+ylab("Percent Win")
        #} else{
        #    p <- ggplot(df, aes(x = loss*100, y = win*100))+geom_line()+xlab("Percent Loss")+ylab("Percent Win")+geom_po           
        #}
        
    )

    
})
