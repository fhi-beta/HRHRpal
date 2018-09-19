context("ProtectIdentifier")

test_that("Basic", {
  data <- data.frame(id=c(
    1001,
    1001,
    1002,
    1001,
    1003,
    1003
    ))
  data$weight <- c(41,42,43,44,45,46)

  res <- ProtectIdentifier(data=data,identifier = "id", seed=4)

  expected <- data.table(
    id=c(3,3,1,3,2,2),
    weight=c(41,42,43,44,45,46)
  )

  testthat::expect_equal(res,expected)
})

