CREATE TABLE suicide_los__comorbidity as
WITH condition_row AS
(
    SELECT DISTINCT
        c.subject_ref,
        c.encounter_ref,
        c.category_display as comorbidity_category_display,
        c.code AS comorbidity_code,
        c.code_display as comorbidity_display,
        fhirspec.code_system as comorbidity_system_display,
        c.recorded_month AS comorbidity_month,
        c.recorded_week AS comorbidity_week,
        c.recordeddate as comorbidity_date,
        e.status
    FROM
        core__condition AS c,
        core__fhir_mapping_code_system_uri as fhirspec,
        core__encounter AS e
    WHERE
        c.encounter_ref = e.encounter_ref and
        c.code_system = fhirspec.uri   and
        c.code not in (select distinct code from suicide_los__define_dx)
)
select distinct
        suicide_los__dx.subtype,
        suicide_los__dx.cond_code,
        suicide_los__dx.cond_display,
        condition_row.*,
        prevalence.enc_class_display,
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
