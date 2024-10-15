import  random
from jsonpath_ng.ext import parse
import xmltodict
import json
import time
from datetime import datetime
import string




def generate_thai_citizen_id():
    # Generate random digits (not following the real generation process)
    digits = [str(random.randint(0, 9)) for _ in range(12)]

    # Simulate a checksum digit (replace with actual validation logic)
    checksum = sum(int(digit) * (13 - i) for i, digit in enumerate(digits)) % 11
    checksum = 1 if checksum == 0 else 0 if checksum == 1 else 11 - checksum

    # Combine digits and checksum for display (not a real ID)
    return ''.join(digits + [str(checksum)])

def generate_for_id():
    letters = ''.join(random.choices(string.ascii_uppercase, k=1))  # Two uppercase letters
    digits = ''.join(random.choices(string.digits, k=7))  # Seven digits
    return letters + digits

def add_data_to_array_json(json_object, json_path, value):
    json_path_expr = parse(json_path)
    matches = json_path_expr.find(json_object)

    # Append the value to all matching arrays
    for match in matches:
        if isinstance(match.value, list):
            match.value.append(value)

    return json_object

def convert_xml_to_json(xml_string):
    json_data = json.dumps(xmltodict.parse(xml_string))
    return json_data


def get_micro_time_stamp():
    start_date = int(time.time() * 1000)  # Get current time in milliseconds
    start_nanoseconds = time.time_ns()  # Get current time in nanoseconds

    date_format = "%y%m%d%H%M%S%f"  # Equivalent to "yyMMddHHmmssSSS"

    micro_seconds = (time.time_ns() - start_nanoseconds) // 1000  # Convert nanoseconds to microseconds
    date = start_date + micro_seconds // 1000  # Add microseconds to the initial time

    # Generate random number between 10000 and 99999
    ran = random.randint(10000, 99999)

    # Format date and append random number
    value = datetime.fromtimestamp(date / 1000.0).strftime(date_format) + str(ran)

    return value