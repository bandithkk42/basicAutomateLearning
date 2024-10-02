import  random
from jsonpath_ng.ext import parse
import xmltodict
import json



def generate_thai_citizen_id():
    # Generate random digits (not following the real generation process)
    digits = [str(random.randint(0, 9)) for _ in range(12)]

    # Simulate a checksum digit (replace with actual validation logic)
    checksum = sum(int(digit) * (13 - i) for i, digit in enumerate(digits)) % 11
    checksum = 1 if checksum == 0 else 0 if checksum == 1 else 11 - checksum

    # Combine digits and checksum for display (not a real ID)
    return ''.join(digits + [str(checksum)])


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