import datetime as dt


def time_plus_minutes(time, minutes):
    return (
        dt.datetime.combine(dt.date(1, 1, 1), time) + dt.timedelta(minutes=minutes)
    ).time()
