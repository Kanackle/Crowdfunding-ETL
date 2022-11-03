-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT cp.cf_id, cp.outcome, cp.backers
FROM campaign as cp
WHERE (outcome = 'live')
ORDER BY cp.backers desc

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT COUNT(bd.backer_id), bd.cf_id 
FROM backers as bd
GROUP BY bd.cf_id
ORDER BY COUNT(bd.backer_id) desc 


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
--SELECT co.first, co.last, co.email
--INTO email_contacts_remaining_goal_amount 
--FROM campaign as cp
--LEFT JOIN contacts as co
--ON (cp.contact_id = co.contact_id)
--WHERE (cp.outcome = 'live')
	

--SELECT * FROM email_contacts_remaining_goal_amount
--ORDER BY remaining_goal_amount desc

--DROP TABLE email_contacts_remaining_goal_amount

-- Adds a new column to existing table
--ALTER TABLE email_contacts_remaining_goal_amount
--ADD COLUMN remaining_goal_amount numeric

--Add data based on another column to existing column
--UPDATE email_contacts_remaining_goal_amount
--SET remaining_goal_amount = 1000 (set command gives the whole column a flat value) 
--FROM campaign as cp;

--KEEPING THE CODE ABOVE FOR FUTURE REFERENCE

-- Check the table
SELECT CN.first,
       CN.last,
       CN.email,
       (CP.goal-CP.pledged) AS "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM contacts as CN
JOIN campaign as CP
ON CP.contact_id = CN.contact_id
WHERE CP.outcome = 'live'
ORDER BY "Remaining Goal Amount" DESC;

SELECT * FROM email_contacts_remaining_goal_amount

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT bk.cf_id,
		bk.first_name,
		bk.last_name,
		bk.email,
		ca.company_name,
		ca.desc,
		ca.end,
		(ca.goal-ca.pledged) AS "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM backers as bk
JOIN campaign as ca
ON bk.cf_id = ca.cf_id
ORDER BY bk.email desc

-- Check the table
SELECT * from email_backers_remaining_goal_amount

DROP TABLE email_backers_remaining_goal_amount
