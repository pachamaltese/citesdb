context("Data")

test_that("CITES data source hasn't changed", {
  skip_on_cran()
  tmpf <- tempfile()
  response <- httr::GET("https://trade.cites.org/cites_trade/download_db",
                        httr::write_disk(tmpf, overwrite = TRUE))
  if (httr::http_error(response)) {
    message("CITES data source not responding")
  }
  hash <- tools::md5sum(tmpf)
  unlink(tmpf)
  skip_if(httr::http_error(response))
  expect_equivalent(hash, "d64d99182bdfb3696f6ce91687ccdd81")
})
