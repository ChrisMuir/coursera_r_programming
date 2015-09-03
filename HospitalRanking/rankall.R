rankall <- function(outcome, num = "best") {
        ## Read in the data.
        raw <- data.frame()
        raw <- read.csv("outcome-of-care-measures.csv", stringsAsFactors = FALSE, 
                        na.strings = "Not Available")[, c(2,7,11,17,23)]
        
        ## Create the blank dataframe that will be returned as the final output.
        output <- data.frame()
        
        ## Tests for errors in the inputs
        outcomeVect <- c("heart attack", "heart failure", "pneumonia")
        outcomeMatch <- match(outcome, outcomeVect, nomatch = NULL)
        if(is.na(outcomeMatch)) {
                stop("invalid outcome")
        }
        
        ## Get rid of the "outcome" columns that are not needed (written as 3 IF statements, 
        ## and the function input "outcome" will determine which IF statement is used).
        if(outcomeMatch == 1) {
                df <- raw[, c(1,2,3)]
        }
        if(outcomeMatch == 2) {
                df <- raw[, c(1,2,4)]
        }
        if(outcomeMatch == 3) {
                df <- raw[, c(1,2,5)]
        }
        
        ## Name the columns
        names(df) <- c("hospital", "state", "outcome")
        
        ## Alphabetize the hospital column, in the event of a tie, then
        ## sort by state, then
        ## get ride of the NA's in the output column.
        hosNameAlpha <- df[ order(df$hospital), ]
        hosName <- hosNameAlpha[ order(hosNameAlpha$state), ]
        df <- hosName[!with(hosName,is.na(hosName$outcome)),]
        
        ## Create a DF with one column, that lists all the states (this is one half of the
        ## final output DF).
        statesDF <- data.frame(state= character(54))
        statesDF$state <- unique(df$state)
        
        ## Create a vector that will house the eventual output hospitial names list (this
        ## vector will house the second half of the final output DF).
        fullNamesVect <- vector(mode = "character")
        
        ## Create a vector that's a list of all the unique states
        statesList <- unique(df$state)
        
        ## Check to see whether "num" is numeric, "best" or "worst".
        ## Three if statements below...numeric returns the 1st, "best" returns the 2nd, and
        ## "worst" returns the 3rd.
        ## EAch IF statement contains a for loop that compiles the correct hospital name for
        ## each state based on the "outcome" and "num" from the input of the function.
        numVect <- c("best", "worst")
        numMatch <- match(num, numVect, nomatch = NULL)
        
        ## 1st IF STATEMENT, FOR NUMERIC NUM:
        if(is.na(numMatch)) {
                for (n in statesList) {
                        byState <- subset.data.frame(df, state == n)
                        sortHos <- byState[ order(byState$outcome), ]
                        isoHos <- sortHos$hospital
                        fullNamesVect[n] <- isoHos[num]
                }
                
                ## Take the for loop vector and turn it into a DF.
                hosDF <- data.frame(hospital= character(54))
                hosDF$hospital <- fullNamesVect
                
                ## cbind the state names DF with the hospital names DF, which gives the final output.
                output <- cbind(hosDF, statesDF)
                return(output)
        }
        
        
        
        ## 2nd IF STATEMENT, FOR "best" NUM:
        if(numMatch == 1) {
                for (n in statesList) {
                        byState <- subset.data.frame(df, state == n)
                        sortHos <- byState[ order(byState$outcome), ]
                        isoHos <- sortHos$hospital
                        fullNamesVect[n] <- isoHos[1]
                }
                
                ## Take the for loop vector and turn it into a DF.
                hosDF <- data.frame(hospital= character(54))
                hosDF$hospital <- fullNamesVect
                
                ## cbind the state names DF with the hospital names DF, which gives the final output.
                output <- cbind(hosDF, statesDF)
                return(output)
        }
        
        
        ## 3rd IF STATEMENT, FOR "worst" NUM:
        if(numMatch == 2) {
                for (n in statesList) {
                        byState <- subset.data.frame(df, state == n)
                        sortHos <- byState[ order(-byState$outcome), ]
                        isoHos <- sortHos$hospital
                        fullNamesVect[n] <- isoHos[1]
                }
                
                ## Take the for loop vector and turn it into a DF.
                hosDF <- data.frame(hospital= character(54))
                hosDF$hospital <- fullNamesVect
                
                ## cbind the state names DF with the hospital names DF, which gives the final output.
                output <- cbind(hosDF, statesDF)
                return(output)
        }
}