import configparser
import argparse
from pathlib import Path
import sys

REQUIRED_KEYS = [
    "ami",
    "instance_type",
    "instance_count",
    "subnet_id",
    "key_name",
    "company",
    "team",
    "region",
    "instance_name"
]

def parse_properties_file(filepath):
    config = configparser.ConfigParser()
    with open(filepath, 'r') as f:
        content = f.read()
    config.read_string('[default]\n' + content)
    return dict(config['default'])

def validate_required_keys(data):
    missing = [key for key in REQUIRED_KEYS if key not in data]
    if missing:
        print(f"ERROR: Missing required keys in properties file: {', '.join(missing)}")
        sys.exit(1)

def write_tfvars(data, output_path):
    with open(output_path, 'w') as f:
        for key in REQUIRED_KEYS:
            value = data[key]
            if value.lower() in ['true', 'false']:
                f.write(f'{key} = {value.lower()}\n')
            elif value.isdigit():
                f.write(f'{key} = {value}\n')
            else:
                f.write(f'{key} = "{value}"\n')

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--cloud', required=True)
    parser.add_argument('--region', required=True)
    parser.add_argument('--release', required=True)
    parser.add_argument('--output', default='master.tfvars')
    args = parser.parse_args()

    BASE_DIR = Path(__file__).resolve().parents[1]

    input_file = BASE_DIR / "release" / args.release / args.cloud / f"{args.region}.properties"
    output_file = BASE_DIR / "terraform" / args.cloud / args.output


    if not input_file.exists():
        print(f"ERROR: Properties file not found at: {input_file}")
        sys.exit(1)

    props = parse_properties_file(input_file)
    validate_required_keys(props)
    write_tfvars(props, output_file)

    print(f"master.tfvars successfully created at: {output_file}")

if __name__ == "__main__":
    main()
