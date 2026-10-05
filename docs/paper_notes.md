# Card & Krueger (1994) Replication

## Research Question
What happens to employment when the minimum wage increases? 

I understand the empirical analysis as being broken into three stages.

Initially, using a difference-in-differences approach, Card and Krueger ask whether employment changed differently in New Jersey relative to eastern Pennsylvania following New Jersey's minimum wage increase.

Then, they examine whether employment changes were concentrated among the stores most affected by the policy, particularly low-wage stores.

Lastly, using GAP regressions, they ask whether stores facing larger required increases in wages experienced relatively different changes in employment. 
## Economic Motivation
Minimum wage policy raises an important empirical question because economic theory predicts that government mandated increases in wages may affect firms' demand for labour.  

## Conventional Economic Prediction
In the standard competitive labour-market model, a minimum wage set above the market equilibrium wage pushes the cost of labour higher and reduces the quantity of labour demanded.

## Card & Krueger's Empirical Objective
Card and Krueger investigate whether this conventional prediction is supported by evidence from New Jersey's 1992 minimum wage increase. They explore whether this theory holds up in real life.

## Natural Experiment
In April 1992, NJ increased its minimum wage from $4.25 to $5.05 while PA retained the federal minimum wage of $4.25. The fast-food industry was studied because it provided a relatively comparable setting across the two areas. The survey covered about 410 fast-food restaurants in two waves. The first survey wave preceded the increase, while the second was conducted several months afterward. This creates a treated group (NJ) and a control group (PA). 

## Treatment and Control
New Jersey (NJ) acts as the treatment group to assess the effect of the minimum wage increase on employment. Employment changes in Pennsylvania (PA) are observed as part of the control group to separate any industry or external factors aside from the observed treatment.

## Data
Fast-food restaurants are observed across NJ and PA before and after the treatment. The survey collected information about employment, wages, restaurant characteristics, prices, and other characteristics relevant to the analysis. 

## Outcome Variable
Card & Krueger observe full-time equivalent employment (FTE) as a common measure of employment. FTE includes full-time employees, managers, and part-time employees to capture employment more meaningfully. 
FTE = Full-time employees + Managers + 0.5(Part-time employees)

## Identification Strategy
DiD attempts to remove the employment change that might have happened regardless of the policy because of wider economic factors. It employs a parallel-trends assumption to capture a counterfactual. 

        DiD = (NJ after - NJ before) - (PA after - PA before)

If NJ and PA would have experienced similar employment changes in the absence of the NJ minimum-wage increase, then the change observed in PA can provide an estimate of what would have happened to NJ without the policy. 

## Identifying Assumption
The central assumption is that in the absence of the NJ minimum-wage increase, fast-food restaurant employment in both states would have changed similarly. The industry similarity and geographic proximity provide some support for this assumption, although they do not establish that parallel trends necessarily hold. 
(These features do not establish that the parallel-trends asuumption holds absolutely)

## Table 1
Table 1 shows the sample frame and response rates for the two survey waves. Wave 1 (February 15- March 4, 1992) was conducted before the NJ increase. Wave 2 (November 5 - December 31, 1992) was after the increase. 

- Wave 1 
total sample frame: 437 stores - (86.7) - 410 interviewed
NJ 364 - response rate (90.9) - 331 interviewed
PA 109 - response rate (72.5) - 79 interviewed
63 refused 

- Wave 2 
total sample frame: 410 stores - 399 interviewed
NJ 331 - 5 closed - 321 interviewed
PA  79 - 1 closed - 78 interviewed

## Table 2
Table 2 shows the characteristics of the restaurants. It compares characteristics between NJ and PA like starting wage, FTE employment, proportion paying $5.05 after the policy. It shows what changed between Wave 1 and Wave 2. 

Note!: It acts as descriptive evidence and not proof of parallel trends

## Table 3
Table 3 shows the main employment comparison. I understand it as broken up into two parts (NJ vs PA and Within NJ). 

- NJ vs PA 
The basic DiD comes from comparing changes in employment between NJ and PA. It reports employment before & after, change in employment, change for a balanced sample, and an alternative treatment of temporarily closed stores.

- Within NJ
NJ stores are broken up into 3 groups, depending on their initial wage. Low (=$4.25), Medium ($4.26 - $4.99), High (≥ $5.00). This allowed them to capture behaviour differences among stores that were affected most and those that were largely unaffected. 
It allows them another method of comparison than just looking at PA. 

## GAP Measure
A continuous measure of treatment intensity. "GAP is the proportional increase in wages at store i necessary to meet the new minimum rate."
GAP was set as zero for PA stores and NJ stores already above $5.05.

-> Did employment change generally or were the changes concentrated among those most affected?

## Table 4
                ΔEi​ = α + βNJi​ + γXi​ + ϵi 
                ΔEi​ = α + βGAPi​​ + γXi​ + ϵi
ΔEi= change in employment at restaurant i
NJi = whether the restaurant is in New Jersey
GAPi = the restaurant's treatment intensity
Xi = additional controls

It then tests robustness of the model by changing different specifications and ways of measuring data.

## Closures and Attrition
An important issue that came up is that not all restaurants observed in the first wave were observed in the second wave. Some restaurants were closed, temporarily closed, or unresponsive. This creates a measurement issue: closures may represent genuine employment losses, while excluding them could cause those losses to be missed. 

Card & Krueger use only the restaurants for which employment can be observed across the two waves in their main analysis. They consider the alternative treatments of these stores as part of the later empirical checks. 

Note!: I'll need to determine exactly which restaurants are included in each specification and how the closures and missing observations are treated. 

## Other Empirical Checks
Card and Krueger perform several additional empirical checks to investigate whether their main employment result is sensitive to the way the data and sample are treated. These include alternative samples, alternative measures of employment, different treatments of restaurants that were closed or temporarily closed, and controls for other restaurant characteristics.

The authors also examine wages and prices, which helps establish whether the minimum-wage policy actually affected the restaurants and whether there were other changes occurring alongside the employment changes. They investigate differences between restaurants with different initial wage levels and use the GAP measure to examine whether the size of the required wage increase is related to changes in employment.

These checks are important because the main NJ-Pennsylvania difference-in-differences result could potentially be affected by sample composition, measurement choices, or other differences between the restaurants. 

Note!: My replication should therefore distinguish between reproducing the headline result and testing whether it remains similar under the alternative specifications used by the authors.

## Authors' Main Conclusions
The authors interpreted their results as challenging the conventional prediction that minimum wage increases reduce employment.They found that the policy did not produce the predicted (conventional) decline in employment. Interestingly, their estimates showed that employment at NJ fast-food restaurants increased relative to the control. 

## Limitations and Identification Questions


## My Initial Understanding
Card and Krueger use the 1992 increase in New Jersey's minimum wage as a natural experiment to investigate how minimum-wage increases affect employment. They compare changes in employment at fast-food restaurants in New Jersey with changes in eastern Pennsylvania, which did not experience the same minimum-wage increase.

I understand the empirical analysis through three main stages. First, the difference-in-differences comparison asks whether employment changed differently in New Jersey relative to Pennsylvania following the policy. Second, the authors examine whether employment changes were concentrated among New Jersey stores that were more exposed to the minimum wage, particularly lower-wage stores. Finally, the GAP regressions examine whether stores facing larger required increases in wages experienced relatively different changes in employment.

The key idea behind the difference-in-differences approach is that the change in Pennsylvania provides an estimate of the change that might have occurred in New Jersey in the absence of the policy. This relies on the assumption that, without the minimum-wage increase, employment in the two areas would have followed similar trends.

My understanding is, therefore, that the paper is not simply comparing employment levels between New Jersey and Pennsylvania. It is comparing changes over time between the two groups and then examining whether the estimated employment change is related to how strongly individual stores were affected by the policy.

## Questions / Confusions
- Why does the paper use the particular controls and specifications in table 4?
- How do the closed stores and temporarily closed stores affect the employment changes?
- With only one pre-treatment and one post-treatment period, how convincing is the parallel-trends assumption? 

## Replication Checklist
[ ] Obtain original Card & Krueger data 
[ ] Read and understand the codebook
[ ] Identify all the variables needed for Tables 1-4
[ ] Reconstruct the sample
[ ] Reconstruct the FTE employment
[ ] Reconstruct GAP
[ ] Reconstruct Table 1
[ ] Reconstruct Table 2
[ ] Reconstruct Table 3
[ ] Reconstruct Table 4
[ ] Compare replicated results with the published results
[ ] Investigate any discrepancies 
[ ] Treatment of closures and missing observations
[ ] Document Standard-error and inference choices
[ ] Challenge and assess identification assumptions
[ ] Conduct robustness checks

## Potential AI-Assisted Tasks
- Use AI to help interpret the original codebook and identify relevant  variables.
- Ask AI to review my replication R code for data cleaning and replication.
- Ask AI to identify possible threats to the identification strategy.
- Use AI to help locate relevant literature on the minimum-wage debate.
- Ask AI to critique my interpretation for unsupported causal claims.

## Test effectiveness and reliability of AI for research 
- Ask AI to propose initial R code for data cleaning and replication.
- Independently verify AI-generated code against the paper and codebook.
- Compare my independently produced results with an AI-generated replication.