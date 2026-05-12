-- Query 1: Dataset Size
SELECT COUNT(*) 
FROM tickets_dataset;

-- Query 2: Ticket Status
SELECT status, COUNT(*)
FROM tickets_dataset
GROUP BY status;

-- Query 3: Issue Type ( we have 5 different types of issues)
SELECT issue_type, COUNT(*)
FROM tickets_dataset
GROUP BY issue_type;

--Query 4: SLA Breach Count
SELECT sla_breach, COUNT(*)
FROM tickets_dataset
GROUP BY sla_breach;

-- KPI 1: SLA Breach Percentage
SELECT 
COUNT(*) AS total_tickets,
SUM(CASE WHEN sla_breach = 'Yes' THEN 1 ELSE 0 END) AS breached_tickets,
ROUND(
SUM(CASE WHEN sla_breach = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
2
) AS breach_percentage
FROM tickets_dataset;
--KPI output : 27.61% of tickets breached SLA.
---This means roughly 1 out of 4 tickets exceeded the expected resolution time, 
---which may indicate operational inefficiencies or workload imbalance among support agents.

--KPI 2 : Agent workload Distribution
--TO ensure Fair workload distribution and avoid agent burnout
Select agent_id, Count(tickets) 
From tickets_dataset
Group By agent_id
ORDER BY Count(tickets) DESC
Limit 5; -- shows top 5 agents
--Business Insight : Top agent handled 234 tickets 
--while the least active agent handled ~160 tickets.
--Resume Insight - Analyzed agent workload distribution using SQL, identifying ticket handling variations across 
--support agents and potential workload imbalance.

--KPI 3 : Agent Resolution Performance
Select agent_id,
ROUND(AVG(resolved_time_hours),2) AS avg_resolution_time
FROM tickets_dataset
Group BY agent_id
ORDER BY avg_resolution_time
Limit 3;
-- This query helps us find top 3 agents with least avg resoluiton time
--making them top 3 performing agents as per avg resolution time among the 50 agents 

--KPI 4 : Csat_score_analysis
SELECT
ROUND(AVG(csat_score),2) as avg_csat_score,
MIN(csat_score) As lowest_score,
MAX(csat_score) As Highest_score
FROM tickets_dataset;
--Analyzed customer satisfaction across 10,000 support tickets,
--finding an average CSAT score of 3.9/5, indicating generally
--positive support experience with opportunities for improvement.
--Good average results in : faster resolutions
--better agent communication
--effective issue handling

--KPI 5 : Escalation Analysis : how many tickets were escalated to higher support levels
Select escalation_flag, COUNT(tickets)
From tickets_dataset
GROUP BY escalation_flag;
--Escalation indicates : complex issues
--support limitations
--cases requiring senior expertise
--Evaluated escalation patterns across 10,000 support tickets,
--finding only 6.6% required escalation, demonstrating strong
--frontline support level capability.

-- AGENT Ranking Analysis Using Window Function as per the number of tickets they closed
Select agent_id , COUNT(tickets) AS ticket_handled,
RANK() OVER(ORDER BY COUNT(tickets) DESC) AS agent_workload_rankings
FROM tickets_dataset
GROUP BY agent_id
-- We ranked agents(agents_id), with their respective number of tickets closed, 
--ranked in Desc. order from rank 1 for highest number of ticket closer agent,
-- to lowest number of tickets closer agent ranked 50 (as we have total 50 agents) 

--Team Wise Sla_breach Rate analysis using CTE and CASE
WITH team_sla AS (
    SELECT 
        team,
        COUNT(*) AS total_tickets,
        SUM(CASE WHEN sla_breach = 'Yes' THEN 1 ELSE 0 END) AS breached
    FROM tickets_dataset
    GROUP BY team
)

SELECT 
team,
total_tickets,
breached,
ROUND(breached * 100.0 / total_tickets,2) AS breach_rate
FROM team_sla
ORDER BY breach_rate DESC;
--Team 2 → 32.08% breach rate (highest)
--Team 5 → 27.26% breach ratel (lowest)
--Team 2 shows the highest SLA breach rate, suggesting potential
--operational inefficiencies or higher ticket
--complexity compared to other teams.
