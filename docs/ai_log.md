## Purpose 

This experiment means to evaluate whether general-purpose AI models can independently reproduce empirical results from Card & Krueger (1994) using the original public data and documentation 

The AI results are compared against:

1. independent R replication completed before the AI tests
2. the published Card and Krueger results. 

The objective is not only to test numerical agreement, but also to evaluate variable construction, treatment of missing observations, sample restrictions, methodological reasoning, code reliability, and the model's ability to identify discrepancies.

---

## Experiment Protocol 

## Inputs provided

First-pass AI runs receive:

- `data/raw/public.dat`
- original codebook
- Card and Krueger (1994) paper

The models do NOT initially receive:

- my R replication scripts
- my cleaned dataset
- my numerical replication results
- my replication notes
- the authors' `check.sas` program

### Tables tested 

- Table 2: Means of Key Variables
- Table 3: Employment before and After the Minimum-Wage Increase

### Procedure

Each model receives the same initial prompt and files.

The first response is preserved without correction.

Generated R code is then run against the original data.

Errors, numerical discrepancies, methodological mistakes, and unsupported assumptions are recorded.

If necessary, a second correction round is conducted using only information that would easily be available to a researcher, such as R error messages or a statement that particular results do not reproduce.

---

# Test 1: ChatGPT

## Model
Model: 


## Inputs supplied 
- public.dat
- codebook
- Card and Krueger (1994) paper

## Initial prompt

## First-pass output 

## Did the code run without modification? 

Yes / No

## Execution Errors

## Table 2 Results

## Table 3 results

## Methodological observations

## Discrepancies 

## Unsupported observations (forced correct answers)

## Final assessment 

---

# Test 2: Claude

## Model
Model:

## Inputs supplied 
- public.dat
- codebook
- Card and Krueger (1994) paper

## Initial prompt

## First-pass output 

## Did the code run without modification? 

Yes / No

## Execution Errors

## Table 2 Results

## Table 3 results

## Methodological observations

## Discrepancies 

## Unsupported observations (forced correct answers)

## Final assessment 