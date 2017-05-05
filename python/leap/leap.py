def is_leap_year(y):
    if not y % 400:
        return True
    elif not y % 100:
        return False
    elif not y % 4:
        return True
    return False
