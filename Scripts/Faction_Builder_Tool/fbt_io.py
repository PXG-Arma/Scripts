import os

def write_faction(full_path, content):
    """
    Recursively creates directories and writes raw text content to a file.
    Args:
        full_path (str): Absolute path to the file.
        content (str): The raw SQF content to write.
    """
    try:
        # Standardize slashes for Python
        clean_path = full_path.replace("\\", "/")
        
        # Ensure directory exists
        path_dir = os.path.dirname(clean_path)
        if not os.path.exists(path_dir):
            os.makedirs(path_dir, exist_ok=True)
            
        # Write the file in UTF-8
        with open(clean_path, "w", encoding="utf-8") as f:
            f.write(content)
            
        return [True, f"Successfully wrote to {clean_path}"]
    except Exception as e:
        return [False, str(e)]

def heartbeat():
    """Simple check to confirm FBT backend is loaded."""
    return [True, "FBT Python Backend Active"]
