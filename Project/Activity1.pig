
-- Load input file from HDFS
inputFile = LOAD 'hdfs:///user/msp/inputs_project' USING PigStorage('\t') AS (name:chararray, line:chararray);
-- Combine the words from the above stage
grpd = GROUP inputFile BY name;
-- Count the occurence of each word (Reduce)
cntd = FOREACH grpd GENERATE $0, COUNT($1) AS numlines;
ord = ORDER cntd BY numlines DESC;
-- Store the result in HDFS
STORE ord INTO 'hdfs:///user/msp/Activity0_results';