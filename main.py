import csv
from pathlib import Path

folder_path = r"./DataSets"

for csv_file in Path(folder_path).glob("*.csv"):
    print(f"Processing: {csv_file.name}")

    # Read using semicolon delimiter
    with open(csv_file, "r", encoding="utf-8", newline="") as infile:
        reader = csv.reader(infile, delimiter=";")
        rows = list(reader)

    # Write using comma delimiter
    with open(csv_file, "w", encoding="utf-8", newline="") as outfile:
        writer = csv.writer(outfile, delimiter=",")
        writer.writerows(rows)

print("✅ All CSV files converted from ';' to ','.")