SELECT * FROM sp500.financials;

# Check for missing values
SELECT Company, Symbol, Sector, Price, P_E, DY, E_S, MarketCap, P_S, EBITDA, P_B
FROM sp500.financials
WHERE Symbol IS NULL;

#Checking unique values
SELECT DISTINCT Sector from sp500.financials;
SELECT DISTINCT Company from sp500.financials;

# Total obs
SELECT COUNT(Company) AS TotalNumberOfCompanies
FROM sp500.financials;
SET @V1 := (SELECT COUNT(Company) FROM sp500.financials);
SELECT @v1;

# Share of setors in the total
Select Sector, Round(count(company)/@v1*100,1) as Percentage_of_total_companies
FROM sp500.financials
Group by Sector;

# Percentage of total marketcap per sector
SELECT sum(MarketCap) AS MarketCapSP500
FROM sp500.financials;
SET @V2 := (SELECT sum(MarketCap) FROM sp500.financials);
SELECT @v2;
Select Sector, round(sum(MarketCap)/@v2*100,1) as Percentage_of_total_marketcap
FROM sp500.financials
Group by Sector;

# Percentage of total marketcap per company
Select Symbol, round(sum(MarketCap)/@v2*100,1) as Percentage_of_total_marketcap
FROM sp500.financials
Group by Symbol;

# Finance ratios per sector
Select Sector, Round(avg(P_E),1), Round(avg(E_S),1), Round(avg(DY),1), Round(avg(P_S),1), Round(avg(P_B),1) 
From sp500.financials
Group by Sector;

# Top 5 profitable companies
Select Symbol, Max(EBITDA) 
From sp500.financials
Group by EBITDA	
Order by 2 desc
Limit 5;

# Top 5 least profitable
Select Symbol, min(EBITDA) 
From sp500.financials
Group by EBITDA	
Order by 2 asc
Limit 5;

# Top 5 with min E/S
Select Symbol, min(E_S)
From sp500.financials
Group by E_S	
Order by 2 asc
Limit 5;
Select Symbol, max(E_S)
From sp500.financials
Group by E_S	
Order by 2 desc
Limit 5;

# Top 5 with min P/E
Select Symbol, min(P_E)
From sp500.financials
Group by P_E	
Order by 2 asc
Limit 5;
Select Symbol, max(P_E)
From sp500.financials
Group by P_E	
Order by 2 desc
Limit 5;