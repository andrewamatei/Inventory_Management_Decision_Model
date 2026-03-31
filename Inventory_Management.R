cat("\014") # clears console
rm(list = ls()) # clears global environment
try(dev.off(dev.list()["RStudioGD"]), silent = TRUE)
# clears plots
try(p_unload(p_loaded(), character.only = TRUE), silent = TRUE)
# clears packages
options(scipen = 100) # disables scientific notion for entire R session

library(pacman)
p_load(tidyverse)
p_load(ggplot2)
p_load(optimx)
p_load(MASS)
p_load(triangle)
p_load(data.table)
p_load(stats)
p_load(triangle)
p_load(fitdistrplus)



#Model Parameters
annual_demand <- 15000
cost_per_unit <- 80
holding_cost_rate <- 0.18 
cost_per_order <- 220
#order_quantity      #decision variable


#Holding cost_per_unit
holding_cost_per_unit = cost_per_unit * holding_cost_rate
holding_cost_per_unit
#Mathematical functions

average_inventory <- function(order_quantity_f) {
  return(order_quantity_f / 2)
}

num_of_orders_per_year <- function(annual_demand_f, order_quantity_f) {
  return(annual_demand_f / order_quantity_f)
}


annual_ordering_cost <- function(cost_per_order_f, num_of_orders_per_year_f) {
  return(cost_per_order_f * num_of_orders_per_year_f)
}


annual_holding_cost <- function(holding_cost_per_unit_f, average_inventory_f) {
  return(holding_cost_per_unit_f * average_inventory_f)
}


total_inventory_cost <- function(order_quantity_f, demand){
  return(annual_ordering_cost(cost_per_order, num_of_orders_per_year(demand, 
                                                                     order_quantity_f))
         + annual_holding_cost(holding_cost_per_unit, average_inventory(order_quantity_f)))
}

#total_inventory_cost(700, 13000)

# order quantity to minimize total cost
optimization_results <- optimize(total_inventory_cost,
                                 interval = c(1, 15000), demand=15000)
optimization_results



#One way analysis

order_quantities <- seq(300, 1000, by = 10)

total_costs <- sapply(order_quantities, total_inventory_cost, demand=15000)

plot(order_quantities, total_costs, type = "l", col = "blue", 
     xlab = "Order Quantity", ylab = "Total Cost", 
     main = "Total Cost vs Order Quantity")





#PART 2

# Sample from the triangular distribution for annual demand
set.seed(1234) 
simulated_demands <- rtriangle(n = 1000, a = 13000, b = 17000, c = 15000)
simulated_demands


# Calculate the total inventory cost for each simulated demand
simulated_costs <- sapply(simulated_demands, function(demand) {
  optimized_result <- optimize(total_inventory_cost,
                               interval = c(2, 15000), demand=demand)
  return(c(optimized_result$objective, optimized_result$minimum))
})

simulated_costs

#-----------------------------------------------------------------------------------------------------------------------------------------

# Extract costs and minimum order quantities
costs <- simulated_costs[1, ]  # Total costs for each simulation
order_quantities <- simulated_costs[2, ]  # Order quantities that minimize the cost

# Find the minimum total cost from the simulations
min_total_cost <- min(costs)
min_total_cost


# Calculate the mean and standard deviation of the simulated costs
mean_costs <- mean(costs)
mean_costs

sd_costs <- sd(costs)
sd_costs

# Calculate the 95% confidence interval for the expected minimum total cost
error_margin <- qt(0.975, length(costs) - 1) * sd_costs / sqrt(length(costs))

CI_costs <- c(mean_costs - error_margin, mean_costs + error_margin)
CI_costs


# Determine the best-fitting probability distribution

hist(costs)

result <- hist(costs)
result


# Verify the validity of the chosen distribution using a goodness-of-fit test

# Step 1: Bin the data
bins <- seq(min(costs), max(costs), length.out = 15)
observed <- hist(costs, breaks = bins, plot = FALSE)$counts

# Step 2: Calculate expected frequencies

p <- pnorm(bins, mean = mean_costs, sd = sd_costs)
expected <- diff(p) * length(costs)


chisq_results <- chisq.test(x = observed, p = expected, rescale.p = TRUE)
chisq_results

pchisq(26.505, df=13)




#--------------------------------------------------------------------------------------------------------------------------------------------------


# Calculate the mean and standard deviation of the order quantities
mean_order_quantity <- mean(order_quantities)
sd_order_quantity <- sd(order_quantities)

# Calculate the 95% confidence interval for the expected order quantity
error_margin_order_quantity <- 
  qt(0.975, length(order_quantities) - 1) * sd_order_quantity / 
  sqrt(length(order_quantities))
CI_order_quantity <- 
  c(mean_order_quantity - error_margin_order_quantity, mean_order_quantity + 
      error_margin_order_quantity)
CI_order_quantity

# Determine the best-fitting probability distribution
hist(order_quantities)

result_1 <- hist(order_quantities)
result_1


# Verify the validity of the chosen distribution using a goodness-of-fit test

bins_quantities <- seq(min(order_quantities), max(order_quantities), length.out = 10)
observed_quantities <- hist(order_quantities, breaks = bins_quantities, plot = FALSE)$counts

# Step 2: Calculate expected frequencies

prob <- pnorm(bins_quantities, mean = mean_order_quantity, sd = sd_order_quantity)
expected_quantities <- diff(prob) * length(order_quantities)


chisq_results_1 <- chisq.test(x = observed_quantities, p = expected_quantities, rescale.p = TRUE)
chisq_results_1

pchisq(13.342, df=8)

#----------------------------------------------------------------------------------------------------------

#Given Parameters
cost_per_order <- 220  # Cost per order

# Function to calculate the number of orders per year for a given demand
annual_num_of_orders <- function(demand) annual_demand / demand

# Calculate the number of orders per year for each simulated demand
annual_num_orders_simulated <- sapply(simulated_demands, annual_num_of_orders)

mean_annual_orders <- mean(annual_num_orders_simulated)
mean_annual_orders

sd_annual_orders <- sd(annual_num_orders_simulated)
sd_annual_orders

# Calculate the 95% confidence interval for the expected order quantity
error_margin_annual_orders <- 
  qt(0.975, length(annual_num_orders_simulated) - 1) * sd_annual_orders / 
  sqrt(length(annual_num_orders_simulated))

CI_annual_orders <- 
  c(mean_annual_orders - error_margin_annual_orders, mean_annual_orders + 
      error_margin_annual_orders)

CI_annual_orders

# Determine the best-fitting probability distribution
hist(annual_num_orders_simulated)

result_2 <- hist(annual_num_orders_simulated)
result_2


# Verify the validity of the chosen distribution using a goodness-of-fit test

bins_orders <- seq(min(annual_num_orders_simulated), max(annual_num_orders_simulated), length.out = 10)

observed_orders <- hist(annual_num_orders_simulated, breaks = bins_orders, plot = FALSE)$counts

# Step 2: Calculate expected frequencies

prob_order <- pnorm(bins_orders, mean = mean_annual_orders, sd = sd_annual_orders)
expected_order <- diff(prob_order) * length(annual_num_orders_simulated)


chisq_results_2 <- chisq.test(x = observed_orders, p = expected_order, rescale.p = TRUE)
chisq_results_2

pchisq(21.387, df=8)
