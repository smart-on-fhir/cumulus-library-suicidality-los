-- ###########################################################
CREATE TABLE suicide_los__count_study_period_month AS 
    with powerset as
    (
        select
        count(distinct subject_ref)   as cnt_subject
        , count(distinct encounter_ref)   as cnt_encounter
        , period, enc_class_code, gender, age_group, race_display, start_month        
        FROM suicide_los__study_period
        group by CUBE
        ( period, enc_class_code, gender, age_group, race_display, start_month )
    )
    select
          cnt_encounter  as cnt 
        , period, enc_class_code, gender, age_group, race_display, start_month
    from powerset 
    WHERE cnt_subject >= 10 
    ;

-- ###########################################################
CREATE TABLE suicide_los__count_study_period_week AS 
    with powerset as
    (
        select
        count(distinct subject_ref)   as cnt_subject
        , count(distinct encounter_ref)   as cnt_encounter
        , period, enc_class_code, gender, age_group, race_display, start_week        
        FROM suicide_los__study_period
        group by CUBE
        ( period, enc_class_code, gender, age_group, race_display, start_week )
    )
    select
          cnt_encounter  as cnt 
        , period, enc_class_code, gender, age_group, race_display, start_week
    from powerset 
    WHERE cnt_subject >= 10 
    ;

-- ###########################################################
CREATE TABLE suicide_los__count_prevalence_icd10_month AS 
    with powerset as
    (
        select
        count(distinct subject_ref)   as cnt_subject
        , count(distinct encounter_ref)   as cnt_encounter
        , enc_class_code, waiting, subtype, cond_display, start_month        
        FROM suicide_los__prevalence
        group by CUBE
        ( enc_class_code, waiting, subtype, cond_display, start_month )
    )
    select
          cnt_encounter  as cnt 
        , enc_class_code, waiting, subtype, cond_display, start_month
    from powerset 
    WHERE cnt_subject >= 10 
    ;

-- ###########################################################
CREATE TABLE suicide_los__count_prevalence_icd10_week AS 
    with powerset as
    (
        select
        count(distinct subject_ref)   as cnt_subject
        , count(distinct encounter_ref)   as cnt_encounter
        , enc_class_code, waiting, subtype, cond_display, start_week        
        FROM suicide_los__prevalence
        group by CUBE
        ( enc_class_code, waiting, subtype, cond_display, start_week )
    )
    select
          cnt_encounter  as cnt 
        , enc_class_code, waiting, subtype, cond_display, start_week
    from powerset 
    WHERE cnt_subject >= 10 
    ;

-- ###########################################################
CREATE TABLE suicide_los__count_prevalence_demographics AS 
    with powerset as
    (
        select
        count(distinct subject_ref)   as cnt_subject
        , count(distinct encounter_ref)   as cnt_encounter
        , period, waiting, subtype, gender, enc_class_code, age_at_visit, race_display        
        FROM suicide_los__prevalence
        group by CUBE
        ( period, waiting, subtype, gender, enc_class_code, age_at_visit, race_display )
    )
    select
          cnt_encounter  as cnt 
        , period, waiting, subtype, gender, enc_class_code, age_at_visit, race_display
    from powerset 
    WHERE cnt_subject >= 1 
    ;

-- ###########################################################
CREATE TABLE suicide_los__count_comorbidity AS 
    with powerset as
    (
        select
        count(distinct subject_ref)   as cnt_subject
        , count(distinct encounter_ref)   as cnt_encounter
        , comorbidity_display, waiting, subtype, gender, enc_class_code, age_at_visit, race_display        
        FROM suicide_los__comorbidity
        group by CUBE
        ( comorbidity_display, waiting, subtype, gender, enc_class_code, age_at_visit, race_display )
    )
    select
          cnt_encounter  as cnt 
        , comorbidity_display, waiting, subtype, gender, enc_class_code, age_at_visit, race_display
    from powerset 
    WHERE cnt_subject >= 1 
    ;

-- ###########################################################
CREATE TABLE suicide_los__count_comorbidity_month AS 
    with powerset as
    (
        select
        count(distinct subject_ref)   as cnt_subject
        , count(distinct encounter_ref)   as cnt_encounter
        , comorbidity_display, waiting, subtype, gender, enc_class_code, age_at_visit, race_display, comorbidity_month        
        FROM suicide_los__comorbidity
        group by CUBE
        ( comorbidity_display, waiting, subtype, gender, enc_class_code, age_at_visit, race_display, comorbidity_month )
    )
    select
          cnt_encounter  as cnt 
        , comorbidity_display, waiting, subtype, gender, enc_class_code, age_at_visit, race_display, comorbidity_month
    from powerset 
    WHERE cnt_subject >= 1 
    ;
