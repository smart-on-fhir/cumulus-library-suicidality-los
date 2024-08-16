create or replace view suicide_los__define_waiting as select * from (values
 ('http://hl7.org/fhir/sid/icd-10-cm', 'Z75.1', 'Person awaiting admission to adequate facility elsewhere')
,('http://hl7.org/fhir/sid/icd-10-cm', 'Z75.2', 'Other waiting period for investigation and treatment')
,('http://hl7.org/fhir/sid/icd-10-cm', 'Z75.3', 'Unavailability and inaccessibility of health-care facilities')
) AS t (system, code, display) ;
