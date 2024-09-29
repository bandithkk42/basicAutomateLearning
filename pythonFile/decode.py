import json

def decode_json_with_bom(response_text):
    # Decode with utf-8-sig to handle BOM
    decoded_text = response_text.encode('utf-8').decode('utf-8-sig')
    return json.loads(decoded_text)
