create TABLE suicide_los__study_period AS
select distinct
        P.period
    ,   A.age_group
    ,   S.*
from    core__study_period as S
    ,   suicide_los__define_age as A
    ,   suicide_los__define_study_period as P
where S.age_at_visit = A.age
  and (S.start_date between P.period_start and P.period_end)
;
