import os

output_file = "directory_contents.txt"

with open(output_file, "w", encoding="utf-8") as out:
    for root, dirs, files in os.walk("."):
        for filename in files:
            if filename.lower().endswith(".exe"):  # skip .exe files
                continue
            filepath = os.path.join(root, filename)
            out.write(f"--- {filepath}\n")
            try:
                with open(filepath, "r", encoding="utf-8", errors="replace") as f:
                    contents = f.read()
                out.write(contents + "\n\n")
            except Exception as e:
                out.write(f"[Error reading file: {e}]\n\n")

print(f"Done! File saved as {output_file}")
