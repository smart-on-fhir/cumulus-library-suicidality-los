from typing import List
from cumulus_library.schema import counts

# https://github.com/smart-on-fhir/cumulus-library-template/issues/2
STUDY_PREFIX = 'suicide_los'

def table(tablename: str, duration=None) -> str:
    if duration:
        return f'{STUDY_PREFIX}__{tablename}_{duration}'
    else: 
        return f'{STUDY_PREFIX}__{tablename}'

def count_dx(duration=None):
    view_name = table('count_dx', duration)
    from_table = table('dx')
    cols = ['category_code',
            'cond_system',
            'cond_display',
            'subtype',
            'period',
            'enc_class_code',
            'gender',
            'age_group',
            'race_display']

    if duration:
        cols.append(f'cond_{duration}')

    return min_subject(counts.count_encounter(view_name, from_table, cols), 1)

def count_study_period(duration=None):
    view_name = table('count_study_period', duration)
    from_table = table('study_period')
    cols = ['period',
            'enc_class_code',
            'gender',
            'age_group',
            'race_display']

    if duration:
        cols.append(f'start_{duration}')

    return min_subject(counts.count_encounter(view_name, from_table, cols), 10)

def count_prevalence_icd10(duration=None):
    view_name = table('count_prevalence_icd10', duration)
    from_table = table('prevalence')
    cols = ['enc_class_code',
            'waiting',
            'subtype',
            'cond_display']

    if duration:
        cols.append(f'start_{duration}')

    return min_subject(counts.count_encounter(view_name, from_table, cols), 10)

def count_prevalence_demographics():
    view_name = table('count_prevalence_demographics')
    from_table = table('prevalence')
    cols = ['period',
            'waiting',
            'subtype',
            'gender',
            'enc_class_code',
            'age_at_visit',
            'race_display']

    return min_subject(counts.count_encounter(view_name, from_table, cols), 1)

def count_comorbidity(duration=None):
    view_name = table('count_comorbidity', duration)
    from_table = table('comorbidity')
    cols = ['comorbidity_display',
            'waiting',
            'subtype',
            'gender',
            'enc_class_code',
            'age_at_visit',
            'race_display']

    if duration:
        cols.append(f'comorbidity_{duration}')

    return min_subject(counts.count_encounter(view_name, from_table, cols), 1)


def concat_view_sql(create_view_list: List[str]) -> str:
    """
    :param create_view_list: SQL prepared statements
    :param filename: path to output file, default 'count.sql' in PWD
    """
    seperator = '-- ###########################################################'
    concat = list()

    for create_view in create_view_list:
        concat.append(seperator + '\n'+create_view + '\n')

    return '\n'.join(concat)

def min_subject(view_sql: str, cnt_subject=10):
    return view_sql.replace(f'WHERE cnt_subject >= 10', f'WHERE cnt_subject >= {cnt_subject}')

def write_view_sql(view_list_sql: List[str], filename='count.sql') -> None:
    """
    :param view_list_sql: SQL prepared statements
    :param filename: path to output file, default 'count.sql' in PWD
    """
    sql_optimizer = concat_view_sql(view_list_sql)
    sql_optimizer = sql_optimizer.replace("CREATE or replace VIEW", 'CREATE TABLE')
    sql_optimizer = sql_optimizer.replace("ORDER BY cnt desc", "")

    with open(filename, 'w') as fout:
        fout.write(sql_optimizer)


if __name__ == '__main__':

    write_view_sql([
        count_study_period('month'),
        count_study_period('week'),
        count_prevalence_icd10('month'),
        count_prevalence_icd10('week'),
        count_prevalence_demographics(),
        count_comorbidity(),
        count_comorbidity('month'),

    ])
