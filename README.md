# CSULB Master's Students' Success

## Project Summary

### Overview
In this project, I set out to analyze CSULB Master's students' success. Using machine learning algorithms, I built models that correlate student-related variables with the number of years they took to graduate, aiming to find what predictors most impacted their time to degree.  

### Data Preparation
I retrieved this dataset from IR&A through a project with CSULB Data Fellows. The population consists of graduated CSULB Master's students in stateside programs who entered between Fall 2016 and Fall 2021. 
After a thorough cleaning process to ensure data quality, I selected features I believed would be indicative of a student's time to degree, including demographic information, academic background, and academic performance. 
There was a sample size of n=5,026 students and 25 input variables with years to degree as the target. 

### Models
I built several machine learning regression models, specifically Gradient Boosting, Random Forest and kNN with an 80% training and 20% testing split. I used SAS, R, and Python to see which program would perform the best for each technique. 

### Results
Out of all three machine learning models, Gradient Boosting yielded the most consistent prediction accuracies within 20% of the testing data (70.53% in SAS, 72.83% in R, and 74.75% in Python). 
These were the most important input features according to the Gradient Boosting models in SAS, R, and Python: 
- **Master's Program:** What program each Master's student is enrolled in at CSULB.
- **Culminating Activity:** What culminating activity each Master's student has chosen to complete (Comprehensive Exams, Master's Thesis, or Graduate Project).
- **Cohort Term:** When the student entered CSULB as a Master's student.
- **Units taken during the 1st semester:** How many units a student has enrolled in during the 1st semester of their program. 

### Analysis
- **Master's Program:** Most program lengths vary between 1-3 years. Some programs are 1 year long while others may be 3 years long. 
- **Culminating Activity:** A Master's Thesis or Graduate Project span over multiple semesters, so students who do either of these options may take longer to graduate versus students who take the Comprehensive Exams. 
- **Cohort Term:** Some programs only accept incoming students during the fall semester. In addition, some courses are only offered during certain semesters, so students may take longer to graduate because they are waiting to take a required course.
- **Units taken during the 1st semester:** Since Master's programs are only 1-3 years long, every semester is important, but especially in the beginning.   

The analysis confirmed that student demographics, academic background, and academic performance can be indicative of determining time to degree, but also highlighted the potential for refining the models. Future work will look into each Master's program individually, comparing each student's time to degree with the number of years their specific program is advtertised to take. 
