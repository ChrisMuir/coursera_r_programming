best <- function(state, outcome) {
        ## Read in the data.
        raw <- data.frame()
        raw <- read.csv("outcome-of-care-measures.csv", stringsAsFactors = FALSE, 
                        na.strings = "Not Available")[, c(2,7,11,17,23)]
        
        ## Tests for errors in the inputs.
        stateMatch <- match(state, unique(raw$State), nomatch = NULL)
        outcomeVect <- c("heart attack", "heart failure", "pneumonia")
        outcomeMatch <- match(outcome, outcomeVect, nomatch = NULL)
        if(is.na(stateMatch)) {
                stop("invalid state")
        }
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
        names(df) <- c("Hospital", "State", "Outcome")
        
        ## Keep only the rows that match the state that was searched
        byState <- subset.data.frame(df, State == state)
        
        ## Alphabetize the Hospital.Name column, in the event of a tie, then
        ## sort the outcome column from smallest to biggest, then
        ## get ride of the NA's in the outcome column, then
        ## isolate the hospital column.
        byState <- byState[ order(byState$Hospital), ]
        hosName <- byState[ order(byState$Outcome), ]
        hosName <- hosName[!with(hosName,is.na(hosName$Outcome)),]
        cleanData <- hosName$Hospital
        
        ## Return the first hospital from the Hospital.Name column.
        cleanData[1]
}