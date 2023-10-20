from pathlib import Path
from cumulus_library.schema.counts import CountsBuilder


class SuicideLOSCountsBuilder(CountsBuilder):
    display_text = "Creating suicide LOS counts..."

    def count_dx(self, duration=None):
        view_name = self.get_table_name("count_dx", duration)
        from_table = self.get_table_name("dx")
        cols = [
            "category_code",
            "cond_system",
            "cond_display",
            "subtype",
            "period",
            "enc_class_display",
            "gender",
            "age_group",
            "race_display",
        ]

        if duration:
            cols.append(f"cond_{duration}")

        return self.count_encounter(
            view_name, from_table, cols
        )

    def count_study_period(self, duration=None):
        view_name = self.get_table_name("count_study_period", duration)
        from_table = self.get_table_name("study_period")
        cols = ["period", "enc_class_display", "gender", "age_group", "race_display"]

        if duration:
            cols.append(f"start_{duration}")

        return self.count_encounter(
            view_name, from_table, cols
        )

    def count_prevalence_icd10(self, duration=None):
        view_name = self.get_table_name("count_prevalence_icd10", duration)
        from_table = self.get_table_name("prevalence")
        cols = ["enc_class_display", "waiting", "subtype", "cond_display"]

        if duration:
            cols.append(f"start_{duration}")

        return self.count_encounter(
            view_name, from_table, cols
        )

    def count_prevalence_demographics(self):
        view_name = self.get_table_name("count_prevalence_demographics")
        from_table = self.get_table_name("prevalence")
        cols = [
            "period",
            "waiting",
            "subtype",
            "gender",
            "enc_class_display",
            "age_at_visit",
            "race_display",
        ]

        return self.count_encounter(
            view_name, from_table, cols
        )

    def count_comorbidity(self, duration=None):
        view_name = self.get_table_name("count_comorbidity", duration)
        from_table = self.get_table_name("comorbidity")
        cols = [
            "comorbidity_display",
            "waiting",
            "subtype",
            "gender",
            "enc_class_display",
            "age_at_visit",
            "race_display",
        ]

        if duration:
            cols.append(f"comorbidity_{duration}")

        return self.count_encounter(
            view_name, from_table, cols
        )

    def prepare_queries(self, cursor=None, schema=None):
        self.queries = [
            self.count_study_period("month"),
            self.count_study_period("week"),
            self.count_prevalence_icd10("month"),
            self.count_prevalence_icd10("week"),
            self.count_prevalence_demographics(),
            self.count_comorbidity(),
            self.count_comorbidity("month"),
        ]


if __name__ == "__main__":
    builder = SuicideLOSCountsBuilder()
    builder.write_counts(f"{Path(__file__).resolve().parent}/counts.sql")
