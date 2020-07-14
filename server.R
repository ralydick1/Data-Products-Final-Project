library(shiny)

server <- shinyServer(function(input, output) {
        
        values <- reactiveValues()
        # Calculate the amount and interest
        observe({
                input$Calc
                codes <- c(1,0.25,0.0833)
                freq <- isolate({as.numeric(input$freq)})
                freq <- codes[freq]
                values$int <- isolate({input$loan_amt * input$int_rate * freq / 100 * input$period})
                values$amt <- ({isolate(input$loan_amt) + values$int})
                values$mthpay <- values$amt / (input$period * 12)
        
                # Display values entered
                output$text_loan_amt <- renderText({
                        input$Calc
                        paste("Loan amount ($): ", isolate(input$loan_amt))
                 })
        
                output$text_int_rate <- renderText({
                      input$Calc
                      paste("Interest rate: ", isolate(input$int_rate), 
                      "% per year")
                })
        
                output$text_period <- renderText({
                        input$Calc
                        labs <- c('Years', 'Quarters', 'Months')
                        freq_lab <- as.integer(isolate({input$freq}))
                        freq_lab <- labs[freq_lab]
                        paste("Duration: ", isolate(input$period)," ", freq_lab)
                })
        
                # Display calculated values
        
                output$text_intr <- renderText({
                        if(input$Calc == 0){""}
                        else
                        paste("Interest ($):", values$int)
                })
        
                output$text_amtplus <- renderText({
                        if(input$Calc == 0){""}
                        else 
                        {paste("Total Amount due, with Interest ($):", values$amt)}
                })
        
                output$text_mthpay <- renderText({
                        if(input$Calc == 0){""}
                        else 
                        {paste("Reccomended Monthly Payment ($):", values$mthpay)}
                })
        })
})