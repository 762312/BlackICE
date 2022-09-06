from tech import Tech
from utils import merge_dicts_and_add
from collections import OrderedDict
from copy import deepcopy


class Brigade:
    name: str
    techs: dict[str, Tech]
    raw_stats: dict
    current_stats: dict
    current_stats_ordered: OrderedDict

    def __init__(self, name: str, raw_stats: dict, techs: list):
        self.name = name
        self.raw_stats = dict(raw_stats)
        self.current_stats = dict(raw_stats)
        self.techs = dict()
        self.update_techs(techs)
        self.calculate_current_stats()

    # Update the techs associated with a brigade, but keeping the same levels (for when the tech files have changed)
    def update_techs(self, techs: list):
        new = dict()
        new: dict[str, Tech]
        for tech in techs:
            for k, v in tech.units.items():
                v: Tech
                if k == self.name:
                    new[tech.name] = deepcopy(tech)
                    if self.techs.get(tech.name, None):
                        new[tech.name].level = self.techs.get(tech.name).level
                    else:
                        new[tech.name].level = 0
        self.techs = new

    def change_tech_level(self, tech_name: str, level: int):
        tech: Tech
        tech = self.techs.get(tech_name)
        tech.level = level
        self.calculate_current_stats()

    def get_total_tech_level(self):
        total_level = 0
        for k, v in self.techs.items():
            total_level += v.level
        return total_level

    # Each tech level increases build time by 1% (after effects and practicals)
    def ballpark_tech_build_time_effect(self):
        self.current_stats["build_time"] = round(self.current_stats["build_time"]
                                                 * (1 + (self.get_total_tech_level() / 100)), 3)

    def calculate_current_stats(self):
        self.current_stats = deepcopy(self.raw_stats)
        for k, v in self.techs.items():
            v: Tech
            unit_values = v.get_unit_values(self.name)
            x = 0
            while x < v.level:
                self.current_stats = merge_dicts_and_add(self.current_stats, unit_values)
                x += 1
        self.remove_junk_from_stats()
        self.ballpark_tech_build_time_effect()
        self.correct_terrain_value()
        self.sort_current_stats()

    def remove_junk_from_stats(self):
        junk = ["type", "sprite", "priority", "is_mobile", "on_completion", "is_bomber", "active",
                "is_buildable", "usable_by", "available_trigger", "repair_cost_multiplier",
                "is_armor", "completion_size"]
        new = dict(self.current_stats)
        for k, v in self.current_stats.items():
            if k in junk:
                new.pop(k)
        self.current_stats = new

    def correct_terrain_value(self):
        for k, v in self.current_stats.items():
            if isinstance(v, dict):
                for modifier, value in v.items():
                    if modifier == "attrition":
                        pass
                    else:
                        self.current_stats[k][modifier] = round(self.current_stats[k][modifier] * 100)

    def sort_current_stats(self):
        self.current_stats_ordered = OrderedDict(sorted(self.current_stats.items()))
        new = OrderedDict(self.current_stats_ordered)
        for k, v in self.current_stats_ordered.items():
            if isinstance(v, dict):  # Terrain stats
                new.move_to_end(k)
        if new.get("unit_group", None):
            new.move_to_end("unit_group", False)
        self.current_stats_ordered = new
