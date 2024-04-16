from datetime import datetime, timedelta


today = datetime.now()
def get_start_of_day():
    return datetime.combine(today, datetime.min.time()) 

def get_end_of_day():
    return datetime.combine(today, datetime.max.time())

def get_start_date_of_week():
    return today - timedelta(days=today.weekday())

def get_end_date_of_week():
    return get_start_date_of_week() + timedelta(days=6)

def get_start_date_of_month():
    return today.replace(day=1)

def get_end_date_of_month():
    next_month = today.replace(day=28) + timedelta(days=4)
    return next_month - timedelta(days=next_month.day)

def get_start_date_of_year():
    return today.replace(month=1, day=1)

def get_end_date_of_year():
    return today.replace(month=12, day=31)

def format_choice_query_params(str):
    return "_".join([x.upper() for x in str.split()])