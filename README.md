# Inventory Management Decision Model

## Overview

This project develops a prescriptive inventory management model to support cost-effective ordering decisions in a manufacturing setting. The analysis examines both fixed-demand and variable-demand scenarios to identify order quantities that reduce total inventory cost.

The project combines Economic Order Quantity, EOQ, modeling, what-if analysis, and Monte Carlo simulation to evaluate how ordering cost, holding cost, and demand uncertainty affect inventory decisions.

## Objective

The goal of this project is to determine the order quantity that minimizes total inventory cost while balancing:

- ordering costs
- holding costs
- demand uncertainty

## Tools Used

- Microsoft Excel
- R
- Monte Carlo simulation
- What-if analysis
- Solver optimization

## Project Structure

The analysis is divided into two parts.

### Part I, Fixed Demand Model

This section assumes constant annual demand and uses a standard inventory cost model to determine the optimal order quantity.

Key inputs:

- Annual demand: 15,000 units
- Cost per unit: $80
- Holding cost rate: 18%
- Ordering cost per order: $220

Key outputs:

- Optimal order quantity: about 677 units
- Average inventory: about 338.5 units
- Annual number of orders: about 22.16
- Annual ordering cost: $4,874.42
- Annual holding cost: $4,874.42
- Total inventory cost: $9,748.85

### Part II, Variable Demand Model

This section extends the model by introducing uncertain demand through a triangular probability distribution and Monte Carlo simulation.

Demand assumptions:

- Lower bound: 13,000 units
- Most likely value: 15,000 units
- Upper bound: 17,000 units

Simulation details:

- 1,000 iterations
- Triangular demand distribution

Key findings:

- Minimum simulated total cost: $9,093.92
- Mean simulated total cost: about $9,752.90
- 95% confidence interval for total cost: about $9,736.10 to $9,769.70

The simulation shows how demand variability affects ordering strategy and overall cost, highlighting the value of adaptive inventory planning.

## Model Logic

The model uses the following inventory relationships:

- Holding Cost per Unit = Holding Cost Rate × Cost per Unit
- Average Inventory = Order Quantity / 2
- Number of Orders per Year = Annual Demand / Order Quantity
- Annual Ordering Cost = Number of Orders × Ordering Cost per Order
- Annual Holding Cost = Average Inventory × Holding Cost per Unit
- Total Inventory Cost = Annual Ordering Cost + Annual Holding Cost

## Key Insights

- The EOQ-based approach provides a cost-efficient baseline for fixed demand conditions.
- Demand uncertainty changes the cost structure and makes static ordering decisions less reliable.
- Monte Carlo simulation helps estimate how variable demand affects total cost, order quantity, and order frequency.
- Combining optimization and simulation provides a stronger basis for inventory decision-making than relying on fixed assumptions alone.

## Files

- `ALY6050_MOD4_Project_AmarteiA.docx` , project report
- `ALY6050_Module4_Project_AndrewA.xlsx` , Excel model and analysis workbook

## Use Case

This project is useful for:

- inventory planning
- operations analysis
- supply chain decision-making
- prescriptive analytics demonstrations
- business analytics portfolios

## Author

Andrew Amartei
