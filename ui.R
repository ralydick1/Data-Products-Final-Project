library(shiny)

# Define UI for application that calculates Loan repayments
ui <- shinyUI(fluidPage(
    # Application title
    titlePanel("Loan Repayment Calculator"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            numericInput("loan_amt",
                         label=h6("Enter the loan amount in USD"),
                         value=1000),
            br(),
            sliderInput("int_rate",
                        label=h6("Interest rate Percantage"),
                        min = 0, max = 25,value = 7.5),
            sliderInput("period",
                        label=h6("Enter loan repayment duration"),
                        min=0,max=120,value=7),
            selectInput("freq",
                        label=h6("Duration freqeuncy?"),
                        choices= list("Years"=1,
                                      "Quarters"=2,
                                      "Months"=3),
                        selected=1),
            br(),
            br(),
            actionButton("Calc",label="Calculate!")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           tabPanel("Output",
                    p(h5("Values entered:")),
                    textOutput("text_loan_amt"),
                    textOutput("text_int_rate"),
                    textOutput("text_period"),
                    textOutput("text_freq"),
                    br(),
                    p(h5("Calculated amount:")),
                    textOutput("text_intr"),
                    textOutput("text_amtplus"),
                    textOutput("text_mthpay"),
                    br()
           ),
           tabPanel("Documentation",
                    p(h4("Loan Calculator:")),
                    br(),
                    helpText("This loan calulator computes monthly payment of a loan with interest"),
                    HTML("<u><b> Equation : </b></u>
                         <br><br>
                         <b> A = P + I = P(1 +rt) ; R = r * 100 </b>
                         <br>
                         where: <br>
                         A = Total amount Paid (Initial Loan + Interest) <br>
                         P = Initial Loan Amount <br>
                         I = Interest <br>
                         r = Interest rate per year <br>
                         t = duration in years/quarters/months")
                    )
        )
    )
))

# Run the application 
shinyApp(ui = ui, server = server)
