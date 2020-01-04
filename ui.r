library(shiny)

shinyUI(fluidPage(
  
  titlePanel(title=strong("Details of the Dataset" )),
  
  sidebarLayout(
    sidebarPanel(

# fileinput() function is used for controlling the option to upload the file      
      fileInput("file","Upload your file",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")), 
      
      helpText("File size should not exceed 3MB"),

#divide with light grey line
            tags$hr(),
      
      h5(helpText("Select below parameters to read the file")),
      
      checkboxInput(inputId = 'header', label = 'Header', value = TRUE),
      checkboxInput(inputId = "stringAsFactors", "stringAsFactors", FALSE),

#breakline
            br(),
      
      radioButtons(inputId = 'sep', label = 'Separator', choices = c(Comma=',',Semicolon=';',Tab='\t', Space=''), selected = ','),
      
    ),
    
    mainPanel(
     uiOutput("op"),
      
    )
    
  )
))