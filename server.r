library(shiny)

shinyServer(function(input,output){
  
#Accept the input file from UI.R and use them for read.table() to read the data from the file. It returns the dataset in the form of a dataframe.
  # file$datapath -> gives the path of the file
  data <- reactive({
    file1 <- input$file
    if(is.null(file1)){return()} 
    read.table(file=file1$datapath, sep=input$sep, header = input$header, stringsAsFactors = input$stringAsFactors)
    
  })
  
#To show the Summary of the input file in a table format
  output$filedf <- renderTable({
    if(is.null(data())){return ()}
    input$file
  })
  
  
#To show the Structure of the input file
  output$fileob <- renderPrint({
    if(is.null(input$file)){return ()}
    str(input$file)
  })


  
  
#this reactive output contains the summary of the dataset and display the summary in table format
  output$sum <- renderTable({
    if(is.null(data())){return ()}
    summary(data())
    
  })
  
  
# To display the dataset in a table format
  output$table <- renderTable({
    if(is.null(data())){return ()}
    data()
  })
  
#Whenever any new file is uploaded renderUI function dynamically generate the tabsets. The app will not show tabset until the file is uploaded.
  output$op <- renderUI({
    if(is.null(data()))
      
#Message and Image on the main panel when no file is uploaded      
      h4("The details (File Info, Data, Structure, Summary) to be shown in the below panel after your dataset file is uploaded:", 
         br(),
         br(),
         tags$img(src='1.jpg', heigth=400, width=350))
    
    else
      tabsetPanel(tabPanel("File Info", tableOutput("filedf")),
                  tabPanel("Data", tableOutput("table")),
                  tabPanel("Structure", verbatimTextOutput("fileob")),
                  tabPanel("Summary", tableOutput("sum")))
  })
})