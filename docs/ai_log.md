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

## AI test input files

The same three files will be supplied to each model during the first blind first-pass replication. 

### public.txt
Original Card-Krueger public dataset.
SHA256: [04BDE0CAD5540980F32CE099C6DAD369E2F05494698071D8A65B3E1CBE9CA53A]

### codebook.txt
Original variable codebook.
SHA256: [1D801D7BDFA77AD2138D79EAD54EEF830913A2BDF4861A50EE013B3474E4B52F]

### card_krueger_1994.pdf
Published Card and Krueger paper.
SHA256: [6F9B9F1B6DA9834C2A68BF86FC6078C83ACDD7507DB0D37B8B4814DFD2B3462E]

## Individual replication status before AI testing

The independent human replication was completed before the AI tests.

### Table 2
Replicated closely from the public data.

Known discrepancy:
- NJ Wave 2 share paying exactly $5.05:
  - public-data replication: 85.5%
  - published value: 85.2%

### Table 3
Main public-data replication:
- NJ-PA employment change: approximately 2.75 FTE
- published value: 2.76 FTE

Rows 4 and 5 reproduce closely.

Some Row 3 standard errors do not exactly reproduce the published values.