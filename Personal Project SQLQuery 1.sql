-- Milan Billingsley 
-- SQL Personal Project
-- October/21/2022
-- Data and Challenges from https://www.superdatascience.com/pages/sql


-- Challenge 1 (Section 3) Consumer Complaints Challenge

--You work for a government agency as a Data Scientist. You have
--been supplied a dataset with consumer complaints received by financial
--institutions in 2013 - 2015.
--Data Source: http://www.consumerfinance.gov/data-research/consumer-complaints/

--Your task is to upload the data into a Database and perform some
--preliminary analysis:

--1)Find out how many complaints were received and sent on the same day
Select [Date Received], Count(*) as Daily_Complaints 
from Complaints$
group by [Date Received]

--2)Extract the complaints received in the states of New York
Select * from [dbo].[Complaints$] where [State Name] = 'NY'

--3)Extract the complaints received in the states of New York and California
Select * from [dbo].[Complaints$] where [State Name] = 'NY' or [State Name] = 'CA'

--4)Extract all rows with the word “Credit” in the Product field
Select * from [dbo].[Complaints$] where [Product Name] like '%credit%'

--5)Extract all rows with the word “Late” in the Issue field
Select * from [dbo].[Complaints$] where [Issue] like '%Late%'



-- Challenge 2 (Section 5) Console Game Sales

--You are an analytics consultant helping a console games company conduct
--market research. You have been supplied a dataset consisting of two files:
--1) ConsoleGames.csv— a historic list of all console games released
--between 1980 and 2015
--2) ConsoleDates.csv- a historic list of all console platforms (such as Wii,
--Play Station, Xbox) and information about them
--You have been tasked to upload the dataset into a Database and perform
--the following analytics:

--1. Calculate what % of Global Sales were made in North America
select *, NA_Sales+EU_Sales+JP_Sales+Other_sales as Global_Sales, 
Round((NA_Sales/NULLIF((NA_Sales+EU_Sales+JP_Sales+Other_sales), 0))*100,2) as Percent_NA_Sales 
from [dbo].[VGSales$]

--2. Extract a view of the console game titles ordered by platform name in
--Ascending order and Year of release in descending order
Select * from [dbo].[VGSales$] 
order by PLATFORM asc, year desc

--3. For each game title extract the first four letters of the publisher's name
Select Left(Publisher,4) from [dbo].[VGSales$]

--4. Display all console platforms which were released either just before
--Black Friday or just before Christmas (in any year)
Select * from [dbo].[Consols$] where month(firstretailavailability) = 12 or month(firstretailavailability) = 11

--5. Order the platforms by their longevity in ascending order (i.e. the
--platform which was available for the longest at the bottom)
Select *, Year(Discontinued)-Year(firstretailavailability) as Longevity_Years from [dbo].[Consols$]
order by Longevity_Years

--6. Demonstrate how to deal with the Game_Year column if the client
--wants to convert it to a different data type
begin tran
ALTER TABLE [dbo].[VGSales$] ALTER COLUMN [Year] varchar(25);
rollback tran

--7. Provide recommendations on how to deal with missing data in the file
--Some of the missing data would be quite easy to fill in simply by doing some basic research such as the 3 
--missing names, 5 missing platforms and 6 missing years. Other things would be more complicated such as the 
--missing sales numbers for the three markets (North America, European Union, and Japan). Depending on the 
--importance of this project, managment could chose to invest resources into the improvement of this data.



-- Challenge 3 (Section 7) The Vet's Clinic

--You are a Data Analyst assisting a veterinarian clinic make sense of their data. Their data is dispersed 
--across multiple csv files and they need you to first upload all of them to database and then perform the 
--following analytics:

--1. Extract information on pets names and owner names side-by-side
select * from [dbo].[Pets$]
join  [dbo].[Owners$] on [dbo].[Owners$].[OwnerID] = [dbo].[Pets$].[OwnerID]


--2. Find out which pets from this clinic had procedures performed 
select * from [dbo].[Pets$]
Join [dbo].['Procedures History$'] on [dbo].[Pets$].[PetID] = [dbo].['Procedures History$'].[PetID]

--3. Match up all procedures performed to their descriptions 
select * from [dbo].['Procedures History$']
join [dbo].[Procedures$] on [dbo].['Procedures History$'].[ProcedureSubCode] = [dbo].[Procedures$].[ProcedureSubCode]

--4. Same as above but only for pets from the clinic in question 
select * from [dbo].['Procedures History$']
join [dbo].[Procedures$] on [dbo].['Procedures History$'].[ProcedureSubCode] = [dbo].[Procedures$].[ProcedureSubCode]
join [dbo].[Pets$] on [dbo].['Procedures History$'].[PetID] = [dbo].[Pets$].[PetID]

--5. Extract a table of individual costs (procedure prices) incurred by owners of pets from the clinic in 
--question (this table should have owner and procedure price side-by-side)
Select * from [dbo].[Owners$]
join [dbo].[Pets$] on [dbo].[Owners$].[OwnerID] = [dbo].[Pets$].[OwnerID]
join [dbo].['Procedures History$'] on [dbo].[Pets$].[PetID] = [dbo].['Procedures History$'].[PetID]
join [dbo].[Procedures$] on [dbo].['Procedures History$'].[ProcedureSubCode]=[dbo].[Procedures$].[ProcedureSubCode]



--Everything here was done with my knowledge of SQL and the help of Google Searches.
--If you have any advice of feedback, please do not hesitate to reach out. 
--Thank you.
--End of SQL Personal Project 