rankhospital <- function(state, outcome, num = "best") {
        ## Read in the data.
        raw <- data.frame()
        raw <- read.csv("outcome-of-care-measures.csv", stringsAsFactors = FALSE, 
                        na.strings = "Not Available")[, c(2,7,11,17,23)]
        
        ## Tests for errors in the inputs
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
        ## sort the output column from smallest to biggest, then
        ## get rid of the NA's in the output column, then
        ## isolate the Hospital column.
        byState <- byState[ order(byState$Hospital), ]
        hosName <- byState[ order(byState$Outcome), ]
        hosName <- hosName[!with(hosName,is.na(hosName$Outcome)),]
        cleanData <- hosName$Hospital
        
        ## Check to see whether "num" is numeric, "best" or "worst".
        ## Three if statements below...numeric returns the 1st, "best" returns the 2nd, and
        ## "worst" returns the 3rd.
        numVect <- c("best", "worst")
        numMatch <- match(num, numVect, nomatch = NULL)
        if(is.na(numMatch)) {
                return(cleanData[num])
        }
        if(numMatch == 1) {
                return(cleanData[1])
        }
        if(numMatch == 2) {
                hosName <- byState[ order(-byState$Outcome), ]
                hosName <- hosName[!with(hosName,is.na(hosName$Outcome)),]
                cleanData <- hosName$Hospital
                cleanData[1]
        }
}