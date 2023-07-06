-- ###########################################################
CREATE or replace VIEW suicide_los__count_dx_week AS 
    with powerset as
    (
        select
        count(distinct subject_ref)   as cnt_subject
        , count(distinct encounter_ref)   as cnt_encounter
        , cond_week, category_code, cond_system, cond_display, subtype, gender, race_display, age_at_visit        
        FROM suicide_los__dx
        group by CUBE
        ( cond_week, category_code, cond_system, cond_display, subtype, gender, race_display, age_at_visit )
    )
    select
          cnt_encounter  as cnt 
        , cond_week, category_code, cond_system, cond_display, subtype, gender, race_display, age_at_visit
    from powerset 
    WHERE cnt_subject >= 10 
    ;

-- ###########################################################
CREATE or replace VIEW suicide_los__count_dx_month AS 
    with powerset as
    (
        select
        count(distinct subject_ref)   as cnt_subject
        , count(distinct encounter_ref)   as cnt_encounter
        , cond_month, category_code, cond_system, cond_display, subtype, gender, race_display, age_at_visit        
        FROM suicide_los__dx
        group by CUBE
        ( cond_month, category_code, cond_system, cond_display, subtype, gender, race_display, age_at_visit )
    )
    select
          cnt_encounter  as cnt 
        , cond_month, category_code, cond_system, cond_display, subtype, gender, race_display, age_at_visit
    from powerset 
    WHERE cnt_subject >= 10 
    ;

-- ###########################################################
CREATE or replace VIEW suicide_los__count_study_period_week AS 
    with powerset as
    (
        select
        count(distinct subject_ref)   as cnt_subject
        , count(distinct encounter_ref)   as cnt_encounter
        , start_week, period, enc_class_code, gender, age_group, race_display        
        FROM suicide_los__study_period
        group by CUBE
        ( start_week, period, enc_class_code, gender, age_group, race_display )
    )
    select
          cnt_encounter  as cnt 
        , start_week, period, enc_class_code, gender, age_group, race_display
    from powerset 
    WHERE cnt_subject >= 10 
    ;

-- ###########################################################
CREATE or replace VIEW suicide_los__count_study_period_month AS 
    with powerset as
    (
        select
        count(distinct subject_ref)   as cnt_subject
        , count(distinct encounter_ref)   as cnt_encounter
        , start_month, period, enc_class_code, gender, age_group, race_display        
        FROM suicide_los__study_period
        group by CUBE
        ( start_month, period, enc_class_code, gender, age_group, race_display )
    )
    select
          cnt_encounter  as cnt 
        , start_month, period, enc_class_code, gender, age_group, race_display
    from powerset 
    WHERE cnt_subject >= 10 
    ;

-- ###########################################################
CREATE or replace VIEW suicide_los__count_prevalence_demographics AS 
    with powerset as
    (
        select
        count(distinct subject_ref)   as cnt_subject
        , count(distinct encounter_ref)   as cnt_encounter
        , period, waiting, subtype, gender, age_at_visit, age_group, race_display        
        FROM suicide_los__prevalence
        group by CUBE
        ( period, waiting, subtype, gender, age_at_visit, age_group, race_display )
    )
    select
          cnt_encounter  as cnt 
        , period, waiting, subtype, gender, age_at_visit, age_group, race_display
    from powerset 
    WHERE cnt_subject >= 10 
    ;

-- ###########################################################
CREATE or replace VIEW suicide_los__count_prevalence_icd10_month AS 
    with powerset as
    (
        select
        count(distinct subject_ref)   as cnt_subject
        , count(distinct encounter_ref)   as cnt_encounter
        , start_month, enc_class_code, waiting, subtype, cond_display        
        FROM suicide_los__prevalence
        group by CUBE
        ( start_month, enc_class_code, waiting, subtype, cond_display )
    )
    select
          cnt_encounter  as cnt 
        , start_month, enc_class_code, waiting, subtype, cond_display
    from powerset
    ;
