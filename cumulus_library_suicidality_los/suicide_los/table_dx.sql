create table suicide_los__dx as
SELECT DISTINCT
    c.category.code as category_code,
    dx.code AS cond_code,
    dx.display as cond_display,
    dx.system as cond_system,
    c.recorded_month AS cond_month,
    c.recorded_week AS cond_week,
    s.enc_class_code,
    s.age_at_visit,
    s.gender,
    s.race_display,
    s.ethnicity_display,
    c.subject_ref,
    c.encounter_ref
FROM
    suicide_los__define_dx AS dx,
    suicide_los__study_period AS s,
    core__condition AS c,
    core__condition_codable_concepts cc
WHERE
    dx.system = cc.code_system  and
    dx.code   = cc.code    and
    cc.id = c.condition_id and
    c.encounter_ref = s.encounter_ref;
