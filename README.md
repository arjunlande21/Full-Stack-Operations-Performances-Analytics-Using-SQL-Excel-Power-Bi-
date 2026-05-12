# Full-Stack-Operations-Performances-Analytics-Using-SQL-Excel-Power-Bi-
Operations Performance Analytics
Project Summary Report
What We Did · How We Did It · What We Found

Executive Summary
This project is a complete, end-to-end operations analytics case study built from the perspective of a Business/Data Analyst working in service-based operations environments — the kind of analytical work performed daily at firms like Teleperformance, Genpact, Concentrix, and Deloitte's operations practice.
The project analyzed 10,000 customer support tickets across a 3-month operational window (January–March 2026), spanning 50 agents organized into 5 teams across 3 shifts. The entire analytical pipeline was executed using three industry-standard tools — Microsoft Excel, SQL, and Power BI — each applied for a distinct analytical purpose that could not be replicated by the others alone.

10,000
Tickets Analyzed	84.93%
Closure Rate	27.61%
SLA Breach Rate	3.90/5
Avg CSAT	6.61%
Escalation Rate	50
Agents Tracked

Section 1: What We Did — Project Scope & Objectives
The project was scoped around five core business objectives that mirror real operational analyst KPIs:
•	SLA Compliance Monitoring — Track the rate at which tickets breach the 48-hour resolution SLA threshold
•	Agent Performance Evaluation — Assess agent workload distribution, resolution speed, and ranking
•	Customer Satisfaction Analysis — Measure CSAT scores across the full ticket population
•	Escalation Pattern Identification — Understand why and at what rate tickets require senior intervention
•	Operational Efficiency Benchmarking — Compare teams against each other across key performance metrics

The dataset was built to simulate real-world operations data with 18 fields per ticket record, including ticket metadata, resolution timing, agent assignments, satisfaction scores, SLA breach flags, and escalation indicators.

Section 2: How We Did It — The Three-Tool Analytical Pipeline
The analysis followed a deliberate, sequential three-phase approach. Each tool was chosen because it offered capabilities the previous tool could not. This is intentional — it mirrors how analysts work in professional operations environments where Excel handles quick data prep, SQL handles scalable aggregation, and BI tools handle executive-facing visualization.

Phase 1: Microsoft Excel — Data Foundation & Pivot Exploration
📋  Why Excel First?
Excel is the entry point because it allows simultaneous data wrangling, formula-driven enrichment, and quick pivot exploration without requiring a database setup. It is the standard first-touch tool in any operations analytics workflow.

What We Did in Excel:
•	Ingested raw Tickets (10,000 rows) and Agents (50 rows) as structured Excel Tables
•	Enriched tickets with agent attributes via VLOOKUP: team assignment, shift (Morning/Evening/Night), experience level (Junior/Mid/Senior)
•	Engineered 6 computed columns: is_closed, resolved_time_hours, sla_breach, tat_days, month, and enriched agent fields
•	Built the KPI Summary Sheet with 8 aggregate metrics using COUNTA, COUNTIF, and AVERAGE formulas
•	Created 7 Pivot Tables for fast exploratory analysis: priority distribution, ticket status, agent performance, resolution time, issue type, monthly trend, and SLA team breakdown
•	Produced a Business Insight Analysis Sheet with structured finding → interpretation → recommendation rows

Key Excel Findings:
•	Ticket priority is uniformly distributed: High 34.05%, Low 32.94%, Medium 32.95% — no single tier dominates
•	84.93% closure rate — strong frontline resolution but 15% backlog deserves investigation
•	Agent workload spread: top agent handled 234 tickets, lowest handled ~160 tickets — 74-ticket gap signals imbalance risk
•	Average resolution time: 36.96 hours, with a 6.73-hour range between fastest (34.26 hrs) and slowest (40.99 hrs) agents
•	Issue types are evenly distributed at ~20% each — Technical issues lead marginally at 20.67%
•	Monthly volume: Jan 3,452 → Feb 3,191 → Mar 3,357 — moderate seasonal fluctuation of ~8%

Phase 2: SQL — Scalable KPI Computation & Advanced Segmentation
🗄️  Why SQL Second?
Excel Pivot Tables cannot perform window functions, multi-step CTEs, or conditional aggregation at scale without performance degradation. SQL was used to compute precise KPIs across all 10,000 records with reproducible, version-controlled queries — a non-negotiable requirement in enterprise data environments.

What We Did in SQL:
•	Computed SLA Breach Rate using SUM(CASE WHEN sla_breach = 'Yes') / COUNT(*) — result: 27.61%
•	Ranked agents by ticket volume using RANK() window function — produced full 50-agent leaderboard without exclusion
•	Computed CSAT statistics: AVG, MIN, MAX across all 10,000 tickets
•	Identified top 3 fastest-resolving agents using AVG(resolved_time_hours) with ORDER BY ASC + LIMIT 3
•	Analyzed escalation distribution — 6.61% escalated, 93.39% resolved at frontline
•	Built Team-wise SLA Breach Rate analysis using a CTE + CASE-WHEN pattern — the most advanced query in the project

Advanced SQL Techniques Applied:
Technique	SQL Pattern Used	Business Purpose
Conditional Aggregation	SUM(CASE WHEN ... END) / COUNT(*)	KPI computation without subqueries
Window Function Ranking	RANK() OVER (ORDER BY COUNT() DESC)	Full-population agent leaderboard
Common Table Expression (CTE)	WITH team_sla AS (...) SELECT ...	Multi-step team segmentation logic
Performance Benchmarking	ORDER BY avg_resolution_time ASC LIMIT 3	Top agent identification by speed

Key SQL Findings:
•	SLA Breach: 27.61% — 1 in 4 tickets exceeded the 48-hour SLA threshold — a critical KPI for service contracts
•	Team 2 is the highest SLA offender at 32.08% breach rate vs. Team 5 at 27.26% — a 4.82pp gap between best and worst teams
•	Escalation rate of 6.61% demonstrates strong frontline capability — industry benchmark is typically under 10%
•	CSAT average of 3.90/5 indicates broadly positive experience, with targeted improvement opportunities in low-scoring segments

Phase 3: Power BI — Executive Dashboard & Interactive Visual Storytelling
📊  Why Power BI Third?
Power BI transforms the analytical findings into a decision-ready visual layer. Unlike static Excel charts, Power BI enables cross-filtered slicers, real-time interactivity, and executive-grade visual storytelling — the standard output format for operations analytics teams.

What We Built in Power BI:
•	4 KPI Cards at the top: Total Tickets (10K), SLA Breach % (27.61%), Avg CSAT (3.90), Escalation % (6.61)
•	Donut Chart: Issue type distribution — 5 segments each at ~20%, showing multi-dimensional support demand
•	Bar Chart: Top 10 Agents by tickets handled — visual leaderboard with agent_id labelling
•	Shift & Priority Slicer: Dynamic Interactive Cross Filtering For (Evening / Morning / Night / Select All) and High, Low and Medium Priority tickets — enables cross-visual filtering in one click
•	Monthly Trend Chart: Jan 3.5K → Mar 3.4K → Feb 3.2K — volume trend with Y-axis scaling
•	Team SLA Breach Table: All 5 teams with breach rates and a grand total of 27.61% — scannable tabular format
•	Avg. Resolve Time Line Chart: Per-agent resolution trend — performance cohort visualization

Section 3: What We Found — Consolidated Findings & Business Recommendations
⚠️  Critical Finding 1 — SLA Compliance Gap (27.61% Breach Rate)
Nearly 1 in 4 tickets fails to meet the 48-hour SLA threshold. Team 2 is the primary offender at 32.08%. Immediate action: implement real-time SLA monitoring and route high-risk tickets proactively before breach occurs.

⚖️  Critical Finding 2 — Agent Workload Imbalance
A 74-ticket gap exists between the highest and lowest-volume agents. This creates burnout risk for top performers and underutilization of lower-volume agents. Recommendation: deploy load-balanced ticket routing with real-time agent capacity monitoring.

✅  Positive Finding 3 — Strong Frontline Resolution (6.61% Escalation)
Only 6.61% of tickets required escalation — demonstrating mature frontline capability. Industry benchmark is below 10%. This reflects effective agent training and appropriate ticket routing for the majority of support requests.

📈  Positive Finding 4 — Consistent CSAT Performance (3.90/5)
Average customer satisfaction score of 3.90/5 across 10,000 tickets reflects generally positive support quality. Correlating low-CSAT tickets with specific agents, issue types, and resolution times can unlock targeted quality improvements.

🔍  Strategic Finding 5 — Uniform Issue Distribution Requires Cross-Training
With all 5 issue types hovering near 20%, there is no single dominant support category. This demands agent cross-training across all categories rather than specialization, ensuring flexibility during demand shifts.

Section 4: How Each Tool Was Uniquely Essential
A critical design principle of this project was tool differentiation — each tool was used for analysis that the others genuinely could not perform as effectively:
Tool	Unique Contribution	Could Excel/SQL Alone Do This?
Excel	VLOOKUP table joins, formula column engineering, pivot exploration, business insight documentation	SQL can't do quick pivot exploration without schema setup; Power BI can't do raw formula-level data wrangling
SQL	RANK() window functions over all 50 agents; CTE-based multi-step team segmentation; precise conditional aggregation at 10K rows	Excel pivot tables cannot perform window functions or CTEs; Power BI DAX is not equivalent for ad-hoc SQL logic
Power BI	Interactive shift-level slicer filtering across all visuals simultaneously; executive KPI card layout; line chart trend across 12+ agents	Excel charts are static; SQL has no native visualization; neither supports real-time interactive cross-filtering

Section 5: Industry Techniques Applied
•	Performance Benchmarking — Comparing agent resolution times against cohort averages to identify outliers
•	Workload Distribution Analysis — Measuring ticket volume variance across agents to identify imbalance
•	SLA Compliance Monitoring — Tracking breach rates as a contractual and operational KPI
•	Cohort Ranking (Window Functions) — Ranking all 50 agents simultaneously by a shared performance metric
•	Team Segmentation Analysis (CTE) — Breaking down KPIs by organizational unit to identify underperforming teams
•	Customer Satisfaction (CSAT) Trending — Statistical summary of satisfaction scores across the full ticket population
•	Issue Type Segment Analysis — Decomposing support volume by category to inform training and routing decisions
•	Time Series Trend Analysis — Monthly volume tracking to support staffing forecasts and capacity planning
•	Interactive Dashboard Design — Building executive-ready sliceable visuals for operational decision-making

