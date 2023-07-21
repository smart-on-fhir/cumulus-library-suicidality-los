CREATE TABLE suicide_los__comorbidity as
WITH condition_row AS
(
    SELECT DISTINCT
        c.subject_ref,
        c.encounter_ref,
        c.category.display as comorbidity_category_display,
        cc.code AS comorbidity_code,
        cc.display as comorbidity_display,
        fhirspec.define as comorbidity_system_display,
        c.recorded_month AS comorbidity_month,
        c.recorded_week AS comorbidity_week,
        c.recordeddate as comorbidity_date
    FROM
        core__condition_codable_concepts cc,
        core__condition AS c,
        core__fhir_define as fhirspec
    WHERE
        cc.id = c.condition_id          and
        cc.code_system = fhirspec.url   and
        cc.code not in (select distinct code from suicide_los__define_dx)
)
select distinct
        suicide_los__dx.subtype,
        suicide_los__dx.cond_code,
        suicide_los__dx.cond_display,
        condition_row.*,
        prevalence.enc_class_code,
        prevalence.waiting,
        prevalence.period,
        prevalence.age_at_visit,
        prevalence.age_group,
        prevalence.gender,
        prevalence.race_display
from    suicide_los__dx, condition_row, suicide_los__prevalence as prevalence
where   suicide_los__dx.subject_ref = condition_row.subject_ref
and     suicide_los__dx.encounter_ref = prevalence.encounter_ref
;
