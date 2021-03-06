TrendDetectionChannel<- function(TS, n=20, DCSector=1/3) {
  if (!is.OHLC(TS)) {
    stop("Price series must contain Open, High, Low and Close.")
  }
  Channel <- DonchianChannel2(cbind(Hi(TS),Lo(TS)), n=n)
  UpTrend <- Cl(TS) > Lo(Channel)+(Hi(Channel)-Lo(Channel))*(1-DCSector)
  DownTrend <- Cl(TS) < Lo(Channel)+(Hi(Channel)-Lo(Channel))*DCSector
  NoTrend <- !(UpTrend | DownTrend)
  Trend <- UpTrend+ DownTrend*(-1)
  result <- cbind(UpTrend, NoTrend, DownTrend, Trend)
  colnames(result) <- c("UpTrend", "NoTrend", "DownTrend", "Trend")
  return(result)
}