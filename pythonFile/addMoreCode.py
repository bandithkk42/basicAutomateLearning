import  random

def generate_thai_citizen_id():
    # Generate random digits (not following the real generation process)
    digits = [str(random.randint(0, 9)) for _ in range(12)]

    # Simulate a checksum digit (replace with actual validation logic)
    checksum = sum(int(digit) * (13 - i) for i, digit in enumerate(digits)) % 11
    checksum = 1 if checksum == 0 else 0 if checksum == 1 else 11 - checksum

    # Combine digits and checksum for display (not a real ID)
    return ''.join(digits + [str(checksum)])