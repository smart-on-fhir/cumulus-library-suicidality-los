from typing import List
from cumulus_library.schema import counts

# https://github.com/smart-on-fhir/cumulus-library-template/issues/2
STUDY_PREFIX = 'suicide_los'

def table(tablename: str, duration=None) -> str:
    if duration:
        return f'{STUDY_PREFIX}__{tablename}_{duration}'
    else: 
        return f'{STUDY_PREFIX}__{tablename}'

def count_dx(duration='week'):
    view_name = table('count_dx', duration)
    from_table = table('dx')
    cols = [f'cond_{duration}',
            'category_code',
            'cond_system',
            'cond_display',
            'subtype',
            'gender',
            'race_display',
            'age_at_visit']
    return counts.count_encounter(view_name, from_table, cols)

def count_study_period(duration='month'):
    view_name = table('count_study_period', duration)
    from_table = table('study_period')
    cols = [f'start_{duration}',
            'period',
            'enc_class_code',
            'gender',
            'age_group',
            'race_display']
    return counts.count_encounter(view_name, from_table, cols)

def count_prevalence_icd10(duration='month'):
    view_name = table('count_prevalence_icd10', duration)
    from_table = table('prevalence')
    cols = [f'start_{duration}',
            'enc_class_code',
            'waiting',
            'subtype',
            'cond_display']
    return counts.count_encounter(view_name, from_table, cols)

def count_prevalence_demographics():
    view_name = table('count_prevalence_demographics')
    from_table = table('prevalence')
    cols = ['period',
            'waiting',
            'subtype',
            'gender',
            'age_at_visit',
            'age_group',
            'race_display']
    return counts.count_encounter(view_name, from_table, cols)

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

def write_view_sql(view_list_sql: List[str], filename='count.sql') -> None:
    """
    :param view_list_sql: SQL prepared statements
    :param filename: path to output file, default 'count.sql' in PWD
    """
    sql_optimizer = concat_view_sql(view_list_sql).replace('ORDER BY cnt desc', '')
    with open(filename, 'w') as fout:
        fout.write(sql_optimizer)


if __name__ == '__main__':

    write_view_sql([
        count_dx('week'),
        count_dx('month'),
        count_study_period('week'),
        count_study_period('month'),
        count_prevalence_demographics(),
        count_prevalence_icd10('month')
    ])
