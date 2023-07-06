CREATE TABLE suicide_los__prevalence AS WITH
is_waiting as
(
    select  distinct
        cond.encounter_ref,
        waiting.code,
        waiting.display
    from
        suicide_los__define_waiting as waiting,
        core__condition_codable_concepts as mapping,
        core__condition as cond
    where
        mapping.code = waiting.code and
        mapping.id = cond.condition_id
),
is_suicidal as
(
    select  distinct
        category_code,
        subtype,
        cond_code,
        cond_display,
        cond_system,
        subject_ref,
        encounter_ref
    from suicide_los__dx
),
study_period AS (
    SELECT DISTINCT
        period,
        enc_class_code,
        start_week,
        start_month,
        gender,
        race_display,
        age_at_visit,
        age_group,
        subject_ref,
        encounter_ref
    FROM suicide_los__study_period
    WHERE ed_note
)
select
    coalesce(is_suicidal.subtype, 'None') as subtype,
    coalesce(is_suicidal.cond_code, 'None') as cond_code,
    coalesce(is_suicidal.cond_display, 'None') as cond_display,
    coalesce(is_waiting.display, 'None') as waiting,
    study_period.enc_class_code,
    study_period.period,
    study_period.start_week,
    study_period.start_month, 
    study_period.gender, 
    study_period.race_display,
    study_period.age_at_visit, 
    study_period.age_group,
    study_period.subject_ref, 
    study_period.encounter_ref
from study_period
left join   is_waiting  on  study_period.encounter_ref = is_waiting.encounter_ref
left join   is_suicidal on  study_period.encounter_ref = is_suicidal.encounter_ref
