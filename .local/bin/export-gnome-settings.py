#! /bin/env python3
import subprocess

def get_all_schemas():
    schemas = subprocess.check_output(['gsettings', 'list-schemas']).decode().split('\n')
    return [schema for schema in schemas if schema]

def get_all_keys(schema):
    keys = subprocess.check_output(['gsettings', 'list-keys', schema]).decode().split('\n')
    return [key for key in keys if key]

def get_current_value(schema, key):
    value = subprocess.check_output(['gsettings', 'get', schema, key]).decode().strip()
    return value

def get_default_value(schema, key):
    value = subprocess.check_output(['gsettings', 'range', schema, key]).decode().strip().split('\n')[-1]
    return value

def is_modified(current_value, default_value):
    return current_value != default_value

def main():
    schemas = get_all_schemas()
    modified_settings = {}

    for schema in schemas:
        keys = get_all_keys(schema)
        for key in keys:
            current_value = get_current_value(schema, key)
            default_value = get_default_value(schema, key)
            if is_modified(current_value, default_value):
                if schema not in modified_settings:
                    modified_settings[schema] = {}
                modified_settings[schema][key] = current_value

    for schema, keys in modified_settings.items():
        for key, value in keys.items():
            print(f"gsettings set {schema} {key} {value}")


if __name__ == '__main__':
    main()
