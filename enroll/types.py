class UserType:
    types = {
        1: "new_user",
        2: "student",
        3: "teacher",
        4: "moderator",
    }

    @classmethod
    def get_by_key(cls, key):
        return cls.types[key]

    @classmethod
    def get_choices(cls):
        return tuple(sorted(cls.types.items()))

    @classmethod
    def get_by_name(cls, value):
        return list(cls.types.keys())[list(cls.types.values()).index(value)]
