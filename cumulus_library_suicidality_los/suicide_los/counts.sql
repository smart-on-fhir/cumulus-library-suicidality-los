-- noqa: disable=all

CREATE TABLE suicide_los__count_study_period_month AS (
    WITH powerset AS (
        SELECT
            count(DISTINCT subject_ref) AS cnt_subject,
            count(DISTINCT encounter_ref) AS cnt_encounter,
            "period",
            "enc_class_code",
            "gender",
            "age_group",
            "race_display",
            "start_month"
        FROM suicide_los__study_period
        GROUP BY
            cube(
                "period",
                "enc_class_code",
                "gender",
                "age_group",
                "race_display",
                "start_month"
            )
    )

    SELECT
        cnt_encounter AS cnt,
        "period",
        "enc_class_code",
        "gender",
        "age_group",
        "race_display",
        "start_month"
    FROM powerset
    WHERE 
        cnt_subject >= 10
);

-- ###########################################################

CREATE TABLE suicide_los__count_study_period_week AS (
    WITH powerset AS (
        SELECT
            count(DISTINCT subject_ref) AS cnt_subject,
            count(DISTINCT encounter_ref) AS cnt_encounter,
            "period",
            "enc_class_code",
            "gender",
            "age_group",
            "race_display",
            "start_week"
        FROM suicide_los__study_period
        GROUP BY
            cube(
                "period",
                "enc_class_code",
                "gender",
                "age_group",
                "race_display",
                "start_week"
            )
    )

    SELECT
        cnt_encounter AS cnt,
        "period",
        "enc_class_code",
        "gender",
        "age_group",
        "race_display",
        "start_week"
    FROM powerset
    WHERE 
        cnt_subject >= 10
);

-- ###########################################################

CREATE TABLE suicide_los__count_prevalence_icd10_month AS (
    WITH powerset AS (
        SELECT
            count(DISTINCT subject_ref) AS cnt_subject,
            count(DISTINCT encounter_ref) AS cnt_encounter,
            "enc_class_code",
            "waiting",
            "subtype",
            "cond_display",
            "start_month"
        FROM suicide_los__prevalence
        GROUP BY
            cube(
                "enc_class_code",
                "waiting",
                "subtype",
                "cond_display",
                "start_month"
            )
    )

    SELECT
        cnt_encounter AS cnt,
        "enc_class_code",
        "waiting",
        "subtype",
        "cond_display",
        "start_month"
    FROM powerset
    WHERE 
        cnt_subject >= 10
);

-- ###########################################################

CREATE TABLE suicide_los__count_prevalence_icd10_week AS (
    WITH powerset AS (
        SELECT
            count(DISTINCT subject_ref) AS cnt_subject,
            count(DISTINCT encounter_ref) AS cnt_encounter,
            "enc_class_code",
            "waiting",
            "subtype",
            "cond_display",
            "start_week"
        FROM suicide_los__prevalence
        GROUP BY
            cube(
                "enc_class_code",
                "waiting",
                "subtype",
                "cond_display",
                "start_week"
            )
    )

    SELECT
        cnt_encounter AS cnt,
        "enc_class_code",
        "waiting",
        "subtype",
        "cond_display",
        "start_week"
    FROM powerset
    WHERE 
        cnt_subject >= 10
);

-- ###########################################################

CREATE TABLE suicide_los__count_prevalence_demographics AS (
    WITH powerset AS (
        SELECT
            count(DISTINCT subject_ref) AS cnt_subject,
            count(DISTINCT encounter_ref) AS cnt_encounter,
            "period",
            "waiting",
            "subtype",
            "gender",
            "enc_class_code",
            "age_at_visit",
            "race_display"
        FROM suicide_los__prevalence
        GROUP BY
            cube(
                "period",
                "waiting",
                "subtype",
                "gender",
                "enc_class_code",
                "age_at_visit",
                "race_display"
            )
    )

    SELECT
        cnt_encounter AS cnt,
        "period",
        "waiting",
        "subtype",
        "gender",
        "enc_class_code",
        "age_at_visit",
        "race_display"
    FROM powerset
    WHERE 
        cnt_subject >= 10
);

-- ###########################################################

CREATE TABLE suicide_los__count_comorbidity AS (
    WITH powerset AS (
        SELECT
            count(DISTINCT subject_ref) AS cnt_subject,
            count(DISTINCT encounter_ref) AS cnt_encounter,
            "comorbidity_display",
            "waiting",
            "subtype",
            "gender",
            "enc_class_code",
            "age_at_visit",
            "race_display"
        FROM suicide_los__comorbidity
        GROUP BY
            cube(
                "comorbidity_display",
                "waiting",
                "subtype",
                "gender",
                "enc_class_code",
                "age_at_visit",
                "race_display"
            )
    )

    SELECT
        cnt_encounter AS cnt,
        "comorbidity_display",
        "waiting",
        "subtype",
        "gender",
        "enc_class_code",
        "age_at_visit",
        "race_display"
    FROM powerset
    WHERE 
        cnt_subject >= 10
);

-- ###########################################################

CREATE TABLE suicide_los__count_comorbidity_month AS (
    WITH powerset AS (
        SELECT
            count(DISTINCT subject_ref) AS cnt_subject,
            count(DISTINCT encounter_ref) AS cnt_encounter,
            "comorbidity_display",
            "waiting",
            "subtype",
            "gender",
            "enc_class_code",
            "age_at_visit",
            "race_display",
            "comorbidity_month"
        FROM suicide_los__comorbidity
        GROUP BY
            cube(
                "comorbidity_display",
                "waiting",
                "subtype",
                "gender",
                "enc_class_code",
                "age_at_visit",
                "race_display",
                "comorbidity_month"
            )
    )

    SELECT
        cnt_encounter AS cnt,
        "comorbidity_display",
        "waiting",
        "subtype",
        "gender",
        "enc_class_code",
        "age_at_visit",
        "race_display",
        "comorbidity_month"
    FROM powerset
    WHERE 
        cnt_subject >= 10
);
